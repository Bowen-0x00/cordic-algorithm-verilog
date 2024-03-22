`timescale 1ns/1ns
`include "includes/defines.v"
`include "Trigonometric/angle_to_radian.v"
`include "Trigonometric/radian_to_angle.v"

module tb_radian_to_angle;

reg [8:0] angle;
wire [8:0] angle_o;
reg [31:0] radian;



angle_to_radian u_angle_to_radian (
    .angle(angle),
    .radian(radian)
);

radian_to_angle u_radian_to_angle (
    .radian(radian),
    .angle(angle_o)
);

initial begin
	$dumpfile("tb_radian_to_angle.vcd");
	$dumpvars(0, tb_radian_to_angle);
end

    integer i;
    integer golden;
initial begin
    angle = 0;   
    #3;
    for (i = 0; i <= 360; i++) begin
        #1
        if (radian - angle_o <= 1 || golden - angle_o <= 1) begin//0.00015
        end else begin
            $display("fail at: %d", angle);
            $finish;
        end
        #1;
    end
    $display("success");

    #100 $finish;
end

endmodule