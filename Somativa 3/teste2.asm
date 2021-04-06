	.data
input:		.space	256
output:		.space	256
str2:		.space 256
new_line:	.asciiz "\n"
	.text
	
main:
	li $v0, 5		# usuário informa a quantidade de letras
	syscall
	move $t5, $v0		# armazenamos em $t5

	# Lê string
	li	$v0, 8			# usuário informa a palavra
	la	$a0, input		# armazenamos em 'input'
	li	$a1, 256		# apenas 256 chars/bytes permitidos
	syscall
	
len_to_new_line:
    lb $t2, ($a0) # t2 = *a0
    beq $t2, '\n', end # if t2 == '\n' -> stop
    addi $a0, $a0, 1 # a0++
    b len_to_new_line   
end:
    sb $zero, ($a0) # overwrite '\n' with 0

	
	add	$t1, $zero, $t5		# armazena o tamanho da palavra em $t1
	add	$t2, $zero, $a0		# armazena a palavra em $t2
	add	$a0, $zero, $v0		
	

reverse:
	li	$t0, 0			# $t0 é o contador (i+=0)
	li	$t3, 0			# $t3 é onde será carregado cada byte da palavra
	
	
	# $t1 - tamanho da palavra
	# $t2 - palavra em si
	reverse_loop:
		add	$t3, $t2, $t0		# $t2 é o endereço base para nosso 'input' array, add loop index
		lb	$t4, 0($t3)		# carregar um byte por vez de acordo com o contador
		beqz	$t4, strcmp		# Encontrou o caracter null-byte
		#bgt	$t0, $t5, strcmp
		sb	$t4, output($t1)	# Sobrescreve este endereço de byte na memória
		subi	$t1, $t1, 1		# Subtraia o comprimento total da string por 1 (j--)
		addi	$t0, $t0, 1		# Incrementa o contador (i++)	
		j	reverse_loop		# reinicia o loop até atingir a condição
		

	addi $t1, $t1, 0 # len = 0
	la  $t2, input

strcmp: 

	la	$s0, input		# carrega o endereço da string original em $s0 ($a0)
	la	$s1, output		# carrega o endereço da string invertida em $s1 ($a1)
	
	
	lb	$t0, ($s0)
	lb	$t1, ($s1)
	
	add	$s0, $s0, 1
	add	$s1, $s1, 1
	
	beqz	$t0, LOOP_END
	beqz	$t1, LOOP_END
	bgt	$t0, $t1, GREATER
	blt	$t0, $t1, LESS
	beq	$t0, $t1, strcmp
GREATER:
	li	$v0, 1
	j	END
LESS:
	li	$v0, -1
	j	END
EQUAL:
	li	$v0, 0
	j	END
LOOP_END:
	beq	$t0, $t1, EQUAL
	beqz	$t0, LESS
	beqz	$t1, GREATER
END:

	li $v0, 4
	la $a0, new_line
	syscall
	
	
	
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 4
	la $a0, output
	syscall


	
	#li $v0, 4
	#la $a0, input
	#syscall
	
	
	#move	$a0, $v0
	#li	$v0, 1
	#syscall
	
	# exit program
	li $v0, 10
	syscall