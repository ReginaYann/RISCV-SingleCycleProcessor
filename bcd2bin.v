module BCD2binary(
  input  [3:0] thousands_05,
  input  [3:0] hundreds_05,
  input  [3:0] tens_05,
  input  [3:0] ones_05,
  output reg [15:0] binary_05
  ); 
  
  reg [29:0] shifter_05; 
  integer i;
 
  always @(thousands_05,hundreds_05,tens_05,ones_05) 
  begin 
    shifter_05[29:26]=thousands_05;
    shifter_05[25:22]=hundreds_05;
    shifter_05[21:18]=tens_05;
    shifter_05[17:14]=ones_05;
    shifter_05[13:0]=0;
    
    for (i = 0; i< 14; i = i+1) begin 
        shifter_05 = shifter_05  >> 1; 
        if (shifter_05[17:14] >= 8) 
            shifter_05[17:14] = shifter_05[17:14] - 3; 
        if (shifter_05[21:18] >= 8)             
            shifter_05[21:18] = shifter_05[21:18] - 3;
        if (shifter_05[25:22] >= 8)             
            shifter_05[25:22] = shifter_05[25:22] - 3; 
        if (shifter_05[29:26] >= 8)              
            shifter_05[29:26] = shifter_05[29:26] - 3;   
    end  
    
    binary_05={{2{1'b0}},shifter_05[13:0]};
  end

endmodule
