`timescale 1ns/1ns
`include "includes/defines.v"
`include "Trigonometric/angle_to_radian.v"

module tb_angle_to_radian;

reg [8:0] angle;
wire [31:0] radian;

angle_to_radian u_angle_to_radian (
    .angle(angle),
    .radian(radian)
);


initial begin
	$dumpfile("tb_angle_to_radian.vcd");
	$dumpvars(0, tb_angle_to_radian);
end

    integer i;
    integer golden;
initial begin
    angle = 0;   
    #3;
    for (i = 0; i <= 360; i++) begin
        angle <= i;
        golden <= i * (1<<16) * (3.141592653589 / 180.0);
        #1
        if (radian - golden <= 10 || golden - radian <= 10) begin//0.00015
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