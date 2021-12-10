.text
main:
	#set the 2 registers below to 0 (as initialization)
	add x5,x0,x0			#register x5: record result of calculation
	add x6,x0,x0			#register x6: record instructions
	lui x7,8
	addi x7,x7,-0x100		#set x7: 0x7f00(the length of the imm is limited)
	addi x10,x0,1			#symbolize: equal
	addi x11,x0,2			#symbolize: multiply
	addi x12,x0,4			#symbolize: sub
	addi x13,x0,8			#symbolize: add
	addi x9,x0,0x10
	sw x0,0x20(x7)			#record portc
	lw x4,0x0(x7)			#save porta
	lw x8,0x10(x7)			#save portb

loop:
	lw x14,0x0(x7)			#read porta
	lw x15,0x10(x7)			#read portb
	bne x8,x15,PortbChange
	bne x4,x14,PortaChange
	j loop

PortbChange:
	add x8,x0,x15			#reset porta's register
	add x16,x0,x15
	sw x16,0x20(x7)
	j loop

PortaChange:
	add x4,x0,x14
	add x17,x0,x14
loop2:
	lw x14,0x0(x7)			#check porta's value
	bne x14,x0,loop2		#wait until porta's value == 0 (not pressed)
	add x4,x0,x0
	bne x6,x0,case
	add x6,x17,x0			#record porta temporarily
	add x5,x16,x0			#record portb tem[prarily
	j loop			
	
case:
	beq x6,x11,multi_
	beq x6,x12,sub_
	beq x6,x13,add_
	j result

sub_:
	sub x5,x5,x16
	sw x5,0x20(x7)
	j result	
add_:
	add x5,x5,x16
	sw x5,0x20(x7)
	j result
multi_:
	add x18,x0,x0			#product=0
	add x19,x5,x0			#multiplicand=x5
	addi x20,x0,0x10		#loopcnt=16
judge:
	andi x21,x16,0x1		#multiplier&1
	bne x21,x10,shift		#the lowest bit != 1 : needless to add
	add x18,x18,x19
shift:
	slli x19,x19,1			#multiplicand << 1
	srli x16,x16,1			#multiplier >> 1
	addi x20,x20,-1
	bne x20,x0,judge		# cnt ?= 0
	add x5,x18,x0
	sw x5,0x20(x7)
result:
	add x6,x17,x0
	bne x17,x10,loop
	add x6,x0,x0			#clear last instr(operation)
	add x16,x5,x0			#renew the param
	j loop
