.data
numero: .asciiz "Ingrese un numero para saber su factorial: "

.text
.globl main
main:

li                    $v0, 4
la                    $a0, numero     # lee y guarda el numero ingresado
syscall

li                    $v0, 5
syscall
move                  $a0, $v0        # mueve a a0 lo que esta en v0
jal factorial	                        # llama a factorial


move                  $a0, $v0
li                    $v0, 1          # imprime resultado
syscall

#fin del programa
li                    $v0, 10
syscall

factorial:

# prologo
addi                  $sp, $sp, -12	  # hacemos espacio para 12 lugares
sw                    $a0, 0($sp)
sw                    $t2, 4($sp)
sw                    $ra, 8($sp)
# fin del prologo

# caso base
li                    $t0, 1          # cargo 1 para el beq
beq                   $a0, $t0, f1   	# si n = 1, caso base
beq                   $a0, $zero, f1	# si n = 0, expulsa 1


# no estamos en caso base
move                  $t2, $a0              # t2 = a0
addi                  $a0, $a0, -1	        # n - 1
jal factorial		                            # factorial(n-1)
move                  $t1, $v0		          # t1 = factorial(n-1)
mul                   $v0, $t1, $t2	        # t1*t2
j return


f1:
li                    $v0, 1                # valor de return caso base
j return


return:

# epilogo
lw                    $a0, 0($sp)         #pullear stack frame
lw                    $t2, 4($sp)
lw                    $ra, 8($sp)
addi                  $sp, $sp, 12
# fin del epilogo

jr                    $ra                 #return
