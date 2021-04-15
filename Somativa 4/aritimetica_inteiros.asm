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
	
	# Armazena o módulo em $t2
	li $v0, 5
	syscall
	
	jal checkInput	# Valida entrada
	
	move $t2, $v0
	
	# Se a entrada for igual a 1
	beq $t2, 1, isNotPrime
	
	li $t3, 2	# Valor inicial para ser usado no processo
	div $t2, $t3	# Divide o valor do módulo por 2
	mflo $t5	# Pega a metade do número 
	
	loopPrime:
		beq $t3, $t5, isPrime	# Se a metade do número for igual ao contador sai do laço
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
		# Label exponenciação
		exponenciation:
			la	$t4, ($t1)	# Contador $t4 comeÃ§a com o valor do expoente
			li	$t5, 1		
		loopExpo:
			beqz 	$t4, calcMod	# CondiÃ§Ã£o de parada eh contador $t4=0
			mul	$t5, $t5, $t0	# Multiplica a base 
			addi	$t4, $t4, -1	
			j	loopExpo 
	
		calcMod:
			div	$t5, $t2	# Divide o resultado da expoenciacao por c
			mfhi	$t6		# Guarda o resto da divisao acima em $t6
	
			j printResults
	
	# Label não é primo
	isNotPrime: 
	
		# Imprime mensagem ao usuário
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
