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
    printf("|-all]\n");
    printf("%s <имя пользователя>\n", message);
    return i;
}

int MissionAll()
{
    struct passwd* p; struct group* gr; setpwent(); setgrent();
    while ((p = getpwent()) != NULL)
		printf("%s%s |%d\t|%d\t|%s\t|%s\n", p->pw_name,
			strlen(p->pw_name) < 8 ? "\t\t" : (strlen(p->pw_name) < 16 ? "\t" : ""),
			p->pw_uid, p->pw_gid, p->pw_dir, p->pw_shell);
    printf("\n\n");
    while ((gr = getgrent()) != NULL)
    {
        printf("%s%s |%d\t", gr->gr_name, 
			strlen(gr->gr_name) < 8 ? "\t\t" : (strlen(gr->gr_name) < 16 ? "\t" : ""), gr->gr_gid);
        for (int i = 0; gr->gr_mem[i] != NULL; i++) printf("|%s ", gr->gr_mem[i]); printf("\n");
    }
    endpwent(); endgrent(); return 0;
}

int MissionUser(char* username)
{
    struct passwd* pw = getpwnam(username);
    if (!pw) { printf("нету такого пользоватиля\n"); return 1; }

    struct group* gr; int group_lenth = 0;
    while ((gr = getgrent()) != NULL) group_lenth++;
    
    int groups[group_lenth];
    
    int group_count = 0; groups[group_count++] = pw->pw_gid;
    
    struct passwd* p; setgrent(); setpwent();
    
    char* grm[group_lenth + 1]; int grmid[group_lenth + 1];
    
    int y = 0;
    while ((gr = getgrent()) != NULL)
    {
		grm[y] = (char*)malloc((strlen(gr->gr_name) + 1) * sizeof(char));
		grmid[y] = gr->gr_gid; int l = 0; strcpy(grm[y], gr->gr_name); y++;
		
		for (int i = 0; gr->gr_mem[i] != NULL; i++)
		{ if (!strcmp(gr->gr_mem[i], username)) { groups[group_count++] = gr->gr_gid; } }
	}
    endgrent();
    
    while ((p = getpwent()) != NULL)
    {
        if (strcmp(p->pw_name, username) == 0) continue;
        int shared = 0;
        char** k = (char**)malloc((group_lenth + 1) * sizeof(char*)); int l = 0;
        for (int i = 0; i < group_count; i++)
        {
			if (p->pw_gid == groups[i])
			{
				shared = 1;
				for (int p = 0; p < group_lenth; p++)
				{
					if (groups[i] == grmid[p]) { k[l] = grm[p]; l++; break; }
				}
			}
		}

        setgrent();
        while ((gr = getgrent()) != NULL)
        {
            for (int i = 0; gr->gr_mem[i] != NULL; i++)
            {
                for (int j = 0; j < group_count && !strcmp(gr->gr_mem[i], p->pw_name); j++)
                {
					if (gr->gr_gid == groups[j])
					{
						shared = 1;
						for (int p = 0; p < group_lenth; p++)
						{
							if (groups[j] == grmid[p]) { k[l] = grm[p]; l++; break; }
						}
					}
				}
            }
        }
        endgrent();

        if (shared)
        {
			printf("%s%s | Группы: ", p->pw_name,
				strlen(p->pw_name) < 8 ? "\t\t" : (strlen(p->pw_name) < 16 ? "\t" : ""));
			for (int i = 0; i < l; i++) printf("%s%s", k[i], i == l - 1 ? "" : ", ");
			printf("\n");
		}
		free(k);
	}
	for (int i = 0; i < group_lenth; i++) free(grm[i]);
    endpwent(); return 0;
}





int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);

    if (!strcmp(argv[1], "-all")) return MissionAll();
    
    return MissionUser(argv[1]);
}
