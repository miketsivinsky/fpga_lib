//******************************************************************************
//*
//*      Project:     Any 
//*
//*      Description: Pulse Formers
//*
//*      Version 0.01
//*
//*      Copyright (c) 2004-2010, Harry E. Zhurov
//*
//*      $Revision: 5 $
//*      $Date:: 2010-07-28 20:56:24 #$
//*
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
`timescale 1ns / 1ps


//------------------------------------------------------------------------------
//
//    Reset pulse former. 
//
//    Creates single pulse with the width of several clk periods
//
module pfr
(
    input      clk,
    output bit q
);

    
reg [1:0] cnt  /* synthesis syn_preserve=1 */;
    
    // synopsys translate_off
    initial  
    begin   
        cnt   = 0;
        q     = 0;
    end 
    // synopsys translate_on
    
    always @(posedge clk) begin
        if(cnt < 3) begin
            cnt <= cnt + 1;
            q <= 1;
        end
        else
            q <= 0;
    end
endmodule
//------------------------------------------------------------------------------
module rst_m
(
    input  bit clk,
    output bit q
);

bit [1:0] cnt  /* synthesis syn_preserve=1 */;
bit       out;

// synopsys translate_off
initial  
begin   
    cnt   = 0;
    out   = 0;
end 
// synopsys translate_on

assign q = ~out;

always @(posedge clk) begin
    if(cnt < 3) begin
        cnt <= cnt + 1;
        out <= 0;
    end
    else
        out <= 1;
end

endmodule
//------------------------------------------------------------------------------
//
//    Simple pulse former. 
//
//    Creates pulse at rising edge on 'in' input. 
//    Output pulse width is one clk period
//
module pf
(
    input      in,
    input      clk,
    input      rst,
    output bit q

);    
    
bit state;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= 0;
            q     <= 0;
        end
        else if(!state) begin
            if(in)   begin
                q     <= 1'b1;
                state <= 1'b1;
            end
        end
        else begin
            q <= 1'b0;
            if(!in)
                state <= 1'b0;
        end
    end
endmodule
//------------------------------------------------------------------------------


