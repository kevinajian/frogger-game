.text
main:
ldi $r1, 1 				#object position, car increment 0
sw $r1, 0($r0)			#put frog position in memory 2
sw $r1, 12($r0)
sw $r1, 24($r0)
sw $r1, 36($r0)
#gameLoop:
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 3
ldi $r23, 0				#------------------ 105
ldi $r24, 0				#106
ldi $r25, 0				#reset display bits 107
ldi $r26, 0				#108
ldi $r27, 0				#------------------ 109
#column1: 				#check 0, 6, 12, 18, 24, 30, 36, 42
lw $r4, 0($r0)			#110
sll $r4, $r4, 7
add $r23, $r23, $r4
lw $r7, 6($r0)
sll $r7, $r7, 6
add $r23, $r23, $r7
lw $r12, 12($r0)
sll $r12, $r12, 5
add $r23, $r23, $r12
lw $r28, 18($r0)
sll $r28, $r28, 4
add $r23, $r23, $r28
lw $r29, 24($r0)
sll $r29, $r29, 3
add $r23, $r23, $r29
lw $r30, 30($r0)
sll $r30, $r30, 2
add $r23, $r23, $r30
lw $r4, 36($r0)
sll $r4, $r4, 1
add $r23, $r23, $r4
lw $r7, 42($r0)
add $r23, $r23, $r7 	#132
#column2:				#check 1, 7, 13, 19, 25, 31, 37, 43
lw $r12, 1($r0)			#133
sll $r12, $r12, 7
add $r24, $r24, $r12
lw $r28, 7($r0)
sll $r28, $r28, 6
add $r24, $r24, $r28
lw $r29, 13($r0)
sll $r29, $r29, 5
add $r24, $r24, $r29
lw $r30, 19($r0)
sll $r30, $r30, 4	
add $r24, $r24, $r30
lw $r4, 25($r0)
sll $r4, $r4, 3
add $r24, $r24, $r4
lw $r7, 31($r0)
sll $r7, $r7, 2
add $r24, $r24, $r7
lw $r12, 37($r0)
sll $r12, $r12, 1
add $r24, $r24, $r12
lw $r28, 43($r0)
add $r24, $r24, $r28	#155
#column3: 				#check 2, 8, 14, 20, 26, 32, 38, 44
lw $r29, 2($r0)			#156
sll $r29, $r29, 7
add $r25, $r25, $r29
lw $r30, 8($r0)
sll $r30, $r30, 6
add $r25, $r25, $r30
lw $r4, 14($r0)
sll $r4, $r4, 5
add $r25, $r25, $r4
lw $r7, 20($r0)
sll $r7, $r7, 4	
add $r25, $r25, $r7
lw $r12, 26($r0)
sll $r12, $r12, 3	
add $r25, $r25, $r12
lw $r28, 32($r0)
sll $r28, $r28, 2
add $r25, $r25, $r28
lw $r29, 38($r0)
sll $r29, $r29, 1
add $r25, $r25, $r29
lw $r30, 44($r0)
add $r25, $r25, $r30 	#178
#column4:				#check 3, 9, 15, 21, 27, 33, 39, 45
lw $r4, 3($r0)			#179
sll $r4, $r4, 7	
add $r26, $r26, $r4
lw $r7, 9($r0)
sll $r7, $r7, 6
add $r26, $r26, $r7
lw $r12, 15($r0)
sll $r12, $r12, 5
add $r26, $r26, $r12
lw $r28, 21($r0)
sll $r28, $r28, 4
add $r26, $r26, $r28
lw $r29, 27($r0)
sll $r29, $r29, 3
add $r26, $r26, $r29
lw $r30, 33($r0)
sll $r30, $r30, 2
add $r26, $r26, $r30
lw $r4, 39($r0)
sll $r4, $r4, 1
add $r26, $r26, $r4
lw $r7, 45($r0)
add $r26, $r26, $r7 	#201
#column5:				#check 4, 10, 16, 22, 28, 34, 40, 46
lw $r12, 4($r0)			#202
sll $r12, $r12, 7
add $r27, $r27, $r12
lw $r28, 10($r0)
sll $r28, $r28, 6
add $r27, $r27, $r28
lw $r29, 16($r0)
sll $r29, $r29, 5
add $r27, $r27, $r29
lw $r30, 22($r0)
sll $r30, $r30, 4
add $r27, $r27, $r30
lw $r4, 28($r0)
sll $r4, $r4, 3
add $r27, $r27, $r4
lw $r7, 34($r0)
sll $r7, $r7, 2
add $r27, $r27, $r7
lw $r12, 40($r0)
sll $r12, $r12, 1
add $r27, $r27, $r12
lw $r28, 46($r0)
add $r27, $r27, $r28	#224
ldi $r22, 1
j 2 					#gameLoop

.data