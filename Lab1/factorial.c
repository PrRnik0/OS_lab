#include <stdio.h>

int factorial(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main() {
    int number;
    printf("Введите число для вычисления факториала: ");
    scanf("%d", &number);
    
    printf("Факториал %d равен %d\n", number, factorial(number));
    return 0;
}