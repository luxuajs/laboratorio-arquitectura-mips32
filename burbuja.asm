#  ---------------------------------------------------------------------------------- 
#               tutorias.co  |  @tutorias
#  ----------------------------------------------------------------------------------

.data
vec:     .word 2,78,9,7,12,95,6,1,3,4   # vector de datos
guion:   .asciiz "-"            # line tomara un guion separador

.text 
.globl main     

main:

li $s1 1            # carga encendido de bandera
li $s3 10           # fin del ciclo for
li $s0 0            # funcionara como bandera
la $t1 vec          # direccion base vec

j while

while:

bne $s0 $zero print
move $s0 $s1
li $s2 0            # incializador controlador ciclo for
j for
    for:
    
    sll $t3 $s2 2       # avance 4 bits en espacio de memoria
    add $t3 $t3 $t1
    lw $t6 0($t3)       # vec[i]
    
    add $s4 $s2 $s1
    sll $t4 $s4 2       # avance 4 bits en espacio de memoria
    add $t4 $t4 $t1
    lw $t7 0($t4)       # vec[i+1]
    
    add $s2 $s2 $s1     # incremento controlador del ciclo
    beq $s2 $s3 while
    
    sle $t0 $t6 $t7
    
    bne $t0 $zero for
    sw $t6 0($t4)
    sw $t7 0($t3)
    move $s0 $zero  
    j for

print:

li $s2 0

forPrint:
    
    sll $t5 $s2 2
    add $t5 $t5 $t1
    lw $t7 0($t5)
    
    move $a0 $t7
    li $v0 1        # carga $v0 a 1: muestra un entero          
    syscall
    
    la $a0 guion        # carga separador
    li $v0 4        # carga $v0 a 4: permite mostrar una cadena
    syscall
    
    add $s2 $s2 $s1
    beq $s2 $s3 fin
    j forPrint

fin:

li $v0 10                       
syscall             # salir 