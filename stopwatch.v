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