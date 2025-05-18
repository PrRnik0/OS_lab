#include "factorial.h"
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int factorial(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

void calculate_factorial_parallel(int n) {
    int shm_fd = shm_open(SHM_NAME, O_CREAT | O_RDWR, 0666);
    ftruncate(shm_fd, sizeof(SharedData));
    SharedData *shared_data = mmap(NULL, sizeof(SharedData), PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    
    sem_t *sem = sem_open(SEM_NAME, O_CREAT, 0666, 1);
    
    sem_wait(sem);
    
    shared_data->number = n;
    shared_data->is_ready = 0;
    
    sem_post(sem);
    
    pid_t pid = fork();
    
    if (pid == 0) {
        int res = factorial(n);
        
        sem_wait(sem);
        
        shared_data->result = res;
        shared_data->is_ready = 1;
        
        sem_post(sem);
        
        exit(0);
    } else if (pid > 0) {
        printf("Запущен дочерний процесс для вычисления факториала %d\n", n);
    } else {
        perror("Ошибка при создании процесса");
    }
    
    munmap(shared_data, sizeof(SharedData));
    sem_close(sem);
}