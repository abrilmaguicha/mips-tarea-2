.data
factorial: .asciiz "Ingrese el numero para saber su factorial:"
n: .asciiz "\n"

.text
.globl main
main:

li                $v0, 4
la                $a0, factorial
syscall                           # lee el numero ingresado

li                $v0, 5
syscall

move              $t0, $v0        #mueve a t0 el numero en v0

li                $v0, 4
la                $a0, n          #n=espacio
syscall

#si el numero es 1 o 0, finalice el programa
beq               $t0, 1, exittwo
beq               $t0, 0, exittwo

#numero - 1 --> en t1
addi              $t1, $t0, -1

jal loop                          #llama a loop

#fin del programa
li                $v0, 10
syscall

loop:
beq               $t1, $zero, exit   #si t0 = 0, el programa debe finalizar
mul               $t0, $t0, $t1      #n° = n° * n° - 1
addi              $t1, $t1, -1
j loop                               #ir al loop

exit:
li                $v0, 1              #imprime el factorial
move              $a0, $t0            #mueve el resultado en t0 a a0
syscall

jr  $ra           #continua con el programa luego del jal

exittwo:                             #fin del programa si el numero es 0 o 1
li                $v0, 1             #imprime
move              $a0, $t0           #mueve a a0 lo que hay en t0
syscall

li                $v0, 10            #termina el programa
syscall
