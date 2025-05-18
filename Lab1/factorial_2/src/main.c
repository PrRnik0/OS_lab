#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include "factorial.h"

int main() {
    int number;
    printf("Введите число для вычисления факториала: ");
    scanf("%d", &number);
    
    calculate_factorial_parallel(number);
    
    int shm_fd = shm_open(SHM_NAME, O_RDWR, 0666);
    SharedData *shared_data = mmap(NULL, sizeof(SharedData), PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    sem_t *sem = sem_open(SEM_NAME, 0);
    
    while (1) {
        sem_wait(sem);
        if (shared_data->is_ready) {
            printf("Факториал %d равен %d (вычислено в параллельном процессе)\n", 
                   shared_data->number, shared_data->result);
            sem_post(sem);
            break;
        }
        sem_post(sem);
        sleep(1);
    }
    
    munmap(shared_data, sizeof(SharedData));
    close(shm_fd);
    sem_close(sem);
    shm_unlink(SHM_NAME);
    sem_unlink(SEM_NAME);
    
    return 0;
}