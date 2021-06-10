//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////




`timescale 1ns / 100ps

module top_tb(
    );
    
     //Parameters
      parameter CLK_PERIOD = 10;


     //Regitsers and wires
       //From the module
        reg clk; 
        reg enable;
        reg [2:0]colour;
        wire [23:0]rgb;
       //For testing purposes
        reg err;
        reg [23:0]rgb_prev;


     //Clock generation
       initial
       begin
          clk = 1'b1;
          forever
          #(CLK_PERIOD/2) clk=~clk;
       end


     //Testing output
         initial begin
         enable=1;
         colour=0;
         rgb_prev=0;

         err=0;
            forever begin
               enable=1;       //test if the converter changes states when enable=1
               rgb_prev = rgb;
               colour = colour + 1;
               #(CLK_PERIOD*3)          //give the system some time to change states
               if(rgb_prev==rgb) begin
               $display("***TEST FAILED, RGB not changing***");
                  err = 1;
               end  
                                      
               rgb_prev=rgb;
               enable=0;      //test if the converter stays in the same state when enable=0
               #(CLK_PERIOD*3)          //give the system some time to change state
               if(rgb_prev!=rgb) begin
                  $display("***TEST FAILED, RGB should not be changing***");
                  err = 1;
               end
            end
         end
          

     //Finish test, check for success
         initial begin
             #500 
             if (err==0)
                $display("***TEST PASSED! :) ***");
                $finish;
         end


     //Instantiate counter module
      RGB_CC top(
      .clk(clk),
      .enable(enable),
      .colour(colour),
      .rgb(rgb)
     );
endmodule 

