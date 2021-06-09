//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
//Parameters
    parameter CLK_PERIOD = 10;

//Regitsers and wires
//From the module
    reg rst;
    reg clk; 
    reg button;
    wire [2:0]colour;
//For testing purposes
    reg err;
    reg [2:0]colour_prev;

//Clock generation
    initial
    begin
       clk = 1'b1;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end


//User logic
    initial begin
       rst=1;
       button=0;
       err=0;
       colour_prev=3'b001;
       
   //Test 1 Check if the reset function works properly
       #(CLK_PERIOD*2)
       if (colour!=3'b001) begin
          $display("TEST FAILED"); 
          err=1; 
       end

   //Test 2 Check if the counter value stays constant when change=0
       #(CLK_PERIOD*2)
       rst=0;
       #CLK_PERIOD
       if (colour!=3'b001) begin
          $display("TEST FAILED"); 
          err=1; 
       end

   //Test 3 & 4 Check if the counter works properly when change=1
       #(CLK_PERIOD*2)
       button=1;
       colour_prev=colour;
       forever begin
          #CLK_PERIOD
          colour_prev=colour<=3'b101 ? colour_prev+1 : 3'b001; 
          if (colour_prev!=colour) begin
              $display("TEST FAILED"); 
              err=1; 
          end
       end
    end
//Todo: Finish test, check for success
     initial begin
        #200 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
     end
//Todo: Instantiate counter module
     LED top(
     .rst(rst),
     .clk(clk),
     .button(button),
     .colour(colour)
     );
endmodule 
