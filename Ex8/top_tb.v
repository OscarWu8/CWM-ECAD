//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 100ps

module top_tb(
    );
    
     //Parameters
      parameter CLK_PERIOD = 10;


     //Regitsers and wires
       //From the module
        reg clk_p; 
        wire clk_n;
        reg rst_n;
        reg [4:0]temp;
        wire heating;
        wire cooling;
        wire [1:0]state;
       //For testing purposes
        reg err;
        reg [1:0]state_prev;


     //Clock generation
       initial
       begin
          clk_p = 1'b1;
          forever
          #(CLK_PERIOD/2) clk_p=~clk_p;
       end


     //Testing output
      initial begin
         err = 0;
         temp = 5'd15;


         forever begin
               #(CLK_PERIOD*3)       //give the system some time to reach steady state
               if(temp<=18 && heating!=1) begin
                  $display("***TEST FAILED 1***");
                  err = 1;
               end

               if(temp>=22 && cooling!=1) begin
                  $display("***TEST FAILED 2***");
                  err = 1;
               end

               if(state_prev==2'b00 && state==2'b00) begin
                  if(temp<=18 || temp>=22) begin
                  $display("***TEST FAILED 3***");
                  err = 1;
                  end 
               end

               if(heating==1 && cooling==1) begin
                  $display("***TEST FAILED 4***");
                  err = 1;
               end 

               state_prev = state;
               temp = temp + 1;     //increase temperature by one each time
            end
      end
          

     //Finish test, check for success
         initial begin
             #300 
             if (err==0)
                $display("***TEST PASSED! :) ***");
                $finish;
         end


         
     //Instantiate counter module
      top top(
      .clk_p(clk_p),
      .clk_n(clk_n),
      .rst_n(rst_n),
      .temperature_0(temp[0]),
      .temperature_1(temp[1]),
      .temperature_2(temp[2]),
      .temperature_3(temp[3]),
      .temperature_4(temp[4]),
      .heating(heating),
      .cooling(cooling)
     );

endmodule 
