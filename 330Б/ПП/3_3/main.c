#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/file.h>
#include <fcntl.h>

#define MAX_SERVERS 1000
#define MAX_NAME 2560

typedef struct { char name[MAX_NAME]; int count; } ServerStat;

int FindServer(ServerStat* stats, int n, char* name)
{
    for (int i = 0; i < n; i++) if (strcmp(stats[i].name, name) == 0) return i;
    return -1;
}

int ChekResurs(char* filename, ServerStat* stats)
{
    FILE* f = fopen(filename, "r"); if (!f) { perror(filename); return 0; }

    char line[4096]; int count = 0; fgets(line, sizeof(line), f);

    while (fgets(line, sizeof(line), f))
    {
        char* token = strtok(line, ";"); int field = 0; char server[MAX_NAME] = "";

        while (token)
        {
            if (field == 4)
            {
                strncpy(server, token, MAX_NAME - 1);

                if (server[0] == '"') memmove(server, server + 1, strlen(server));
                int len = strlen(server); if (len > 0 && server[len - 1] == '"') server[len - 1] = '\0';

                break;
            }
            token = strtok(NULL, ";"); field++;
        }
        if (strlen(server) == 0) continue;

        int idx = FindServer(stats, count, server);
        if (idx == -1) { strcpy(stats[count].name, server); stats[count].count = 1; count++; } else stats[idx].count++;
    }
    fclose(f); return count;
}

void PrintResult(char* rf, ServerStat* localStats, int localCount)
{
    int fd = open(rf, O_RDWR | O_CREAT, 0777);
    if (fd < 0) { perror("open result"); exit(1); }

    flock(fd, LOCK_EX); FILE* f = fdopen(fd, "r+");

    ServerStat inFile[MAX_SERVERS]; int inFileCount = 0;
    char name[MAX_NAME]; int cnt;

    while (fscanf(f, "%255s %d", name, &cnt) == 2) { strcpy(inFile[inFileCount].name, name); inFile[inFileCount].count = cnt; inFileCount++; }

    for (int i = 0; i < localCount; i++)
    {
        int idx = FindServer(inFile, inFileCount, localStats[i].name);
        if (idx == -1) { strcpy(inFile[inFileCount].name, localStats[i].name); inFile[inFileCount].count = localStats[i].count; inFileCount++; }
        else inFile[idx].count += localStats[i].count;
    }

    rewind(f); ftruncate(fd, 0);
    for (int i = 0; i < inFileCount; i++) fprintf(f, "%s %d\n", inFile[i].name, inFile[i].count);
    fflush(f); flock(fd, LOCK_UN); fclose(f);
}

int main(int argc, char* argv[])
{
    if (argc < 3) { printf("%s result.txt resurs1.csv ...\n", argv[0]); return 1; }

    char* result_file = argv[1];
    for (int i = 2; i < argc; i++)
    {
        pid_t pid = fork();
        if (pid == 0) { ServerStat stats[MAX_SERVERS]; int count = ChekResurs(argv[i], stats); PrintResult(result_file, stats, count); exit(0); }
    }

    while (wait(NULL) > 0); return 0;
}