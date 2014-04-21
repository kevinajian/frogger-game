.data

.text
main: 
	ldi $r1, 1 #frog position, car increment
	ldi $r2, 2 #car position
	ldi $r3, 37 #current frog position
	ldi $r5, 5 #frog increment,
	ldi $r6, 37 #start position, bottom boundary
	sw $r1, 37($r0)
gameLoop:
processInput:
	bne $r8, $r0, bottomBoundary #if key3/down was pressed
	bne $r9, $r0, frogUp
	j processCars
bottomBoundary:
	ldi $r8, 0 #resets key3/down to 0
	bne $r3, $r6 frogDown
	j processCars
frogDown:
	sw $r0, 0($r3) #set old position to nothing
	add $r3, $r3, $r5 #frog position down
	sw $r1, 0($r3) #set new position to frog
	j processCars
frogUp:
	sw $r0, 0($r3) #set old position to nothing
	sub $r3, $r3, $r5 #frog position up
	sw $r1, 0($r3) #set new position to frog
	blt $r3, $r0, win #if frog position is less than 0
	j processCars

updateCars:
	
newCars:

updateBoard:

	j gameLoop:

win:
	addi $r31, $r31, 1 #score++
	j main