.data

.text
main: 
	ldi $r1, 1 				#frog position, car increment
	ldi $r2, 2 				#car position
	ldi $r3, 44 			#current frog position
	ldi $r5, 44 			#start position, bottom boundary
	ldi $r6, 6 				#frog increment
	ldi $r12, 41 			#last car position
	ldi $r13, 3 			#
	ldi $r14, 4 			#
	ldi $r15, 5				#
	ldi $r16, 11			#
	ldi $r17, 17			# boundaries
	ldi $r18, 23			#
	ldi $r19, 29			#
	ldi $r20, 35			#
	ldi $r21, 41			#
	sw $r1, 44($r0)
gameLoop:
processInput:
	bne $r8, $r0, bottomBoundary #if key3/down was pressed
	bne $r9, $r0, frogUp
	j moveCars
bottomBoundary:
	ldi $r8, 0 				#resets key3/down to 0
	bne $r3, $r5 frogDown 	#if not at bottom
	j moveCars
frogDown:
	sw $r0, 0($r3) 			#set old position to nothing
	add $r3, $r3, $r6 		#frog position down
	lw $r4, 0($r3)
	beq $r4, $r2, lose 		#if a car is already there
	sw $r1, 0($r3) 			#set new position to frog
	j moveCars
frogUp:
	sw $r0, 0($r3) 			#set old position to nothing
	sub $r3, $r3, $r5 		#frog position up
	lw $r4, 0($r3)
	beq $r4, $r2, lose 		#if a car is already there
	sw $r1, 0($r3) 			#set new position to frog
	beq $r3, $r2, win 		#if frog position is at 2
	j moveCars

moveCars:
	ldi $r10, 6 			#i=6
moveCarsLoop: 				#for i=6 -> 40
	beq $r10, $r12, newCars #i==41
	lw $r4, 0($r10) 		#get led status
	beq $r4, $r2, moveCar
	addi $r10, $r10, 1 		#i++
	j moveCarsLoop

moveCar:						#i > 6
	blt $r10, $r16, moveCar2	#i < 11
	blt $r10, $r17, moveCar3	#i < 17
	blt $r10, $r18, moveCar4	#i < 23
	blt $r10, $r19, moveCar5	#i < 29
	blt $r10, $r20, moveCar6	#i < 35
	blt $r10, $r21, moveCar7	#i < 41
moveCar2:					#i > 6, < 11
	j carLeft
moveCar3:					#i < 17
	bne $r10, $r16, carRight#i > 11
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop	
moveCar4:					#i < 23
	bne $r10, $r17, carRight#i > 17
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop	
moveCar5:					#i < 29
	bne $r10, $r18, carLeft	#i > 23
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop	
moveCar6:					#i < 35
	bne $r10, $r19, carLeft	#i > 29
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop	
moveCar7:					#i < 41
	bne $r10, $r20, carRight#i > 35
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop	
carLeft:
	sw $r0, 0($r10)			#set old position to nothing
	sub $r4, $r10, $r1 		#car position left
	beq $r4, $r3, lose		#if frog is there
	sw $r2, 0($r4)			#set new position to car
	addi $r10, $r10, 1 		#i++
	j updateCarsLoop
carRight:
	sw $r0, 0($r10)			#set old position to nothing
	addi $r4, $r10, $r1 	#car position right
	beq $r4, $r3, lose		#if frog is there
	sw $r2, 0($r4)			#set new position to car
	addi $r10, $r10, 2 		#i+=2 to avoid running into car that was just updated (also means we won't have cars right next to each other going right)
	j updateCarsLoop

newCars:
	ldi $r10, 0 			#i=0
newCarsLoop: 				#for i=0 -> 5
	beq $r10, $r6, updateBoard

	# RANDOM LOGIC
	# if rand < 20, newCar

	addi $r10, $r10, 1		#i++
	j newCarsLoop
newCar:
	beq $r10, $r0,  newCarRow2	#i==0
	beq $r10, $r1,  newCarRow3	#i==1
	beq $r10, $r2,  newCarRow4	#i==2
	beq $r10, $r13, newCarRow5	#i==3
	beq $r10, $r14, newCarRow6	#i==4
	beq $r10, $r15, newCarRow7	#i==5
newCarRow2:
	sw $r2, 10($r0)			#new car
	addi $r10, $r10, 1 		#i++
	j newCarsLoop
newCarRow3:
	sw $r2, 12($r0)
	addi $r10, $r10, 1
	j newCarsLoop
newCarRow4:
	sw $r2, 18($r0)
	addi $r10, $r10, 1
	j newCarsLoop
newCarRow5:
	sw $r2, 28($r0)
	addi $r10, $r10, 1
	j newCarsLoop
newCarRow6:
	sw $r2, 34($r0)
	addi $r10, $r10, 1
	j newCarsLoop
newCarRow7:
	sw $r2, 36($r0)
	addi $r10, $r10, 1
	j newCarsLoop


updateBoard:

	#PAINT LED MATRIX

	j gameLoop

win:
	addi $r11, $r11, 1 		#score++
	j main

lose: 
	#nothing yet
	#can subtract score, save high score, etc.
	j main