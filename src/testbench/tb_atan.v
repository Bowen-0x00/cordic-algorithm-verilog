`timescale 1ns/1ns
`include "includes/defines.v"
`include "Trigonometric/CordicAtan_angle.v"

module tb_atan;

reg clk;
reg rst_n;
reg signed [8:0] angle;
wire valid;
reg [15:0] x_in;
reg [15:0] y_in;
wire [31:0] theta;

CordicAtan u_CordicAtan(
    .clk(clk),
    .rst_n(rst_n),
    .valid(valid),
    .x_in(x_in),       
    .y_in(y_in),       
    .theta(theta)  
);
initial begin
	$dumpfile("tb_atan.vcd");
	$dumpvars(0, tb_atan);
end

always begin
    #10
    clk = ~clk;
end

integer i;
integer golden;
real radian;
initial begin
    clk <= 0;
    rst_n <= 0;
    x_in <= 16'd10000;
    y_in <= 16'd0;
    i <= 0;
    golden <= 0;
    #13
    rst_n <= 1;
    
    #1000000
    $finish;
end

always @(posedge valid) begin
    if (i >= 360) begin
        $display("success");
        $finish;
    end
    #4
    if (theta - golden <= 9'h185|| golden - theta <= 9'h185) begin//0.006
        // $display((theta > golden ? theta - golden : golden - theta) * 0.0000152587890625);
    end else begin
        $display("fail at: %d", i);
        $finish;
    end
    
    i = i + 1;
    rst_n <= 0;
    radian = i * 3.1415926535897932384626433832795 / 180.0;    
    x_in <= 16'd10000 * $cos(radian);
    y_in <= 16'd10000 * $sin(radian);
    golden <= i << 16;
    #4
    rst_n <= 1;
end


// initial begin
//     clk <= 0;
//     rst_n <= 0;
//     x_in <= 16'd10000;
//     y_in <= 16'd1763;
//     #13
    
//     rst_n <= 1;
//     #100000
//     $finish;
// end


endmodule