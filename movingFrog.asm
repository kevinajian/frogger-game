.text
main: 
ldi $r1, 1 				#object position, car increment 0
ldi $r3, 44 			#current frog position, set to starting position 1
ldi $r5, 44 			#start position, bottom boundary 2
ldi $r6, 6 				#frog increment 3
sw $r1, 44($r0)			#put frog position in memory 4
#gameLoop:
#processInput:
nop 					#----------- 5
nop 					#tells processor to look for input 6
nop 					#7
nop 					#----------- 8
bne $r8, $r0, 2			#checkBot #if down was pressed 9
bne $r9, $r0, 9			#frogUp	#if up was pressed 10
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
blt $r3, $r6, 0			#WIN, resets 23
lw $r4, 0($r3)			#24
sw $r1, 0($r3) 			#set new position to frog 25
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 26
ldi $r23, 0				#------------------ 105
ldi $r24, 0				#106
ldi $r25, 0				#reset display bits 107
ldi $r26, 0				#108
ldi $r27, 0				#------------------ 109
#column1: 				#check 0, 6, 12, 18, 24, 30, 36, 42
lw $r4, 0($r0)			#110
sll $r4, $r4, 7
add $r23, $r23, $r4
lw $r4, 6($r0)
sll $r4, $r4, 6
add $r23, $r23, $r4
lw $r4, 12($r0)
sll $r4, $r4, 5
add $r23, $r23, $r4
lw $r4, 18($r0)
sll $r4, $r4, 4
add $r23, $r23, $r4
lw $r4, 24($r0)
sll $r4, $r4, 3
add $r23, $r23, $r4
lw $r4, 30($r0)
sll $r4, $r4, 2
add $r23, $r23, $r4
lw $r4, 36($r0)
sll $r4, $r4, 1
add $r23, $r23, $r4
lw $r4, 42($r0)
add $r23, $r23, $r4 	#132
#column2:				#check 1, 7, 13, 19, 25, 31, 37, 43
lw $r4, 1($r0)			#133
sll $r4, $r4, 7
add $r24, $r24, $r4
lw $r4, 7($r0)
sll $r4, $r4, 6
add $r24, $r24, $r4
lw $r4, 13($r0)
sll $r4, $r4, 5
add $r24, $r24, $r4
lw $r4, 19($r0)
sll $r4, $r4, 4	
add $r24, $r24, $r4
lw $r4, 25($r0)
sll $r4, $r4, 3
add $r24, $r24, $r4
lw $r4, 31($r0)
sll $r4, $r4, 2
add $r24, $r24, $r4
lw $r4, 37($r0)
sll $r4, $r4, 1
add $r24, $r24, $r4
lw $r4, 43($r0)
add $r24, $r24, $r4 	#155
#column3: 				#check 2, 8, 14, 20, 26, 32, 38, 44
lw $r4, 2($r0)			#156
sll $r4, $r4, 7
add $r25, $r25, $r4
lw $r4, 8($r0)
sll $r4, $r4, 6
add $r25, $r25, $r4
lw $r4, 14($r0)
sll $r4, $r4, 5
add $r25, $r25, $r4
lw $r4, 20($r0)
sll $r4, $r4, 4	
add $r25, $r25, $r4
lw $r4, 26($r0)
sll $r4, $r4, 3	
add $r25, $r25, $r4
lw $r4, 32($r0)
sll $r4, $r4, 2
add $r25, $r25, $r4
lw $r4, 38($r0)
sll $r4, $r4, 1
add $r25, $r25, $r4
lw $r4, 44($r0)
add $r25, $r25, $r4 	#178
#column4:				#check 3, 9, 15, 21, 27, 33, 39, 45
lw $r4, 3($r0)			#179
sll $r4, $r4, 7	
add $r26, $r26, $r4
lw $r4, 9($r0)
sll $r4, $r4, 6
add $r26, $r26, $r4
lw $r4, 15($r0)
sll $r4, $r4, 5
add $r26, $r26, $r4
lw $r4, 21($r0)
sll $r4, $r4, 4
add $r26, $r26, $r4
lw $r4, 27($r0)
sll $r4, $r4, 3
add $r26, $r26, $r4
lw $r4, 33($r0)
sll $r4, $r4, 2
add $r26, $r26, $r4
lw $r4, 39($r0)
sll $r4, $r4, 1
add $r26, $r26, $r4
lw $r4, 45($r0)
add $r26, $r26, $r4 	#201
#column5:				#check 4, 10, 16, 22, 28, 34, 40, 46
lw $r4, 4($r0)			#202
sll $r4, $r4, 7
add $r27, $r27, $r4
lw $r4, 10($r0)
sll $r4, $r4, 6
add $r27, $r27, $r4
lw $r4, 16($r0)
sll $r4, $r4, 5
add $r27, $r27, $r4
lw $r4, 22($r0)
sll $r4, $r4, 4
add $r27, $r27, $r4
lw $r4, 28($r0)
sll $r4, $r4, 3
add $r27, $r27, $r4
lw $r4, 34($r0)
sll $r4, $r4, 2
add $r27, $r27, $r4
lw $r4, 40($r0)
sll $r4, $r4, 1
add $r27, $r27, $r4
lw $r4, 46($r0)
add $r27, $r27, $r4 	#224
#draw:					#Draw LED MATRIX
ldi $r22, 1 			#turn on LED display 51
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
j 5 					#gameLoop 52

.data
