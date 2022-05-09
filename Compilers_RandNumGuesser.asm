# A program that guesses the number that a user is thinking of in as few guesses as possible.
# 
# @author Arjun Dixit
# @version 4/24/22


	.data
		initPrompt1: .asciiz "\nThink of a number between "
		initPrompt2: .asciiz " and "
		initPrompt3: .asciiz "."
		compGuessMsg: .asciiz "\nMy guess is "
		highLowPrompt: .asciiz "\nEnter 0 if it is too low, 1 if it is too high, and 2 if it is the correct guess: "
		errorPrompt: .asciiz "\n0, 1, or 2 was not entered. Please re-enter your response: "
		newLn: .asciiz "\n"
		initLow: .word 0
		initHigh: .word 1000000
	.text 0x00400000
	.globl main
main:
	# guess    = $t0
	# low      = $t1
	# high     = $t2
	# temp     = $t3
	# initLow address  = $t4
	# initHigh address = $t5

	la $a0, initPrompt1 # print the full initial prompt
	li $v0, 4
	syscall
	
	la $t4, initLow
	lw $a0, ($t4)
	li $v0 1
	syscall
	
	la $a0, initPrompt2
	li $v0, 4 
	syscall
	
	la $t5, initHigh
	lw $a0, ($t5)
	li $v0 1
	syscall
	
	la $a0, initPrompt3
	li $v0, 4
	syscall

	lw $t1, ($t4) # load initLow into low and initHigh into high
	lw $t2, ($t5)
	
	jal calcmidpt # calculate the midpoint
	j loop # enter the guessing loop
	
loop:
	beq $t1, $t2, endloop # while low != high
	
	la $a0, compGuessMsg # print the message prior to the current guess
	li $v0, 4
	syscall
	
	move $a0, $t0 # print the current guess
	li $v0 1
	syscall
	
	la $a0, highLowPrompt # print the highLowPrompt
	li $v0, 4
	syscall
	
	j loopend
	
loopend:
	li $v0, 5 # get user response to the highLowPrompt and store in $v0
	syscall
	
	# check if guess is 0, 1, or 2, change high/low accordingly
	li $t3, 0
	beq $v0, $t3, midlooplow
	li $t3, 1
	beq $v0, $t3, midloophigh
	li $t3, 2
	beq $v0, $t3, endloop
	
	# if 0, 1, or 2 is not entered, ask user for response again
	la $a0, errorPrompt
	li $v0, 4
	syscall
	
	# loop until user enters in 0, 1, or 2
	j loopend
	
midlooplow: # low = mid, recalculate mid
	move $t1, $t0
	jal calcmidpt
	j loop
	
midloophigh: # high = mid, recalculate mid
	move $t2, $t0
	jal calcmidpt
	j loop

calcmidpt: # calculate the midpoint of $t1 and $t2, store in $t0
	addu $t0, $t1, $t2
	li $t3, 2
	
	div $t0, $t3
	mflo $t0
	
	jr $ra

endloop:
	# print the guess
	jal calcmidpt
	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 10 # normal termination
	syscall