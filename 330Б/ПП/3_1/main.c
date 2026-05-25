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

char* addstr(char* a, char* b);
void printRights(int r, int t);
void printSpecialRights(int r, int t);
int strToInt(char* str);

int rl(char* f, char* buf, int line);
void sl(char* buf, char* f);
void crf(char* f);
void ch(char* f, int mode);
void cr(char* f, struct stat filedata);



int MissionHelp(int i, char* message)
{
    printf("%s [", message); printf("-h");
    printf("|-all|-n");
    printf("|-d|-dl");
    printf("|-c|-cl");
    printf("]\n");
    printf("[-n <имя пользователя>]\n");
    printf("[-d <имя каталога>] [-dl <имя каталога> <глубина>]\n");
    printf("[-c <исходный каталог> <целевой каталог>] [-cl <исходный каталог> <целевой каталог> <глубина>]\n");
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

int MissionDir(char* dir, int line, int lock)
{
    if (lock != -1) { if (line > lock) return 0; }

    DIR* dir1;
    if (!(dir1 = opendir(dir))) { printf("%s\nERROR: %i: %s\n", dir, errno, strerror(errno)); closedir(dir1); return errno; }

    struct dirent* ent; struct stat filedata;
    while ((ent = readdir(dir1)) != NULL)
    {
        if (strcmp(ent->d_name, ".") && strcmp(ent->d_name, ".."))
        {
            int ldir = strlen(dir);
            char* p = dir[ldir - 1] != '/' ? addstr(dir, "/") : dir; char* path = addstr(p, ent->d_name);
            printf("Файл: %s | тип: ", path);
            int typedir = 0;
            switch (ent->d_type)
            {
            case DT_UNKNOWN: typedir = 0; printf("Неизвестен\n");            break;
            case DT_FIFO:    typedir = 1; printf("FIFO\n");                  break;
            case DT_CHR:     typedir = 2; printf("Символьное устройство\n"); break;
            case DT_DIR:     typedir = 3; printf("Папка\n");                 break;
            case DT_BLK:     typedir = 4; printf("Блочное Устройство\n");    break;
            case DT_REG:     typedir = 5; printf("Файл\n");                  break;
            case DT_LNK:     typedir = 6; printf("Символическая ссылка\n");  break;
            case DT_SOCK:    typedir = 7; printf("Сокет\n");                 break;
            case DT_WHT:     typedir = 8; printf("WHT\n");                   break;
            }

            if (stat(path, &filedata) == 0)
            {
                struct group* groupstr = getgrgid(filedata.st_gid);
                struct passwd* userstr = getpwuid(filedata.st_uid);
                printf("Владелец: %s(%i) | ", userstr->pw_name, filedata.st_uid);
                printf("Группа: %s(%i)\n", groupstr->gr_name, filedata.st_gid);
                int rights = filedata.st_mode % (int)powf(8, 4);
                printf("Владелец: \t");      printRights(rights % 8, typedir);
                printf("\nГруппа: \t");      printRights(rights % (int)powf(8, 2) / 8, typedir);
                printf("\nОстальные: \t");   printRights(rights % (int)powf(8, 3) / (int)powf(8, 2), typedir);
                printf("\nСпециальные: \t"); printSpecialRights(rights / (int)powf(8, 3), typedir); printf("\n");
            }
            else { printf("ERROR: %i: %s\n", errno, strerror(errno)); errno = 0; printf("\n"); }

            char* s = dir[ldir - 1] != '/' ? addstr(dir, "/") : dir; char* s1 = addstr(s, ent->d_name);
            free(path); if (dir[ldir - 1] != '/') { free(p); free(s); } printf("\n");
            if (typedir == 3) MissionDir(s1, line + 1, lock);
            free(s1);
        }
    }
    closedir(dir1); return 0;
}

int MissionCopy(char* src, char* dest, int line, int lock)
{
    printf("%i %s", line, src); if (lock != -1) { if (line > lock) { printf(" -> В не доступа\n"); return 0; } }
    printf(" -> %s\n", dest);

    struct stat filedata; struct group* groupstr; struct passwd* userstr; int action = -1; int filetype = 0; char buf[4096];
    int s = stat(src, &filedata); if (s == 0) filetype = filedata.st_mode / 4096;
    switch (filetype)
    {
    case DT_UNKNOWN: case DT_FIFO: case DT_CHR: case DT_BLK: case DT_SOCK: case DT_WHT: action = 0; break;
    case DT_DIR: action = 1; break; case DT_REG: action = 3; break; case DT_LNK: action = 2; break;
    }
    if (s == 0)
    {
        groupstr = getgrgid(filedata.st_gid); userstr = getpwuid(filedata.st_uid);
        if (action == 2)
        {
            int last = rl(src, buf, 4095); if (last > 0) { buf[last] = '\0'; sl(buf, dest); }
        }
        else if (action == 3)
        {
            int readamount = 1; FILE* source; FILE* target; crf(dest);
            source = fopen(src, "r"); target = fopen(dest, "w");
            while (readamount > 0) { readamount = fread(buf, 1, 4096, source); fwrite(buf, readamount, 1, target); }
            fclose(source); fclose(target);
            ch(dest, filedata.st_mode % (int)powf(8, 5));
            if (chown(dest, filedata.st_uid, filedata.st_gid) < 0) { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
        else if (action == 1)
        {
            mkdir(dest, 0700); DIR* basedir = opendir(src);
            if (!basedir) { printf("1 ERROR: %i: %s\n", errno, strerror(errno)); errno = 0; printf("\n"); closedir(basedir); return 1; }
            if (access(src, 1)) { printf("Предуприждение: Нельзя открыть!\n"); }
            struct dirent* dirlist = readdir(basedir);
            while (dirlist)
            {
                if (strcmp(dirlist->d_name, ".") && strcmp(dirlist->d_name, ".."))
                {
                    int lsrc = strlen(src); int ldest = strlen(dest);
                    char* str = src[lsrc - 1] != '/' ? addstr(src, "/") : src; char* str2 = addstr(str, dirlist->d_name);
                    char* str3 = dest[ldest - 1] != '/' ? addstr(dest, "/") : dest; char* str4 = addstr(str3, dirlist->d_name);
                    if (src[lsrc - 1] != '/') free(str); if (dest[ldest - 1] != '/') free(str3);
                    MissionCopy(str2, str4, line + 1, lock); free(str2); free(str4);
                }
                dirlist = readdir(basedir);
            }
            closedir(basedir); ch(dest, filedata.st_mode % (int)powf(8, 5));
            if (chown(dest, filedata.st_uid, filedata.st_gid) < 0) { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
        else if (action == 0)
        {
            cr(dest, filedata); if (chown(dest, filedata.st_uid, filedata.st_gid) < 0) { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
    }
    else { printf("2 ERROR: %i: %s\n", errno, strerror(errno)); errno = 0; printf("\n"); }

    return 0;
}





int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);

    if (!strcmp(argv[1], "-all")) return MissionAll();
    if (!strcmp(argv[1], "-n"))   return MissionUser(argv[2]);
    
    if (!strcmp(argv[1], "-d"))   return MissionDir(argv[2], 0, -1);
    if (!strcmp(argv[1], "-dl"))  return MissionDir(argv[2], 0, argc > 3 ? strToInt(argv[3]) : 0);
    
    if (!strcmp(argv[1], "-c"))   return MissionCopy(argv[2], argv[3], 0 , -1);
    if (!strcmp(argv[1], "-cl"))  return MissionCopy(argv[2], argv[3], 0, argc > 4 ? strToInt(argv[4]) : 0);
    
    return MissionHelp(1, argv[0]);
}





void printSpecialRights(int r, int t)
{
    if (!r) return;
	int b1 = r / 4, b2 = r / 2 % 2, b3 = r % 2;
    if (t == 3)
    {
        if (b1) { printf("Исполнять от пользователя"); if (b2 || b3) printf(", "); }
        if (b2) { printf("Исполнять от группы"); if (b3) printf(", "); }
        if (b3) printf("Ограничить удаление");
    }
    else
    {
        if (b1) { printf("Исполнять от пользователя"); if (b2 || b3) printf(", "); }
        if (b2) { printf("Исполнять от группы"); if (b3) printf(", "); }
        if (b1) printf("Сохранять в оперативной памяти");
    }
}

void printRights(int r, int t)
{
    if (!r) { printf("Нет Прав"); return; }
    int b1 = r / 4, b2 = r / 2 % 2, b3 = r % 2;
    if (b1) { printf("Чтение"); if (b2 || b3) printf(", "); }
    if (b2) { printf("Запись"); if (b3) printf(", "); }
    if (b3) printf(t == 3 ? "Поиск" : "Исполнение");
}

char* addstr(char* a, char* b)
{
	int la = strlen(a), lb = strlen(b); char* res = (char*)malloc((la + lb + 1) * sizeof(char));
    for (int i = 0; i < la; i++) res[i] = a[i]; for (int i = 0; i < lb; i++) res[la + i] = b[i];
    res[la + lb] = '\0'; return res;
}

int strToInt(char* str) { int res = 0; for (int i = 0; str[i]; i++) res = res * 10 + (str[i] - '0'); return res; }



int rl(char* f, char* buf, int line)
{
    int i = 0; FILE* file = fopen(f, "r"); if (file) { i = fread(buf, 1, 4096, file); fclose(file); } return i;
}

void sl(char* buf, char* f)
{
    FILE* file = fopen(f, "w"); if (file) { fputs(buf, file); fclose(file); }
}

void crf(char* f)
{
    FILE* file = fopen(f, "w"); if (file) { fclose(file); }
}

void ch(char* f, int mode)
{
    FILE* file = fopen(f, "r"); if (file) { fprintf(file, "%o\n", mode); fclose(file); }
}

void cr(char* f, struct stat filedata)
{
    FILE* file = fopen(f, "w"); if (file) { fclose(file); chown(f, filedata.st_uid, filedata.st_gid); }
}