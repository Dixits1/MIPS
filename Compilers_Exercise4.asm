# A program that takes two numbers as input from the user and returns their product.
# 
# @author Arjun Dixit
# @version 4/24/22
	.data
		prompt: .asciiz "Input a number: "
		res: .asciiz "Result: "
	.text 0x00400000
	.globl main
main:
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	mult $t0, $v0
	mflo $t1
	
	la $a0, res
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall

	li $v0, 10 # normal termination
	syscall