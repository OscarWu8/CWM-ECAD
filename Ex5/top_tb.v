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
        wire [1:0]state;
       //For testing purposes
        reg err;
        reg [1:0]state_prev;

        assign state[1] = heating;
        assign state[0] = cooling;


     //Clock generation
       initial
       begin
          clk = 1'b1;
          forever
          #(CLK_PERIOD/2) clk=~clk;
       end


     //Testing output
      initial begin
        temp = 5'd15;      //set temperature to an initial value
        err=0;
        state_prev = state;

            forever begin
               #(CLK_PERIOD*3)       //give the system some time to reach steady state
               if(temp<18 && heating!=1) begin
                  $display("***TEST FAILED 1***");
                  err = 1;
               end

               if(temp>22 && cooling!=1) begin
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
             #200 
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
