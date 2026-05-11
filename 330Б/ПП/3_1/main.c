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

//#include <limits.h>
//#include <fcntl.h>

int MissionHelp(int i, char* message);
int MissionAll();
int MissionUser(char* username);
int MissionDir(char* dir, int line, int lock);
int MissionCopy(char* src, char* dest);

char* addstr(char* a, char* b);
void printRights(int r, int t);
void printSpecialRights(int r, int t);
int strToInt(char* str);

int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (argv[1][0] != '-')        return MissionUser(argv[1]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);
    if (!strcmp(argv[1], "-all")) return MissionAll();
    if (!strcmp(argv[1], "-n"))   return MissionUser(argv[2]);
    if (!strcmp(argv[1], "-d"))   return MissionDir(argv[2], 0, -1);
    if (!strcmp(argv[1], "-dl"))  return MissionDir(argv[2], 0, argc > 3 ? strToInt(argv[3]) : 0);
    if (!strcmp(argv[1], "-c"))   return MissionCopy(argv[2], argv[3]);
    return MissionHelp(1, argv[0]);
}

int MissionHelp(int i, char* message) { printf("%s [-h|-all|-n|-d|-dl|-c] [-n <имя пользователя>] [-d <имя каталога>] [-dl <имя каталога> <глубина>] [-c <исходный каталог> <целевой каталог>]\n", message); return i; }

int MissionAll()
{
    struct passwd* p; struct group* gr; setpwent(); setgrent();
    while ((p = getpwent()) != NULL) printf("%s\t|%d\t|%d\t|%s\t|%s\n", p->pw_name, p->pw_uid, p->pw_gid, p->pw_dir, p->pw_shell);
    printf("\n\n");
    while ((gr = getgrent()) != NULL)
    { printf("%s\t|%d\t", gr->gr_name, gr->gr_gid); for (int i = 0; gr->gr_mem[i] != NULL; i++) printf("|%s\t", gr->gr_mem[i]); printf("\n"); }
    endpwent(); endgrent(); return 0;
}

int MissionUser(char* username)
{
    struct passwd* pw = getpwnam(username);
    if (!pw) { printf("нету такого пользоватиля\n"); return 1; }

    gid_t groups[getgroups(0, NULL)];
    int group_count = 0; groups[group_count++] = pw->pw_gid;
    struct group* gr; struct passwd* p; setgrent(); setpwent();

    while ((gr = getgrent()) != NULL) { for (char** m = gr->gr_mem; *m; m++) { if (!strcmp(*m, username)) { groups[group_count++] = gr->gr_gid; break; } } }
    endgrent();

    while ((p = getpwent()) != NULL)
    {
        if (strcmp(p->pw_name, username) == 0) continue;
        int shared = 0; for (int i = 0; i < group_count; i++) { if (p->pw_gid == groups[i]) { shared = 1; break; } }

        setgrent();
        while ((gr = getgrent()) != NULL && !shared)
        {
            for (char** m = gr->gr_mem; *m; m++)
            {
                for (int i = 0; i < group_count && !strcmp(*m, p->pw_name); i++) { if (gr->gr_gid == groups[i]) { shared = 1; break; } }
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

int MissionCopy(char* src, char* dest)
{


    return 0;

    //struct stat st; DIR* dir; struct dirent* entry;

    // Получаем информацию об исходном каталоге
    //if (lstat(src, &st) == -1) { perror(src); return 0; }

    // Создаем каталог назначения
    //if (mkdir(dest, st.st_mode & 07777) == -1 && errno != EEXIST) { perror(dest); return 0; }

    // Устанавливаем права как у исходного каталога
    //chmod(dest, st.st_mode & 07777);

    //dir = opendir(src);
    //if (dir == NULL) { perror(src); return 0; }

    //while ((entry = readdir(dir)) != NULL)
    //{
        //char src_path[5000]; char dst_path[5000]; struct stat item_st;

        // Пропускаем "." и ".."
        //if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) continue;

        //snprintf(src_path, sizeof(src_path), "%s/%s", src, entry->d_name);
        //snprintf(dst_path, sizeof(dst_path), "%s/%s", dest, entry->d_name);

        //if (lstat(src_path, &item_st) == -1) { perror(src_path); continue; }

        // Каталог
        //if (S_ISDIR(item_st.st_mode)) { MissionCopy(src_path, dst_path); }
        // Символическая ссылка
        //else if (S_ISLNK(item_st.st_mode))
        //{
            //char buf[5000];
            //ssize_t len;

            //len = readlink(src_path, buf, sizeof(buf) - 1);
            //if (len == -1) { perror(src_path); continue; }

            //buf[len] = '\0';

            //if (symlink(buf, dst_path) == -1) { perror(dst_path); }
        //}
        // Обычный файл
        //else if (S_ISREG(item_st.st_mode))
        //{
            //int fd = open(dst_path, O_WRONLY | O_CREAT | O_TRUNC, item_st.st_mode & 07777);
            //if (fd == -1) { perror(dst_path); continue; }
            //close(fd);

            //chmod(dst_path, item_st.st_mode & 07777);
        //}
        // Другие типы файлов -> пустой обычный файл
        //else
        //{
            //int fd = open(dst_path, O_WRONLY | O_CREAT | O_TRUNC, item_st.st_mode & 07777);
            //if (fd == -1) { perror(dst_path); continue; }
            //close(fd);

            //chmod(dst_path, item_st.st_mode & 07777);
        //}
    //}
    //closedir(dir);
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