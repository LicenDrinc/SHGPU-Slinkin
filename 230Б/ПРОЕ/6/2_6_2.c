#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    if (argc<2)
    {
        printf("not file");
        return 0;
	}
	
    long int width = 0, bytewidth = 0, height = 0, start = 0;
    unsigned char rgb[3]; rgb[2] = 0; rgb[1] = 0; rgb[0] = 255;
    
	FILE* file;
    file = fopen(argv[1], "r+b");
    if (file == NULL)
    {
        printf("NULL");
        return 0;
	}
    
    fseek(file, 10, SEEK_SET);
    fread(&start, 4, 1, file);
    fseek(file, 18, SEEK_SET);
    fread(&width, 4, 1, file);
    fread(&height, 4, 1, file);  
    if (width != height)
    {
        printf("width != height");
        fclose(file);
        return 0;
    }
    
    //printf("%li x %li start at %li\n", width, height, start);
    bytewidth = (width * 3 + 3) - (width * 3 + 3)%4;
    for (int i = 0; i < height; i++){
        fseek(file, start + i * bytewidth + i * 3, SEEK_SET);
        for (int j = 0; j < 3; j++)
			fwrite(&rgb[j], 1, 1, file);
        fseek(file, start + i * bytewidth + (height - i - 1) * 3, SEEK_SET);
        for (int j = 0; j < 3; j++)
			fwrite(&rgb[j], 1, 1, file);
    }
    fclose(file);
}
