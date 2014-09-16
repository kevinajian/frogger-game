.text
main:
addi $r1, $r0, 1 			#row 8 0
addi $r2, $r0, 2 			#row 7 1
addi $r3, $r0, 4 			#row 6 2
addi $r4, $r0, 8 			#row 5 3
addi $r5, $r0, 16 		#row 4 4
addi $r6, $r0, 32 		#row 3 5
addi $r7, $r0, 64 		#row 2 6
addi $r10, $r0, 128 		#row 1, win 7
addi $r20, $r0, 1 		#start row 8 8
#processInput:
nop 					#----------- 9
nop 					#tells processor to look for input 10
nop 					#11
nop 					#----------- 12
bne $r8, $r0, 2			#checkBot #if down was pressed 13
bne $r9, $r0, 6			#frogUp	#if up was pressed 14
j 9						#processInput 15
#checkBot:				#moves down if not at bottom boundary
ldi $r8, 0				#resets down to 0 16
bne $r20, $r1, 1		#frogDown if not at bottom 17
j 9						#processInput 18
#frogDown:
sra $r20, $r20, 1 		#shift left one 19
j 9						#processInput 20
#frogUp:
ldi $r9, 0				#resets up to 0 21
sll $r20, $r20, 1 		#22
bne $r20, $r10,	-15		#not win 23
addi $r11, $r11, 1		#win, add score
j 0						#win, resets 24

.data