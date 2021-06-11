//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module lights(

    //add ports
     input rst,
     input clk,
     input button,
     output reg [2:0]colour
    );

    //no extra wires or regs needed

    //add user logic
   always @(posedge clk) begin
       if(rst)
          colour = 3'b001;
       else begin
          if(button) begin
               if(colour<=3'b101)
                  colour = colour + 3'b001;
               else
                  colour = 3'b001;
          end
          else
               if(colour==3'b000||colour==3'b111)
                  colour = 3'b001;
       end
   end
endmodule


