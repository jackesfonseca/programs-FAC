.data

is_not_prime:	.asciiz "O modulo nao eh primo"
is_prime:	.asciiz "O modulo eh primo"
new_line:	.asciiz "\n"

.text
	
main:
	# Armazena o m�dulo em $s0
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	li $t3, 2	# Valor inicial para ser usado no processo
	
	# Excluir valores menores ou iguais a 1
	blt $t2, 2, isNotPrime
	
	loopPrime:
		beq $t3, $t2, isPrime	# Se o valor de entrada for igual ao contador sai do la�o
		div $t2, $t3		# Divis�es sucessivas do m�dulo lido pelo contador
		mfhi $t4,		# Armazena o resto da divis�o no registador $t4
		beq $t4, 0, isNotPrime	# Se o resto da divis�o for igual a zero n�o � um n�mero primo
		addi $t3, $t3, 1	# Incrementa o contador
		
		j loopPrime
	# Label � primo
	isPrime:
	
		# Imprime mensagem ao usu�rio
		li $v0, 4
		la $a0, is_prime
		syscall
	
		j exit
	
	# Label n�o � primo
	isNotPrime: 
	
		# Imprime mensagem ao usu�rio
		li $v0, 4
		la $a0, is_not_prime
		syscall
	
	exit:
	
		# Encerra o programa
		li $v0, 10
		syscall