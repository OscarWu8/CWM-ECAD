//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
    parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
//From the module
    reg rst;
    reg clk;
    reg change; 
    reg on_off;
    wire [7:0]counter_out;
//For testing purposes
    reg err;
    reg [7:0]counter_out_prev;


//Todo: Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end


//Todo: User logic
    initial begin
       rst=1;
       change=0;
       on_off=1;
       err=0;
       counter_out_prev=0;
       #(CLK_PERIOD*10)
       if (counter_out!=0) begin
          $display("TEST FAILED"); 
          err=1; 
       end
       #(CLK_PERIOD*10)
       rst=0;
       if (counter_out!=0) begin
          $display("TEST FAILED"); 
          err=1; 
       end
       #(CLK_PERIOD*10)
       change=1;
       
       forever begin
       counter_out_prev=on_off ? counter_out_prev+1 : counter_out_prev-1;
        if (counter_out_prev!=counter_out) begin
          $display("TEST FAILED"); 
          err=1; 
        end
       end
    end
//Todo: Finish test, check for success
     initial begin
        #400 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
     end
//Todo: Instantiate counter module
     monitor top(
     .rst(rst),
     .clk(clk),
     .change(change),
     .on_off(on_off),
     .counter_out(counter_out)
     );
endmodule 
