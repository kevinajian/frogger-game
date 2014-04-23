.text
main: 
ldi $r1, 1 				#object position, car increment 0
ldi $r2, 2 				#1
ldi $r3, 44 			#current frog position, set to starting position 2
ldi $r5, 44 			#start position, bottom boundary 3
ldi $r6, 6 				#frog increment 4
ldi $r13, 3 			#5
ldi $r14, 4 			#6
ldi $r15, 5				#---------- 7
ldi $r16, 11			#8
ldi $r17, 17			#9
ldi $r18, 23			#boundaries 10
ldi $r19, 29			#11
ldi $r20, 35			#12
ldi $r21, 41			#---------- 13
sw $r1, 9($r0)			#---------- 15
sw $r1, 13($r0)			#15
sw $r1, 22($r0)			#16
sw $r1, 27($r0)			#17
sw $r1, 32($r0)			#18
sw $r1, 36($r0)			#load cars into positions 19
sw $r1, 44($r0)			#put frog position in memory 25
#gameLoop:
#processInput:
nop 					#----------- 26
nop 					#tells processor to look for input 27
nop 					#28
nop 					#----------- 29
bne $r8, $r0, 2			#checkBot #if down was pressed 30
bne $r9, $r0, 10		#frogUp	#if up was pressed 31
j 49					#moveCars 32
#checkBot:				#moves down if not at bottom boundary
ldi $r8, 0				#resets down to 0 33
bne $r3, $r5, 1			#frogDown 	#if not at bottom 34
j 49					#moveCars 35
#frogDown:
sw $r0, 0($r3) 			#set old position to nothing 36
add $r3, $r3, $r6 		#frog position down 37
lw $r4, 0($r3)			#38
custi1 $r4, $r1, 189 	#lose 	#if a car is already there 39
sw $r1, 0($r3) 			#set new position to frog 40
j 49					#moveCars 41
#frogUp:
ldi $r9, 0				#resets up to 0 42
sw $r0, 0($r3) 			#set old position to nothing 43
sub $r3, $r3, $r6 		#frog position up 44
lw $r4, 0($r3)			# 45
custi1 $r4, $r1, 182 	#lose 	#if a car is already there 46
sw $r1, 0($r3) 			#set new position to frog 47
custi1 $r3, $r2, 178 	#win 	#if frog position is at 2 48
#moveCars:
ldi $r10, 6 			#i=6 49
#moveCarsLoop: 			#for i=6 -> 40
custi1 $r10, $r21, 53 	#updateBoard #i==41 50
custi1 $r10, $r3, 2		#iterate	#in frog position 51
lw $r4, 0($r10) 		#get led status 52
custi1 $r4, $r1, 2		#moveCar 53
#iterate:
addi $r10, $r10, 1 		#i++ 54
j 50					#moveCarsLoop 55
#moveCar:				#i >= 6
blt $r10, $r16, 5 		#moveCar2	#i < 11 56
blt $r10, $r17, 5 		#moveCar3	#i < 17 57
blt $r10, $r18, 7 		#moveCar4	#i < 23 58
blt $r10, $r19, 9 		#moveCar5	#i < 29 59
blt $r10, $r20, 11 		#moveCar6	#i < 35 60
blt $r10, $r21, 13 		#moveCar7	#i < 41 61
#moveCar2:				#i >= 6, < 11
j 78 					#carLeft 62
#moveCar3:				#i < 17
bne $r10, $r16, 27		#carRight	#i > 11 63
addi $r10, $r10, 1 		#i++ 64
j 50 					#moveCarsLoop 65
#moveCar4:				#i < 23
bne $r10, $r17, 24 		#carRight	#i > 17 66
addi $r10, $r10, 1 		#i++ 67
j 50 					#moveCarsLoop 68
#moveCar5:				#i < 29
bne $r10, $r18, 8 		#carLeft	#i > 23 69
addi $r10, $r10, 1 		#i++ 70
j 50 					#moveCarsLoop 71
#moveCar6:				#i < 35
bne $r10, $r19, 5 		#carLeft	#i > 29 72
addi $r10, $r10, 1 		#i++ 73
j 50					#moveCarsLoop 74
#moveCar7:				#i < 41
bne $r10, $r20, 15 		#carRight	#i > 35 75
addi $r10, $r10, 1 		#i++ 76
j 50					#moveCarsLoop 77
#carLeft:
sw $r0, 0($r10)			#set old position to nothing 78
sub $r10, $r10, $r1 	#car position left 79
custi1 $r10, $r3, 148 	#lose	#if frog is there 80
custi1 $r10, $r15, 5 	#wrapL	#----------- 81
custi1 $r10, $r18, 4 	#wrapL	#if car moved off board 82
custi1 $r10, $r19, 3 	#wrapL	#----------- 83
sw $r1, 0($r10)			#set new position to car 84
addi $r10, $r10, 2 		#i+=2 85
j 50 					#moveCarsLoop 86
#wrapL:
addi $r4, $r10, 5 		#87
sw $r1, 0($r4)			#set new position to car 88
addi $r10, $r10, 2 		#i+=2 89
j 50 					#moveCarsLoop 90
#carRight:
sw $r0, 0($r10)			#set old position to nothing 91
addi $r10, $r10, 1 		#car position right 92
custi1 $r10, $r3, 135 	#lose	#if frog is there 93
custi1 $r10, $r17, 5	#wrapR	#----------- 94
custi1 $r10, $r18, 4 	#wrapR	#if car moved off board 95
custi1 $r10, $r21, 3 	#wrapR	#----------- 96
sw $r1, 0($r10)			#set new position to car 97
addi $r10, $r10, 1 		#i++ to avoid running into car that was just updated (also means we won't have adjacent cars moving right) 98
j 50 					#moveCarsLoop 99
#wrapR:
sub $r4, $r10, $r15 	#100
sw $r1, 0($r4)			#101
addi $r10, $r10, 1 		#i++ 102
j 50 					#moveCarsLoop 103
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 104
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
#draw:					#Draw LED MATRIX
ldi $r22, 1 			#turn on LED display 225
j 26 					#gameLoop 226
#win:
addi $r11, $r11, 1 		#score++ 227
j 0 					#main 228
#lose: 					#can subtract score, save high score, etc.
j 0 					#main 229

.data