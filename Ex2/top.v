//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module doorbell(
    
    //Todo: define inputs here
    input A,
    input B,
    input sel,
    output out
    );
    
    //Todo: define registers and wires here
    reg out;


    //Todo: define your logic here   
    always @ (posedge clk)
       if (sel) gein
           #5 out <= A;
       end
       else begin
           #5 out <= B
       end              
      
endmodule
