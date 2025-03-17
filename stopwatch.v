//clock divider to generate 1hz and 10hz clock 
module clock_divider(
    input clk,   //100Mhz fpga clock
    input reset,
    output reg clk_1hz, // 1Hz clock output (seconds)
    output reg clk_10hz // 10Hz clock (tenths of a second)
);

reg [26:0] count_1hz = 0;
reg [26:0] count_10hz = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count_1hz =0;
        count_10hz =0;
        clk_1hz =0;
        clk_10hz=0;
    end
    else begin
        //100M cyclesto 1hz
        if (count_1hz >=50000000) begin
            count_1hz =0;
            clk_1hz = ~clk_1hz;
        end
        else 
        count_1hz = count_1hz+1;

        if (count_10hz>= 5000000) begin
            count_10hz= 0;
            clk_10hz=~clk_10hz;
        end
        else
        count_10hz = count_10hz +1;
    end
end
endmodule

//counts tenths of a send and seconds, resets to 0 and toggles start/stop 
module stopwatch(
    input clk_10hz, 
    input clk_1hz,
    input start_stop, //toggles counting
    input reset, //resets to 00.0  
    output reg [3:0] sec_ones, //seconds
    output reg [3:0] sec_tens, //tens of seconds
    output reg [3:0] tenths //tenths of a second
);
reg running =0;

always @ (posedge start_stop) begin
    running = ~running;
end

always @ (posedge clk_10hz or posedge reset) begin
    if (reset) begin
        tenths = 0;
        sec_ones =0;
        sec_tens =0;
    end

    else if (running) begin
        if (tenths==9) begin
            tenths =0;
            if(sec_ones==9) begin
                sec_ones =0;
                if (sec_tens==9)
                    sec_tens =0;
                else 
                    sec_ones = sec_ones+1;
            end
            else tenths = tenths +1;
        end
    end
end
endmodule

//module to cycle through the three digits and refresh displey every 1ms
module seven_seg_display(
    input [3:0] digit1, //tens
    input [3:0] digit2, // ones
    input [3:0] digit3, // thenths
    input clk, // 1khz clock for display refresh
    output reg [6:0] seg, //7 seg 
    output reg [6:0] an //anode
);

reg [1:0] digit_select=0;

always @ (posedge clk) begin
    digit_select = digit_select +1;
    case(digit_select)
        2'b00: begin an = 4'b1110; seg = hex_to_seg(digit1); end
        2'b01: begin an = 4'b1101; seg = hex_to_seg(digit2); end
        2'b10: begin an = 4'b1011; seg = hex_to_seg(digit3); end
        2'b11: begin an = 4'b0111; seg = 7'b1111111; end
    endcase
end

function [6:0] hex_to_seg;
    input [3:0] num;
    case (num)
        4'h0: hex_to_seg = 7'b0000001;
        4'h1: hex_to_seg = 7'b1001111;
        4'h2: hex_to_seg = 7'b0010010;
        4'h3: hex_to_seg = 7'b0000110;
        4'h4: hex_to_seg = 7'b1001100;
        4'h5: hex_to_seg = 7'b0100100;
        4'h6: hex_to_seg = 7'b0100000;
        4'h7: hex_to_seg = 7'b0001111;
        4'h8: hex_to_seg = 7'b0000000;
        4'h9: hex_to_seg = 7'b0000100;
        default: hex_to_seg = 7'b1111111;
    endcase
    
endfunction
endmodule
