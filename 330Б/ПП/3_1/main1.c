#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pwd.h>
#include <grp.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <errno.h>
#include <math.h>

int MissionHelp(int i, char* message)
{
    printf("%s [", message); printf("-h");
    printf("|-all|-n");
    printf("]\n");
    printf("[-n <имя пользователя>]\n");
    return i;
}

int MissionAll()
{
    struct passwd* p; struct group* gr; setpwent(); setgrent();
    while ((p = getpwent()) != NULL) printf("%s\t|%d\t|%d\t|%s\t|%s\n", p->pw_name, p->pw_uid, p->pw_gid, p->pw_dir, p->pw_shell);
    printf("\n\n");
    while ((gr = getgrent()) != NULL)
    {
        printf("%s\t|%d\t", gr->gr_name, gr->gr_gid); for (int i = 0; gr->gr_mem[i] != NULL; i++) printf("|%s\t", gr->gr_mem[i]); printf("\n");
    }
    endpwent(); endgrent(); return 0;
}

int MissionUser(char* username)
{
    struct passwd* pw = getpwnam(username);
    if (!pw) { printf("нету такого пользоватиля\n"); return 1; }

    gid_t groups[getgroups(0, NULL)];
    int group_count = 0; groups[group_count++] = pw->pw_gid;
    struct group* gr; struct passwd* p; setgrent(); setpwent();

    while ((gr = getgrent()) != NULL) { for (int i = 0; gr->gr_mem[i] != NULL; i++) { if (!strcmp(gr->gr_mem[i], username)) { groups[group_count++] = gr->gr_gid; break; } } }
    endgrent();

    while ((p = getpwent()) != NULL)
    {
        if (strcmp(p->pw_name, username) == 0) continue;
        int shared = 0; for (int i = 0; i < group_count; i++) { if (p->pw_gid == groups[i]) { shared = 1; break; } }

        setgrent();
        while ((gr = getgrent()) != NULL && !shared)
        {
            for (int i = 0; gr->gr_mem[i] != NULL; i++)
            {
                for (int j = 0; j < group_count && !strcmp(gr->gr_mem[i], p->pw_name); j++) { if (gr->gr_gid == groups[j]) { shared = 1; break; } }
            }
        }
        endgrent();

        if (shared) printf("%s\n", p->pw_name);
    }
    endpwent(); return 0;
}





int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);

    if (!strcmp(argv[1], "-all")) return MissionAll();
    if (!strcmp(argv[1], "-n"))   return MissionUser(argv[2]);
    
    return MissionHelp(1, argv[0]);
}