# A program that prints out the value of the loop index given the low, high, and step
# as parameters for the loop.
# 
# @author Arjun Dixit
# @version 4/24/22	
	
	.data
		lowPrompt: .asciiz "Input the low: "
		highPrompt: .asciiz "Input the high: "
		stepPrompt: .asciiz "Input the step: "
		newLn: .axciiz "\n"
		two: .word 2
	.text 0x00400000
	.globl main
main:
	la $a0, lowPrompt # load prompt into $a0
	li $v0, 4      # print $a0
	syscall
	li $v0, 5      # get user input and store in $v0
	syscall
	move $t0, $v0 # move low into $t0
	
	la $a0, highPrompt # load prompt into $a0
	li $v0, 4      # print $a0
	syscall
	li $v0, 5      # get user input and store in $v0
	syscall
	move $t1, $v0 # move high into $t1
	
	la $a0, stepPrompt # load prompt into $a0
	li $v0, 4      # print $a0
	syscall
	li $v0, 5      # get user input and store in $v0
	syscall
	move $t2, $v0 # move step into $t2

loop:
	bge $t0, $t1, endloop
	move $a0, $t0 # print the current loop value ($t0)
	li $v0 1
	syscall
	
	la $a0, newLn # print a new line
	li $v0, 4
	syscall
	
	add $t0, $t0, $t2 # increment $t0
	j loop
	
endloop:
	li $v0, 10 # normal termination
	syscall