.data

is_not_prime:	.asciiz "O modulo nao eh primo"
is_prime:	.asciiz "O modulo eh primo"
invalid_input:	.asciiz "Entradas invalidas."
str1:		.asciiz "A exponencial modular "
str2:		.asciiz " elevado a "
str3:		.asciiz " (mod "
str4:		.asciiz ") eh"
str5:		.asciiz "."
new_line:	.asciiz "\n"

.text
	
main:
	# ***** Entrada de Dados *****
	# Armazena n1 em $t0
	li $v0, 5
	syscall
	
	jal checkInput	# Valida entrada
	
	move $t0, $v0
	
	# ARmazena n2 em $t1
	li $v0, 5
	syscall
	
	jal checkInput	# Valida entrada
	
	move $t1, $v0
	
	# Armazena o módulo em $s0
	li $v0, 5
	syscall
	
	jal checkInput	# Valida entrada
	
	move $t2, $v0
	
	# Excluir valores menores ou iguais a 1
	blt $t2, 2, isNotPrime
	
	li $t3, 2	# Valor inicial para ser usado no processo
	
	loopPrime:
		beq $t3, $t2, isPrime	# Se o valor de entrada for igual ao contador sai do laço
		div $t2, $t3		# Divisões sucessivas do módulo lido pelo contador
		mfhi $t4,		# Armazena o resto da divisão no registador $t4
		beq $t4, 0, isNotPrime	# Se o resto da divisão for igual a zero não é um número primo
		addi $t3, $t3, 1	# Incrementa o contador
		
		j loopPrime
		
	# Label verifica entradas
	checkInput:
		bgt $v0, 65535, invalidInput	# Entrada inválida caso seja maior que 65535
		blt $v0, 1, invalidInput	# Entrada inválida caso seja menor que 1
		
		jr $ra				# Volta para a função chamadora
	
	# Label entrada inválida
	invalidInput:
		li $v0, 4
		la $a0, invalid_input
		syscall
		
		j exit
	
	# Label é primo
	isPrime:
	
		# Imprime mensagem ao usuário
		li $v0, 4
		la $a0, is_prime
		syscall
	
		j exit
	
	# Label não é primo
	isNotPrime: 
	
		# Imprime mensagem ao usuário
		li $v0, 4
		la $a0, is_not_prime
		syscall
	
	exit:
		# Quebra de linha
		li $v0, 4
		la $a0, new_line
		syscall
	
		# Encerra o programa
		li $v0, 10
		syscall