.data
	qline:		.asciiz	"\n"
	palavra:	.space 1001
	inverso:	.space 1001
.text
main:
	jal	ler_int
	addi 	$t1, $t1, 2
	
	la	$t2, palavra
	jal	ler_string
	la	$t4, palavra
	la	$t5, palavra
	
	li	$t0, 0
	addi 	$t1, $t1, -2
	la	$t2, inverso
	la	$t6, ($t1)
	la	$t0, ($t1)
	addi	$t2, $t2, 1
	jal	pega_inverso
	rol	$t2, $t2, 4
	sb	$t2, inverso
	li	$t0, 0
	la	$t2, ($t1)
	la	$t4, palavra
	la	$t5, inverso
	jal	compara_strings
	beq	$t0, $t1, eh_palindromo
	la	$t0, 0
	jal 	printa_int
	j	exit
	eh_palindromo:	la	$t0, 1
	jal 	printa_int
	j	exit
	
exit:	
	li	$v0, 10		# Chamada de sistema para saida
	syscall 		# Finaliza execução.

ler_int:
	li	$v0, 5		# Chamada de sistema para read_int
	syscall	
			
	move	$t1, $v0	# Coloca o valor que foi lido em $t1
	jr	$ra		
	
ler_string:
	li	$v0, 8		# Chamada de sistema para read_string
	la	$a0, ($t2)	# Coloca o endereço da string que vai vim em $t2 em $a0
	la  	$a1, ($t1)	# Passa para $a1 o numero de caracteres que quer ler
	syscall			# Valor lido fica armazenado em $a0
	jr	$ra 

printa_int:
	la 	$a0, ($t0)	# Coloca o registrador $t0 para ser impresso
	li 	$v0, 1		# Chamada de sistema para print_int
	syscall			# Imprime o inteiro
	
	li 	$v0, 4		# Chamada de sistema para print_string
	la  	$a0, qline	# Endereço da string para imprimir	
	syscall			# Imprime a string
	jr	$ra

pega_inverso:
	lb  	$t3, 0($t4)	# Coloca o primeiro byte de $t4 em $t3, ou seja, a letra que está na posição
	beqz 	$t0, fim_inverso# Se já inverteu toda a palavra volta pra main
	beq 	$t6, 1, fim_pega_ultimo# Se pegou a ultima letra vai pra onde será armazenada
	addi 	$t4, $t4, 1	# Adicionando 1 pula pra próxima letra 
	addi	$t6, $t6, -1	# Variável que inicialmente tem o valor do tamanho da palavra e decrementa até encontrar a ultima letra
	j	pega_inverso
	fim_pega_ultimo:
	sb	$t3, 0($t2)	# Coloca a letra encontrada em $t2
	addi	$t2, $t2, 1	# Adicionando 1 pula pra próxima letra que será encontrada
	addi	$t0, $t0, -1	# Variável que inicialmente tem o valor do tamanho da palavra e decrementa até terminar de inverter toda a palavra
	la	$t6, ($t0)	# Coloca o valor atualizado de $t0 em $t6
	la	$t4, palavra	# Coloca a palavra em $t4 novamente
	j	pega_inverso
	fim_inverso: jr	$ra
	
compara_strings:
	lb 	$t3, 0($t4)	# Coloca o primeiro byte de $t4 em $t3, ou seja, a letra que está na posição
	addi 	$t5, $t5, 1	# Como a primeira letra da palavra invertida tem um lixo, pulamos pra próxima logo aqui
	lb 	$t6, 0($t5)	# Coloca o primeiro byte de $t5 em $t6, ou seja, a letra que está na posição
	beqz 	$t2, fim_comparacao # Se terminou a comparação volta pra main
	bne 	$t3, $t6, continua # Se as 2 letras forem diferentes continua 	
	addi	$t0, $t0, 1	   # Se não soma 1 em $t0
	continua:
	addi 	$t4, $t4, 1	# Pula pra pŕoxima letra da palavra	
	addi	$t2, $t2, -1	# Variável que inicialmente tem o valor do tamanho da palavra e decrementa até terminar de comparar as palavras
	j	compara_strings
	
fim_comparacao:
	jr	$ra
