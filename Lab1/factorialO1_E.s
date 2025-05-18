.file	"factorial.c"       # Исходный файл - factorial.c
.text                     # Начало секции кода
.globl	factorial          # Делаем factorial видимой для линкера
.def	factorial; .scl 2; .type 32; .endef  # Метаданные для функции
.seh_proc	factorial    # Начало функции с обработкой SEH (Windows)
factorial:                # Метка начала функции factorial
.seh_endprologue          # Конец пролога SEH
cmpl	$1, %ecx         # Сравниваем входной аргумент (n) с 1
jle	.L4                # Если n <= 1, переходим на метку .L4
addl	$1, %ecx         # Увеличиваем n на 1 (для оптимизации цикла)
movl	$2, %eax         # Инициализируем счетчик (i=2)
movl	$1, %edx         # Инициализируем результат (result=1)
.p2align 4               # Выравнивание для оптимизации цикла
.L3:                     # Начало цикла
imull	%eax, %edx      # Умножаем result на i
addl	$1, %eax         # Увеличиваем i на 1
cmpl	%ecx, %eax       # Сравниваем i с n+1
jne	.L3                # Если i != n+1, продолжаем цикл
.L1:                     # Метка выхода из функции
movl	%edx, %eax       # Переносим результат в eax (возвращаемое значение)
ret                      # Возврат из функции
.L4:                     # Метка для случая n <= 1
movl	$1, %edx         # Устанавливаем result = 1
jmp	.L1                # Переходим к выходу из функции
.seh_endproc             # Конец функции для SEH

.section .rdata,"dr"     # Секция read-only данных
.align 8                 # Выравнивание 8 байт
.LC0:                    # Метка для строки приглашения
.ascii "Введите число для вычисления факториала: \0"  # Текст приглашения
.LC1:                    # Метка для строки формата ввода
.ascii "%d\0"            # Формат для scanf
.align 8                 # Выравнивание 8 байт
.LC2:                    # Метка для строки вывода
.ascii "Факториал %d равен %d\12\0"  # Формат для printf

.text                    # Секция кода
.globl	main             # Делаем main видимой для линкера
.def	main; .scl 2; .type 32; .endef  # Метаданные для функции
.seh_proc	main        # Начало main с обработкой SEH
main:                    # Метка начала функции main
pushq	%rbx            # Сохраняем регистр rbx в стеке
.seh_pushreg	%rbx     # Информируем SEH о сохранении регистра
subq	$48, %rsp       # Выделяем 48 байт на стеке
.seh_stackalloc	48      # Информируем SEH о выделении стека
.seh_endprologue        # Конец пролога SEH
call	__main          # Инициализация среды выполнения (для MinGW)
leaq	.LC0(%rip), %rcx # Загружаем адрес строки приглашения
call	printf          # Вызываем printf
leaq	44(%rsp), %rdx  # Загружаем адрес переменной для scanf
leaq	.LC1(%rip), %rcx # Загружаем адрес строки формата "%d"
call	scanf           # Вызываем scanf
movl	44(%rsp), %ebx  # Загружаем введенное значение в ebx
movl	%ebx, %ecx      # Передаем его как аргумент в factorial
call	factorial       # Вызываем factorial
movl	%eax, %r8d      # Сохраняем результат factorial
movl	%ebx, %edx      # Загружаем исходное число для printf
leaq	.LC2(%rip), %rcx # Загружаем адрес строки формата вывода
call	printf          # Выводим результат
movl	$0, %eax        # Устанавливаем возвращаемое значение 0
addq	$48, %rsp       # Освобождаем стек
popq	%rbx            # Восстанавливаем регистр rbx
ret                     # Выход из main
.seh_endproc            # Конец функции для SEH

.def	__main; .scl 2; .type 32; .endef  # Метаданные для __main
.ident	"GCC: (GNU) 15.1.0"  # Информация о компиляторе
.def	printf; .scl 2; .type 32; .endef  # Метаданные для printf
.def	scanf; .scl 2; .type 32; .endef   # Метаданные для scanf