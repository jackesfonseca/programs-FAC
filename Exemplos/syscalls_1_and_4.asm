	.data
str: 	.asciiz "The answer = "
	.text

main:
	li $v0, 4 	#chamada ao sistema para print_str
	la $a0, str	#endereço da string a imprimir 
	syscall		#imprime a string

	li $v0, 1	#chamada ao sistema para print_int
	li $a0, 5	#inteiro a imprimir
	syscall
	
	li $v0, 10	#chamada ao sistema para exit
	syscall		#encerra o programa