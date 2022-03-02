#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <limits.h>

int main(int argc, char *argv[]){
    if(argc < 2){
        printf("Usage:\nrealpath [relative path to file]\n");
        exit(1);
    }
    
    char fullpath[PATH_MAX];

    if(realpath(argv[1], fullpath) != 0){
        printf("%s\n", fullpath);
    } else{
        printf("Invalid path\n");
        exit(1);
    }
    return 0;
}
