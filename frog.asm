.text
main:
ldi $r1, 1 				#object position, car increment 0
sw $r1, 44($r0)			#put frog position in memory 2
#gameLoop:
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 3
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
ldi $r22, 1
j 2 					#gameLoop

.data