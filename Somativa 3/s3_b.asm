	.data
input:		.space	256
output:		.space	256
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
	
	li $s0,0               # Set index to 0

	
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
		beqz	$t4, remove_end_line		# Encontrou o caracter null-byte
		#bgt	$t0, $t5, strcmp
		sb	$t4, output($t1)	# Sobrescreve este endereço de byte na memória
		subi	$t1, $t1, 1		# Subtraia o comprimento total da string por 1 (j--)
		addi	$t0, $t0, 1		# Incrementa o contador (i++)
		
		j	reverse_loop		# reinicia o loop até atingir a condição
		
remove_end_line:

   	lb $a3,input($s0)      
    	addi $s0,$s0,1        
   	bnez $a3,remove_end_line   
    	beq $a1,$s0,strcmp     
    	subiu $s0,$s0,2     
    	sb $0, input($s0)        
    		
    	li $v0, 4
    	la $a0, input
    	syscall
   
     	li $v0, 4
    	la $a0, output
    	syscall
   
strcmp:


	# string compare loop (just like strcmp)

    lb      $t2, input($s2)                   # get next char from str1
    lb      $t3, output($s3)                   # get next char from str2
    bne     $t2,$t3,cmpne               # are they different? if yes, fly

    beq     $t2,$zero,cmpeq             # at EOS? yes, fly (strings equal)

    addi    $s2,$s2,1                   # point to next char
    addi    $s3,$s3,1                   # point to next char
    j       strcmp

# strings are _not_ equal -- send message
cmpne:

    addi $t0, $zero, 1
    li $v0, 1
    move $a0, $t0
    syscall
    
    
    # exit program
	li $v0, 10
	syscall

# strings _are_ equal -- send message
cmpeq:
    addi $t0, $zero, 0
    li $v0, 1
    move $a0, $t0
    syscall
	
	# exit program
	li $v0, 10
	syscall
