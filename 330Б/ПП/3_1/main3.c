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
int strToInt(char* str);

int rl(char* f, char* buf, int line);
void sl(char* buf, char* f);
void crf(char* f);
void ch(char* f, int mode);
void cr(char* f, struct stat filedata);



int MissionHelp(int i, char* message)
{
    printf("%s [", message); printf("-h");
    printf("|-cl");
    printf("]\n");
    printf("%s <исходный каталог> <целевой каталог>\n[-cl <исходный каталог> <целевой каталог> <глубина>]\n", message);
    return i;
}

int MissionCopy(char* src, char* dest, int line, int lock)
{
    printf("%i %s", line, src);
    if (lock != -1) { if (line > lock) { printf(" -> В не досступа\n"); return 0; } }
    printf(" -> %s\n", dest);

    struct stat filedata; struct group* groupstr; struct passwd* userstr;
    int action = -1; int filetype = 0; char buf[4096];
    int s = stat(src, &filedata); if (s == 0) filetype = filedata.st_mode / 4096;
    switch (filetype)
    {
		case DT_UNKNOWN: case DT_FIFO: case DT_CHR: case DT_BLK:
		case DT_SOCK: case DT_WHT: action = 0; break;
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
            while (readamount > 0)
            { readamount = fread(buf, 1, 4096, source); fwrite(buf, readamount, 1, target); }
            fclose(source); fclose(target);
            ch(dest, filedata.st_mode % (int)powf(8, 5));
            if (chown(dest, filedata.st_uid, filedata.st_gid) < 0)
            { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
        else if (action == 1)
        {
            mkdir(dest, 0700); DIR* basedir = opendir(src);
            if (!basedir)
            {
				printf("1 ERROR: %i: %s\n", errno, strerror(errno));
				errno = 0; printf("\n"); closedir(basedir); return 1;
			}
            if (access(src, 1)) { printf("Предуприждение: Нельзя открыть!\n"); }
            struct dirent* dirlist = readdir(basedir);
            while (dirlist)
            {
                if (strcmp(dirlist->d_name, ".") && strcmp(dirlist->d_name, ".."))
                {
                    int lsrc = strlen(src); int ldest = strlen(dest);
                    char* str = src[lsrc - 1] != '/' ? addstr(src, "/") : src;
                    char* str2 = addstr(str, dirlist->d_name);
                    char* str3 = dest[ldest - 1] != '/' ? addstr(dest, "/") : dest;
                    char* str4 = addstr(str3, dirlist->d_name);
                    if (src[lsrc - 1] != '/') free(str); if (dest[ldest - 1] != '/') free(str3);
                    MissionCopy(str2, str4, line + 1, lock); free(str2); free(str4);
                }
                dirlist = readdir(basedir);
            }
            closedir(basedir); ch(dest, filedata.st_mode % (int)powf(8, 5));
            if (chown(dest, filedata.st_uid, filedata.st_gid) < 0)
            { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
        else if (action == 0)
        {
            cr(dest, filedata); if (chown(dest, filedata.st_uid, filedata.st_gid) < 0)
            { printf("Ошибка изменения владельца %i, %i!\n", filedata.st_uid, filedata.st_gid); };
        }
    }
    else { printf("2 ERROR: %i: %s\n", errno, strerror(errno)); errno = 0; printf("\n"); }

    return 0;
}





int main(int argc, char* argv[])
{
    if (argc < 2)                 return MissionHelp(1, argv[0]);
    if (!strcmp(argv[1], "-h"))   return MissionHelp(0, argv[0]);
    if (!strcmp(argv[1], "-cl"))
    return MissionCopy(argv[2], argv[3], 0, argc > 4 ? strToInt(argv[4]) : 0);
    
    return MissionCopy(argv[1], argv[2], 0 , -1);
}





char* addstr(char* a, char* b)
{
	int la = strlen(a), lb = strlen(b); char* res = (char*)malloc((la + lb + 1) * sizeof(char));
    for (int i = 0; i < la; i++) res[i] = a[i]; for (int i = 0; i < lb; i++) res[la + i] = b[i];
    res[la + lb] = '\0'; return res;
}

int strToInt(char* str)
{ int res = 0; for (int i = 0; str[i]; i++) res = res * 10 + (str[i] - '0'); return res; }



int rl(char* f, char* buf, int line)
{
    int i = 0; FILE* file = fopen(f, "r");
    if (file) { i = fread(buf, 1, 4096, file); fclose(file); } return i;
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
