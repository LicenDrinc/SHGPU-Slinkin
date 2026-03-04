#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pwd.h>
#include <grp.h>
#include <unistd.h>
#include <dirent.h>

int MissionHelp(int i);
int MissionAll();
int MissionUser(char* username);
int MissionDir(char* dir);

int main(int argc, char* argv[])
{
    if (argc < 2) return MissionHelp(1);
    if (argv[1][0] == '-')
    {
        if (!strcmp(argv[1], "-h")) return MissionHelp(0);
        if (!strcmp(argv[1], "-all")) return MissionAll();
        if (!strcmp(argv[1], "-n")) return MissionUser(argv[2]);
        if (!strcmp(argv[1], "-d")) return MissionDir(argv[2]);
        return MissionHelp(1);
    }
    else return MissionUser(argv[1]);
    return 0;
}

int MissionHelp(int i)
{
    printf("./main [-h|-all|-n|-d] [-n <имя пользователя>] [-d <имя каталога>]\n");
    return i;
}

int MissionAll()
{
    struct passwd* p; struct group* gr;
    setpwent(); setgrent();

    while ((p = getpwent()) != NULL)
        printf("%s\t|%d\t|%d\t|%s\t|%s\n",
            p->pw_name, p->pw_uid, p->pw_gid, p->pw_dir, p->pw_shell);
    printf("\n\n");
    while ((gr = getgrent()) != NULL)
    {
        printf("%s\t|%d\t", gr->gr_name, gr->gr_gid);
        for (int i = 0; gr->gr_mem[i] != NULL; i++) printf("|%s\t", gr->gr_mem[i]);
        printf("\n");
    }

    endpwent(); endgrent();
    return 0;
}

int MissionUser(char* username)
{
    struct passwd* pw = getpwnam(username);
    if (!pw) { printf("нету такого пользоватиля\n"); return 1; }

    gid_t groups[getgroups(0, NULL)];
    int group_count = 0;

    groups[group_count++] = pw->pw_gid;

    struct group* gr; struct passwd* p;
    setgrent(); setpwent();

    while ((gr = getgrent()) != NULL)
    {
        for (char** m = gr->gr_mem; *m; m++)
        {
            if (!strcmp(*m, username))
            {
                groups[group_count++] = gr->gr_gid; break;
            }
        }
    }
    endgrent();

    while ((p = getpwent()) != NULL)
    {
        if (strcmp(p->pw_name, username) == 0) continue;

        int shared = 0;

        for (int i = 0; i < group_count; i++)
        {
            if (p->pw_gid == groups[i]) { shared = 1; break; }
        }

        setgrent();
        while ((gr = getgrent()) != NULL && !shared)
        {
            for (char** m = gr->gr_mem; *m; m++)
            {
                for (int i = 0; i < group_count && !strcmp(*m, p->pw_name); i++)
                {
                    if (gr->gr_gid == groups[i])
                    {
                        shared = 1; break;
                    }
                }
            }
        }
        endgrent();

        if (shared) printf("%s\n", p->pw_name);
    }
    endpwent();
    return 0;
}

int MissionDir(char* dir)
{
    

    return 0;
}
