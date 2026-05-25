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



int MissionHelp(int i, char* message)
{
    printf("%s [", message); printf("-h");
    printf("|-d|-dl");
    printf("]\n");
    printf("[-d <имя каталога>] [-dl <имя каталога> <глубина>]\n");
    return i;
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





int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);
    
    if (!strcmp(argv[1], "-d"))   return MissionDir(argv[2], 0, -1);
    if (!strcmp(argv[1], "-dl"))  return MissionDir(argv[2], 0, argc > 3 ? strToInt(argv[3]) : 0);
    
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