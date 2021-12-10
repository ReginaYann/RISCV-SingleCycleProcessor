module alu32 #(parameter WIDTH=32)
	(input [WIDTH-1:0] srca,
	input [WIDTH-1:0] srcb,
	input [3:0] alucontrol,
	input [4:0] shamt,
	output reg [WIDTH-1:0]result,
	output zero);

	wire [31:0] bbar=~srcb;
	wire [31:0] addresult;
	wire [31:0] subresult;
	wire [31:0] calresult;
	
	adder32 add0(srca,srcb,1'b0,addresult);
	adder32 add1(srca,bbar,1'b1,subresult);
	assign calresult=(alucontrol[3]==1)?subresult:addresult;
	assign zero=(calresult==32'b0);

	always @* begin
	      case(alucontrol[2:0])
		3'b000:result=calresult;		//add sub
		3'b001:result= srca << shamt; 
		3'b010:result=(subresult[31]==1)?1:0;	//slt
		3'b011:result={(WIDTH){1'bx}}; 	//SLTU
		3'b100:result=srca^srcb;
		3'b101:result={{1'b0}, srca[WIDTH-1:1]}; // srl sra
		3'b110:result=srca | srcb;
		3'b111:result=srca & srcb;
		default: result={(WIDTH){1'bx}};
	      endcase 
	end
endmodule



module adder4(
	input [3:0]num1,
	input [3:0]num2,
	input cin,
	output lastp,
	output lastg,
	output [3:0]result);

	wire [3:0]p;
	wire [3:0]g;
	wire [3:0]c;
	assign p=num1^num2;
	assign g=num1&num2;
	assign c[0]=cin;
	assign c[1]=g[0] | (p[0]&c[0]);
	assign c[2]=g[1] | (p[1]&g[0]) | (p[1]&p[0]&c[0]);
	assign c[3]=g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&c[0]);
	assign lastg=g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) ;
	assign lastp=p[3]&p[2]&p[1]&p[0]; 
	assign result=p^c;

endmodule

module adder16(
	input [15:0] num1,
	input [15:0] num2,
	input cin,
	output lastp,
	output lastg,
	output [15:0] result);

	wire [3:0]                   p;
   	wire [3:0]                   g;
   	wire [3:0]                   c;

   	assign c[0]=cin;
   	assign c[1]=g[0]|(p[0]&c[0]);
   	assign c[2]=g[1]|(p[1]&g[0])|(p[1]&p[0]&c[0]);
   	assign c[3]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&c[0]);

   	assign lastp=p[3]&p[2]&p[1]&p[0];
   	assign lastg=g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]);
	adder4 ad0(num1[3:0], num2[3:0], c[0], p[0], g[0], result[3:0]);
	adder4 ad1(num1[7:4], num2[7:4], c[1], p[1], g[1], result[7:4]);
	adder4 ad2(num1[11:8], num2[11:8], c[2], p[2], g[2], result[11:8]);
	adder4 ad3(num1[15:12], num2[15:12], c[3], p[3], g[3], result[15:12]);
endmodule

module adder32(
	input [31:0] num1,
	input [31:0] num2,
	input cin,
	output [31:0] result);

	wire [1:0] p;
	wire [1:0] g;
	wire [1:0] c;
	assign c[0]=cin;
	assign c[1]=g[0] | (p[0]&c[0]);
	adder16 ad4(num1[15:0],num2[15:0],c[0],p[0],g[0],result[15:0]);
	adder16 ad5(num1[31:16],num2[31:16],c[1],p[1],g[1],result[31:16]);
endmodule

