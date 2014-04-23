.text
main: 
ldi $r1, 1 				#object position, car increment 0
ldi $r3, 44 			#current frog position, set to starting position 1
sw $r1, 44($r0)			#put frog position in memory 2
#gameLoop:
#updateBoard: 			#SET LED display bits
ldi $r22, 0				#turn off LED display 3
ldi $r25, 0				#reset display bits 4
#column3: 				#check 2, 8, 14, 20, 26, 32, 38, 44
lw $r4, 2($r0)			#5
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
add $r25, $r25, $r4 	#27
#draw:					#Draw LED MATRIX
ldi $r22, 1 			#turn on LED display 28
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
j 3 					#gameLoop 29

.data