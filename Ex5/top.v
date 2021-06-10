//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/100ps

module AC (


     //adding ports
      input clk,
      input [4:0]temp,
      output heating,
      output cooling  
);


      reg [1:0]state;  //or output reg [1:0]state;
                      //2-bit state machine


      //let 10-heating, 00-idle, 01-cooling, 11 is not possible
       assign heating = state[1];
       assign cooling = state[0];
    

       always @(posedge clk) begin
            case(state)
               2'b10: state = temp<20 ? 2'b10 : 2'b00;     //when heating is on - if temp<20 then keeps      heating otherwise turns to idle                  
               2'b00: state = temp<=18 ? 2'b10 : temp>=22 ? 2'b01 : 2'b00;    //when in idle state - if temp<=18 turns heating on and when temp>=22 turns cooling on, otherwise stays in idlea state
               2'b01: state = temp>20 ? 2'b01 : 2'b00;     //when cooling is on - if temp>20 keeps cooling otherwise turns to idle
               default: state = 2'b00;     //set default state as idle
            endcase
       end
endmodule
      
