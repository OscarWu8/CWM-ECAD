//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Air Conditioning
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
        reg [4:0]temp;
        wire heating, cooling;
       //For testing purposes
        reg err;


     //Clock generation
       initial
       begin
          clk = 1'b1;
          forever
          #(CLK_PERIOD/2) clk=~clk;
       end


     //Testing output
         initial begin
         err=0;

            forever begin
               #CLK_PERIOD
               temp = $urandom_range(30,10);    //use the random function to generate a random temperature
               #(CLK_PERIOD*3)                  //give the system some time to reach steady state
               if(temp<18 && heating!=1) begin
                  $display("***TEST FAILED 1***");
                  err = 1;
               end
               else if(temp>22 && cooling!=1) begin
                  $display("***TEST FAILED 2***");
                  err = 1;
               end
               else if(heating==1 && cooling==1) begin
                  $display("***TEST FAILED 3***");
                  err = 1;
               end 
            end
         end
          

     //Finish test, check for success
         initial begin
             #1000 
             if (err==0)
                $display("***TEST PASSED! :) ***");
                $finish;
         end


     //Instantiate counter module
      AC top(
      .clk(clk),
      .temp(temp),
      .heating(heating),
      .cooling(cooling)
     );
endmodule 
