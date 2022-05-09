# A program that takes a number from the user and tells the user if the number is even or odd.
# 
# @author Arjun Dixit
# @version 4/24/22
	
	.data
		prompt: .asciiz "Input a number: "
		even: .asciiz "Number is even."
		odd: .asciiz "Number is odd."
		two: .word 2
	.text 0x00400000
	.globl main
main:
	la $a0, prompt # load prompt into $a0
	li $v0, 4      # print $a0
	syscall
	li $v0, 5      # get user input and store in $v0
	syscall
	
	la $t0, two    # load 2 into $t0
	lw $t0, ($t0)
	
	div $v0, $t0   # $v0 / $t0 (user input / 2)
	mflo $t1       # store division result in $t1
	
	mult $t0, $t1  # $t0 * $t1 (division result * 2)
	mflo $t2       # store mult result in $t2
	
	
	# if $t2 == $v0, print even, else print odd
	beq $t2, $v0, printEven
	
	j elsel20
	
	
printEven:
	la $a0, even   # load even into $a0
	li $v0, 4      # print $a0
	syscall
	
	j after
	
elsel20:
	la $a0, odd    # load odd into $a0
	li $v0, 4      # print $a0
	syscall
	j after

after:
	li $v0, 10 # normal termination
	syscall