//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
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
        reg sel;
        reg button
        reg rst
        wire [23:0]light;
       //For testing purposes
        reg err;
        reg [23:0]light_prev;


     //Clock generation
       initial
       begin
          clk = 1'b1;
          forever
          #(CLK_PERIOD/2) clk=~clk;
       end


     //Testing output
      initial begin
         rst = 1;
         button = 0;
         sel = 0;
         light_prev = 0;

         err=0;

         #(CLK_PERIOD*2)

         //Test 1: check if the system outputs the white light when sel=0
          if(light!=24'hFFFFFF) begin
              $display("***TEST FAILED 1, system not selecting while light @ sel=0***");
              err = 1;
          end  

          button = 1;     //button should not affect the system's out when sel=0
          #(CLK_PERIOD*3) 
          if(light!=24'hFFFFFF) begin
              $display("***TEST FAILED 1', system not selecting while light @ sel=0***");
              err = 1;
          end  


         //Test 2: when select is on but rst=0, check if the system outputs the default colour
         sel = 1;
         #(CLK_PERIOD*3)
         if(light!=24'h0000FF) begin
              $display("***TEST FAILED 2, system not setting to default case @ rst=1***");
              err = 1;
         end  


         //Test 3: when reset is off, check if the system operates correctly
         rst = 0;
         forever begin
              light_prev = light;
              #(CLK_PERIOD*3)
              //check if the system's output is changing when button=1
              if(light_prev==light) begin
                  $display("***TEST FAILED 3, output not changing @ button=1***");
                  err = 1;
              end
  
              light_prev = light;
              button = 0;
              #(CLK_PERIOD*3)
              //check if the system's output stays constant when button=0
              if(light_prev!=light) begin
                  $display("***TEST FAILED 4, output should not be changing @ button=0***");
                  err = 1;
              end
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
      LightSelector top(
      .clk(clk),
      .rst(rst),
      .sel(sel),
      .button(button),
      .light(light)
     );

endmodule 
