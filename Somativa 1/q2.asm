	.data
	.text

main:
	li $v0, 5	#Ler núemro informado pelo usuário
	syscall
	
	move $t0, $v0	#Armazena a informação no registrador
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	add $t2, $t1, $t0
	
	li $v0, 1	#imprimir inteiro
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall 
