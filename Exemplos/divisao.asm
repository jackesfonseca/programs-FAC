.data
lo:		.asciiz "quociente = "
hi:		.asciiz "resto = "
new_line:	.asciiz "\n"	

.text

main:
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $s2, 2	# carrega o valor 2 no registrador $s2
	
	# realiza a divisão
	div $s0, $s2
	mflo $t0	# quociente da divisão
	mfhi $t1	# resto da divisão
	
	add $t3, $zero, $zero	# inicializa o contador com zero
	loop:
		beq $t3, $t0, exit
		
		li $v0, 1
		move $a0, $t3
		syscall
		
		addi $t3, $t3, 1
		
		j loop
	
	
	exit: 
		# imprime os resultados
		li $v0, 4
		la $a0, lo
		syscall
	
		li $v0, 1
		move $a0, $t0
		syscall
	
		li $v0, 4
		la $a0, new_line
		syscall
	
		li $v0, 4
		la $a0, hi
		syscall
	
		li $v0, 1
		move $a0, $t1
		syscall
	
		li $v0, 4
		la $a0, new_line
		syscall

		li $v0, 10
		syscall