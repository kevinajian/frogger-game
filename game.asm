.text
main: 
	ldi $r1, 1 				#object position, car increment
	ldi $r2, 2 				#
	ldi $r3, 44 			#current frog position, set to starting position
	ldi $r5, 44 			#start position, bottom boundary
	ldi $r6, 6 				#frog increment
	ldi $r13, 3 			#
	ldi $r14, 4 			#
	ldi $r15, 5				#----------
	ldi $r16, 11			#
	ldi $r17, 17			#
	ldi $r18, 23			#boundaries
	ldi $r19, 29			#
	ldi $r20, 35			#
	ldi $r21, 41			#----------
	sw $r1, 9($r0)			#----------
	sw $r1, 10($r0)			#
	sw $r1, 12($r0)			#
	sw $r1, 15($r0)			#
	sw $r1, 19($r0)			#
	sw $r1, 25($r0)			#load cars into positions
	sw $r1, 26($r0)			#
	sw $r1, 27($r0)			#
	sw $r1, 31($r0)			#
	sw $r1, 38($r0)			#
	sw $r1, 40($r0)			#----------
	sw $r1, 44($r0)			#put frog position in memory	
gameLoop:
	processInput:
		nop 					#-----------
		nop 					#tells processor to look for input
		nop 					#
		nop 					#-----------
		bne $r8, $r0, checkBot 	#if down was pressed
		bne $r9, $r0, frogUp	#if up was pressed
		j moveCars
	checkBot:					#moves down if not at bottom boundary
		ldi $r8, 0				#resets down to 0
		bne $r3, $r5, frogDown 	#if not at bottom
		j moveCars
	frogDown:
		sw $r0, 0($r3) 			#set old position to nothing
		add $r3, $r3, $r6 		#frog position down
		lw $r4, 0($r3)
		beq $r4, $r1, lose 		#if a car is already there
		sw $r1, 0($r3) 			#set new position to frog
		j moveCars
	frogUp:
		ldi $r9, 0				#resets up to 0
		sw $r0, 0($r3) 			#set old position to nothing
		sub $r3, $r3, $r6 		#frog position up
		lw $r4, 0($r3)
		beq $r4, $r1, lose 		#if a car is already there
		sw $r1, 0($r3) 			#set new position to frog
		beq $r3, $r2, win 		#if frog position is at 2
	moveCars:
		ldi $r10, 6 			#i=6
	moveCarsLoop: 				#for i=6 -> 40
		beq $r10, $r21, updateBoard #i==41
		beq $r10, $r3, iterate	#in frog position
		lw $r4, 0($r10) 		#get led status
		beq $r4, $r1, moveCar
	iterate:
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop
	moveCar:						#i >= 6
		blt $r10, $r16, moveCar2	#i < 11
		blt $r10, $r17, moveCar3	#i < 17
		blt $r10, $r18, moveCar4	#i < 23
		blt $r10, $r19, moveCar5	#i < 29
		blt $r10, $r20, moveCar6	#i < 35
		blt $r10, $r21, moveCar7	#i < 41
	moveCar2:					#i >= 6, < 11
		j carLeft
	moveCar3:					#i < 17
		bne $r10, $r16, carRight#i > 11
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop	
	moveCar4:					#i < 23
		bne $r10, $r17, carRight#i > 17
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop	
	moveCar5:					#i < 29
		bne $r10, $r18, carLeft	#i > 23
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop	
	moveCar6:					#i < 35
		bne $r10, $r19, carLeft	#i > 29
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop	
	moveCar7:					#i < 41
		bne $r10, $r20, carRight#i > 35
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop	
	carLeft:
		sw $r0, 0($r10)			#set old position to nothing
		sub $r10, $r10, $r1 	#car position left
		beq $r10, $r3, lose		#if frog is there
		beq $r10, $r15, wrapL	#-----------
		beq $r10, $r18, wrapL	#if car moved off board
		beq $r10, $r19, wrapL	#-----------
		sw $r1, 0($r10)			#set new position to car
		addi $r10, $r10, 2 		#i+=2
		j moveCarsLoop
	wrapL:
		addi $r4, $r10, 5		
		sw $r1, 0($r4)			#set new position to car
		addi $r10, $r10, 2 		#i+=2
		j moveCarsLoop
	carRight:
		sw $r0, 0($r10)			#set old position to nothing
		addi $r10, $r10, 1 		#car position right
		beq $r10, $r3, lose		#if frog is there
		beq $r10, $r17, wrapR	#-----------
		beq $r10, $r18, wrapR	#if car moved off board
		beq $r10, $r21, wrapR	#-----------
		sw $r1, 0($r10)			#set new position to car
		addi $r10, $r10, 1 		#i++ to avoid running into car that was just updated (also means we won't have adjacent cars moving right)
		j moveCarsLoop
	wrapR:
		sub $r4, $r10, $r15
		sw $r1, 0($r4)
		addi $r10, $r10, 1 		#i++
		j moveCarsLoop
	updateBoard: 				#SET LED display bits
		ldi $r22, 0				#turn off LED display
		ldi $r23, 0				#------------------
		ldi $r24, 0				#
		ldi $r25, 0				#reset display bits
		ldi $r26, 0				#
		ldi $r27, 0				#------------------
	column1: 					#check 0, 6, 12, 18, 24, 30, 36, 42
		lw $r4, 0($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 6($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 12($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 18($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1	
		lw $r4, 24($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 30($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 36($r0)
		add $r23, $r23, $r4
		sll $r23, $r23, 1
		lw $r4, 42($r0)
		add $r23, $r23, $r4
	column2:					#check 1, 7, 13, 19, 25, 31, 37, 43
		lw $r4, 1($r0)
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
		add $r24, $r24, $r4
	column3: 					#check 2, 8, 14, 20, 26, 32, 38, 44
		lw $r4, 2($r0)
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
		add $r25, $r25, $r4
	column4:					#check 3, 9, 15, 21, 27, 33, 39, 45
		lw $r4, 3($r0)
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
		add $r26, $r26, $r4
	column5:					#check 4, 10, 16, 22, 28, 34, 40, 46
		lw $r4, 4($r0)
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
		add $r27, $r27, $r4
	draw:						#Draw LED MATRIX
		ldi $r22, 1 			#turn on LED display
		j gameLoop
win:
	addi $r11, $r11, 1 		#score++
	j main
lose: 						#can subtract score, save high score, etc.
	j main

.data