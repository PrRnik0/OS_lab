#ifndef FACTORIAL_H
#define FACTORIAL_H

#include <semaphore.h>

#define SHM_NAME "/factorial_shm"
#define SEM_NAME "/factorial_sem"

typedef struct {
    int number;
    int result;
    int is_ready;
} SharedData;

int factorial(int n);
void calculate_factorial_parallel(int n);

#endif