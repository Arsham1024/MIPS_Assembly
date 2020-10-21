########################################################################################################################
#Program: Homework 4									     Programmer:Arsham Mehrani#
#Due Date: Oct 20,2020									     Course: CS2640
######################################################################################################################### 
#Overall Program Functional Description:
#	This program will ask the user to enter two integers "m" and "n" and then it will perform Combination (n, m ) 
#	AKA Choose(m, n) function on these numbers, where n >= r and r >= 0.
#########################################################################################################################
# Registers used in main:
#	$v0 - for syscall 
#	$s  - registers for incrimenting and saving values
#	$a  - for holding the n and m
#########################################################################################################################
#Pseudocode Description: 
#	1. Prompt the user to enter n and m
#	2. Save the integers correspondingly
#	3. Eliminated the easy and obvious cases.
#	4. Calculate the hard cases.
#	5. Show answer
######################################################################################################################### 

.text

.globl 	__start
	
__start:
	li $v0, 4   
	la $a0, Message1
	syscall
	li $v0,5 #read integer in
	syscall
	move $t0, $v0
 
	li $v0, 4 
  	la $a0, Message2
   	syscall
   	li $v0,5 #read n integer 
	syscall
	move $a0, $t0
	move $a1, $v0
	jal Calc
		
################################################################
#calculation part happens here:
	move $t0, $v0
  
	li $v0, 4
	la $a0, Message3 #display the C(n,m)
	syscall
  
	move $a0, $t0
	li $v0,1 # print C(n,m)
	syscall

	li $v0,4   
  	la $a0, cr
   	syscall

	li $v0,10 # End
   	syscall
##############################################################
#calculation 
Calc: 
#Cases where we don't need to calculate.
	slt $t0, $a0, $a1
	bne $t0, $zero, exit1
	beq $a0, $a1, exit2
	beq $a1, $zero, exit2

	sw $fp, -4($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -12
	sw $ra, 4 ($sp)
	sw $a0, 0 ($sp)
	addi $sp, $sp, -4
	sw $t1, ($sp)
	addi $a0, $a0, -1
	jal Calc

	move $t1, $v0
	addi $sp, $sp, -4
	sw $a1, ($sp)
	addi $sp, $sp, -4
	sw $ra, ($sp)
  
	addi $a1, $a1, -1
#loop back
	jal Calc

	add $v0, $t1, $v0

	lw $ra, ($sp) #save 
	addi $sp, $sp, 4
  
	lw $a1, ($sp)
	addi $sp, $sp, 4
  
	lw $t1, ($sp)
	addi $sp, $sp, 4
  
	lw $a0, ($sp)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	addi $sp, $sp, 4
	lw $fp, ($sp)
	addi $sp, $sp, 4
	j done

#ways to exit the loops
exit1: 
	move $v0, $zero   
	j done
exit2: 
	addi $v0, $zero, 1

#Using this for a cleaner code just refrence.
done: 
	jr $ra  

#Prompts to the user are saved here.
.data

	Message1: .asciiz "Please Enter n:\n"
	Message2: .asciiz "Please Enter m:\n"
	Message3: .asciiz "C(n,m) = "
	cr: .asciiz "\n"