.data

is_not_prime:	.asciiz "O modulo nao eh primo"
is_prime:	.asciiz "O modulo eh primo"
invalid_input:	.asciiz "Entradas invalidas."
str1:		.asciiz "A exponencial modular "
str2:		.asciiz " elevado a "
str3:		.asciiz " (mod "
str4:		.asciiz ") eh "
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
	
	# Armazena o m�dulo em $t2
	li $v0, 5
	syscall
	
	jal checkInput	# Valida entrada
	
	move $t2, $v0
	
	# Se a entrada for igual a 1
	beq $t2, 1, isNotPrime
	
	li $t3, 2	# Valor inicial para ser usado no processo
	div $t2, $t3	# Divide o valor do m�dulo por 2
	mflo $t5	# Pega a metade do n�mero 
	
	loopPrime:
		beq $t3, $t5, isPrime	# Se a metade do n�mero for igual ao contador sai do la�o
		div $t2, $t3		# Divis�es sucessivas do m�dulo lido pelo contador
		mfhi $t4,		# Armazena o resto da divis�o no registador $t4
		beq $t4, 0, isNotPrime	# Se o resto da divis�o for igual a zero n�o � um n�mero primo
		addi $t3, $t3, 1	# Incrementa o contador
		
		j loopPrime
		
	# Label verifica entradas
	checkInput:
		bgt $v0, 65535, invalidInput	# Entrada inv�lida caso seja maior que 65535
		blt $v0, 1, invalidInput	# Entrada inv�lida caso seja menor que 1
		
		jr $ra				# Volta para a fun��o chamadora
	
	# Label entrada inv�lida
	invalidInput:
		li $v0, 4
		la $a0, invalid_input
		syscall
		
		j exit
	
	# Label � primo
	isPrime:
		# Label exponencia��o
		exponenciation:
			la	$t4, ($t1)	# Contador $t4 começa com o valor do expoente
			li	$t5, 1		
		loopExpo:
			beqz 	$t4, calcMod	# Condição de parada eh contador $t4=0
			mul	$t5, $t5, $t0	# Multiplica a base 
			addi	$t4, $t4, -1	
			j	loopExpo 
	
		calcMod:
			div	$t5, $t2	# Divide o resultado da expoenciacao por c
			mfhi	$t6		# Guarda o resto da divisao acima em $t6
	
			j printResults
	
	# Label n�o � primo
	isNotPrime: 
	
		# Imprime mensagem ao usu�rio
		li $v0, 4
		la $a0, is_not_prime
		syscall
		
		j exit
	
	#Label printa resultados
	printResults:
	
		# Printa resultados
		li $v0, 4
		la $a0, str1
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, str2
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0, str3
		syscall
		
		li $v0, 1
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, str4
		syscall
		
		li $v0, 1
		move $a0, $t6
		syscall
		
		li $v0, 4
		la $a0, str5
		syscall
	
	exit:

		# Quebra de linha
		li $v0, 4
		la $a0, new_line
		syscall
	
		# Encerra o programa
		li $v0, 10
		syscall
