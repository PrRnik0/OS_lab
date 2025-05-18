#include <stdio.h>
#include "factorial.h"

int main() {
    int number;
    printf("Введите число для вычисления факториала: ");
    scanf("%d", &number);
    
    printf("Факториал %d равен %d\n", number, factorial(number));
    return 0;
}