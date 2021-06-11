//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 100ps

module LightSelector(

    //add ports
     input clk,
     input sel,
     input rst,
     input button,
     output [23:0]light
    );


    //wires or regs
     //wires to connect inputs and outputs of successive modules
     wire [2:0]colour;
     wire [23:0]rgb;
     //define a reg to store white light
     wire [23:0] white = 24'hFFFFFF;


    //Instantiating all modules
     lights lights(
     .rst(rst),
     .clk(clk),
     .button(button),
     .colour(colour)
     );

     converter converter(
     .clk(clk),
     .enable(1),    //set enable=1 always as we want the system to actually be able to select lights
     .colour(colour),
     .rgb(rgb)
     );

     multiplexer multiplexer(
     .a (white),
     .b (rgb),
     .sel (sel),
     .out (light)
     );
        
endmodule

