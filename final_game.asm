.text
#main: 
ldi $r1, 1 				#object position, car increment 1
ldi $r2, 2 				#2
ldi $r3, 44 			#current frog position, set to starting position 3
ldi $r5, 44 			#start position, bottom boundary 4
ldi $r6, 6 				#frog increment 5
ldi $r13, 3 			#6
ldi $r14, 4 			#7
ldi $r15, 5				#---------- 8
ldi $r16, 11			#9
ldi $r17, 17			#10
ldi $r18, 23			#boundaries 11
ldi $r19, 29			#12
ldi $r20, 35			#13
ldi $r21, 41			#---------- 14
sw $r1, 9($r0)			#---------- 15
sw $r1, 10($r0)			#16
sw $r1, 12($r0)			#17
sw $r1, 15($r0)			#18
sw $r1, 19($r0)			#19
sw $r1, 25($r0)			#load cars into positions 20
sw $r1, 26($r0)			#21
sw $r1, 27($r0)			#22
sw $r1, 31($r0)			#23
sw $r1, 38($r0)			#24
sw $r1, 40($r0)			#---------- 25
sw $r1, 44($r0)			#put frog position in memory 26
#gameLoop:
#processInput:
nop 					#----------- 27
nop 					#tells processor to look for input 28
nop 					#29
nop 					#----------- 30
bne $r8, $r0, 2			#checkBot #if down was pressed 31
bne $r9, $r0, 10		#frogUp	#if up was pressed 32
j 50					#moveCars 33
#checkBot:				#moves down if not at bottom boundary
ldi $r8, 0				#resets down to 0 34
bne $r3, $r5, 1			#frogDown 	#if not at bottom 35
j 50					#moveCars 36
#frogDown:
sw $r0, 0($r3) 			#set old position to nothing 37
add $r3, $r3, $r6 		#frog position down 38
lw $r4, 0($r3)			#39
custi1 $r4, $r1, 189 	#lose 	#if a car is already there 40
sw $r1, 0($r3) 			#set new position to frog 41
j 50					#moveCars 42
#frogUp:
ldi $r9, 0				#resets up to 0 43
sw $r0, 0($r3) 			#set old position to nothing 44
sub $r3, $r3, $r6 		#frog position up 45
lw $r4, 0($r3)			# 46
custi1 $r4, $r1, 182 	#lose 	#if a car is already there 47
sw $r1, 0($r3) 			#set new position to frog 48
custi1 $r3, $r2, 178 	#win 	#if frog position is at 2 49
#moveCars:
ldi $r10, 6 			#i=6 50
#moveCarsLoop: 			#for i=6 -> 40
custi1 $r10, $r21, 53 	#updateBoard #i==41 51
custi1 $r10, $r3, 2		#iterate	#in frog position 52
lw $r4, 0($r10) 		#get led status 53
custi1 $r4, $r1, 2		#moveCar 54
#iterate:
addi $r10, $r10, 1 		#i++ 55
j 51					#moveCarsLoop 56
#moveCar:				#i >= 6
blt $r10, $r16, 5 		#moveCar2	#i < 11 57
blt $r10, $r17, 5 		#moveCar3	#i < 17 58
blt $r10, $r18, 7 		#moveCar4	#i < 23 59
blt $r10, $r19, 9 		#moveCar5	#i < 29 60
blt $r10, $r20, 11 		#moveCar6	#i < 35 61
blt $r10, $r21, 13 		#moveCar7	#i < 41 62
#moveCar2:				#i >= 6, < 11
j 79 					#carLeft 63
#moveCar3:				#i < 17
bne $r10, $r16, 27		#carRight	#i > 11 64
addi $r10, $r10, 1 		#i++ 65
j 51 					#moveCarsLoop 66
#moveCar4:				#i < 23
bne $r10, $r17, 24 		#carRight	#i > 17 67
addi $r10, $r10, 1 		#i++ 68
j 51 					#moveCarsLoop 69
#moveCar5:				#i < 29
bne $r10, $r18, 8 		#carLeft	#i > 23 70
addi $r10, $r10, 1 		#i++ 71
j 51 					#moveCarsLoop 72
#moveCar6:				#i < 35
bne $r10, $r19, 5 		#carLeft	#i > 29 73
addi $r10, $r10, 1 		#i++ 74
j 51					#moveCarsLoop 75
#moveCar7:				#i < 41
bne $r10, $r20, 15 		#carRight	#i > 35 76
addi $r10, $r10, 1 		#i++ 77
j 51					#moveCarsLoop 78
#carLeft:
sw $r0, 0($r10)			#set old position to nothing 79
sub $r10, $r10, $r1 	#car position left 80
custi1 $r10, $r3, 148 	#lose	#if frog is there 81
custi1 $r10, $r15, 5 	#wrapL	#----------- 82
custi1 $r10, $r18, 4 	#wrapL	#if car moved off board 83
custi1 $r10, $r19, 3 	#wrapL	#----------- 84
sw $r1, 0($r10)			#set new position to car 85
addi $r10, $r10, 2 		#i+=2 86
j 51 					#moveCarsLoop 87
#wrapL:
addi $r4, $r10, 5 		#88		
sw $r1, 0($r4)			#set new position to car 89
addi $r10, $r10, 2 		#i+=2 90
j 51 					#moveCarsLoop 91
#carRight:
sw $r0, 0($r10)			#set old position to nothing 92
addi $r10, $r10, 1 		#car position right 93
custi1 $r10, $r3, 135 	#lose	#if frog is there 94
custi1 $r10, $r17, 5	#wrapR	#----------- 95
custi1 $r10, $r18, 4 	#wrapR	#if car moved off board 96
custi1 $r10, $r21, 3 	#wrapR	#----------- 97
sw $r1, 0($r10)			#set new position to car 98
addi $r10, $r10, 1 		#i++ to avoid running into car that was just updated (also means we won't have adjacent cars moving right) 99
j 51 					#moveCarsLoop 100
#wrapR:
sub $r4, $r10, $r15 	#101
sw $r1, 0($r4)			#102
addi $r10, $r10, 1 		#i++ 103
j 51 					#moveCarsLoop 104
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 105
ldi $r23, 0				#------------------ 106
ldi $r24, 0				#107
ldi $r25, 0				#reset display bits 108
ldi $r26, 0				#109
ldi $r27, 0				#------------------ 110
#column1: 				#check 0, 6, 12, 18, 24, 30, 36, 42
lw $r4, 0($r0)			#111
add $r23, $r23, $r4 	#112
sll $r23, $r23, 1 		#113
lw $r4, 6($r0) 			#114
add $r23, $r23, $r4 	#115
sll $r23, $r23, 1 		#116
lw $r4, 12($r0) 		#117
add $r23, $r23, $r4 	#118
sll $r23, $r23, 1 		#119
lw $r4, 18($r0)			#120
add $r23, $r23, $r4 	#121
sll $r23, $r23, 1	 	#122
lw $r4, 24($r0) 		#123
add $r23, $r23, $r4 	#124
sll $r23, $r23, 1 		#125
lw $r4, 30($r0) 		#126
add $r23, $r23, $r4 	#127
sll $r23, $r23, 1 		#128
lw $r4, 36($r0) 		#129
add $r23, $r23, $r4 	#130
sll $r23, $r23, 1 		#131
lw $r4, 42($r0) 		#132
add $r23, $r23, $r4 	#133
#column2:				#check 1, 7, 13, 19, 25, 31, 37, 43
lw $r4, 1($r0)			#134
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 7($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 13($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 19($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1	
lw $r4, 25($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 31($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 37($r0)
add $r24, $r24, $r4
sll $r24, $r24, 1
lw $r4, 43($r0)
add $r24, $r24, $r4 	#156
#column3: 				#check 2, 8, 14, 20, 26, 32, 38, 44
lw $r4, 2($r0)			#157
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
add $r25, $r25, $r4 	#179
#column4:				#check 3, 9, 15, 21, 27, 33, 39, 45
lw $r4, 3($r0)			#180
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 9($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 15($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 21($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1	
lw $r4, 27($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 33($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 39($r0)
add $r26, $r26, $r4
sll $r26, $r26, 1
lw $r4, 45($r0)
add $r26, $r26, $r4 	#202
#column5:				#check 4, 10, 16, 22, 28, 34, 40, 46
lw $r4, 4($r0)			#203
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 10($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 16($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 22($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1	
lw $r4, 28($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 34($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 40($r0)
add $r27, $r27, $r4
sll $r27, $r27, 1
lw $r4, 46($r0)
add $r27, $r27, $r4 	#225
#draw:					#Draw LED MATRIX
ldi $r22, 1 			#turn on LED display 226
j 27 					#gameLoop 227
#win:
addi $r11, $r11, 1 		#score++ 228
j 1 					#main 229
#lose: 					#can subtract score, save high score, etc.
j 1 					#main 230

.data