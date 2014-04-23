.text
main: 
ldi $r1, 1 				#object position, car increment 0
ldi $r2, 2 				#1
ldi $r3, 44 			#current frog position, set to starting position 2
ldi $r5, 44 			#start position, bottom boundary 3
ldi $r6, 6 				#frog increment 4
#gameLoop:
#processInput:
nop 					#----------- 5
nop 					#tells processor to look for input 6
nop 					#7
nop 					#----------- 8
bne $r8, $r0, 2			#checkBot #if down was pressed 9
bne $r9, $r0, 10		#frogUp	#if up was pressed 10
j 26					#updateBoard 11
#checkBot:				#moves down if not at bottom boundary
ldi $r8, 0				#resets down to 0 12
bne $r3, $r5, 1			#frogDown 	#if not at bottom 13
j 26					#updateBoard 14
#frogDown:
sw $r0, 0($r3) 			#set old position to nothing 15
add $r3, $r3, $r6 		#frog position down 16
lw $r4, 0($r3)			#17
sw $r1, 0($r3) 			#set new position to frog 18
j 26					#updateBoard 19
#frogUp:
ldi $r9, 0				#resets up to 0 20
sw $r0, 0($r3) 			#set old position to nothing 21
sub $r3, $r3, $r6 		#frog position up 22
lw $r4, 0($r3)			# 23
sw $r1, 0($r3) 			#set new position to frog 24
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 25
ldi $r25, 0				#reset display bits 26
#column3: 				#check 2, 8, 14, 20, 26, 32, 38, 44
lw $r4, 2($r0)			#27
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 8($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 14($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 20($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1	
lw $r4, 26($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 32($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 38($r0)
add $r25, $r25, $r4
sll $r25, $r25, 1
lw $r4, 44($r0)
add $r25, $r25, $r4 	#49
#draw:					#Draw LED MATRIX
ldi $r22, 1 			#turn on LED display 50
j 27 					#gameLoop 51
