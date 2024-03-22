
`ifndef M_CordicAtan
`define M_CordicAtan
`include "includes/defines.v"
`include "Trigonometric/ROM_16_angle.v"

module CordicAtan #(
    parameter DW = 32
) (
    input                       clk,
    input                       rst_n,
    output reg                  valid,
    input signed [15:0]         x_in,       
    input signed [15:0]         y_in,       
    output reg signed [31:0]    theta  
);
    reg [4:0] cnt;
    wire signed [31:0] x_extended = {{8{x_in[15]}}, x_in, 8'd0};
    wire signed [31:0] y_extended = {{8{y_in[15]}}, y_in, 8'd0};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt <= 5'b11111;
        else if (!valid)
            cnt <= cnt + 1;
    end

    reg signed [31:0] x_iter;
    reg signed [31:0] y_iter;
    reg signed [31:0] theta_acc;
    reg [31:0] theta_step;
    assign theta_step[31:22] = 0;

    get_radian u_get_radian (
        .address(cnt),
        .data(theta_step[21:0])
    );
    task automatic convert_to_quadrant_one();
        case ({x_in[15], y_in[15]})
            2'b00: begin
                x_iter <= x_extended;
                y_iter <= y_extended;
                theta_acc <= 0;
            end
            2'b10: begin
                x_iter <= y_extended;
                y_iter <= -x_extended;
                theta_acc <= 90 << 16;
            end
            2'b11: begin
                x_iter <= -x_extended;
                y_iter <= -y_extended;
                theta_acc <= 180 << 16;
            end
            2'b01: begin
                x_iter <= -y_extended;
                y_iter <= x_extended;
                theta_acc <= 270 << 16;
            end 
        endcase
    endtask //automatic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid <= 0;
            convert_to_quadrant_one();         
        end else begin
            if (y_iter[31:8] == 0 || cnt == 5'b11110) begin
                x_iter <= x_iter;
                y_iter <= y_iter;
                theta_acc <= theta_acc;
                theta <= theta_acc;
                valid <= 1;
            end else begin
                if (cnt == 5'b11111) begin
                    convert_to_quadrant_one();
                end else begin
                    //x_2 = x1 - y1 * di * tan
                    //y_2 = y1 + x1 * di * tan
                    if (y_iter[31] == 1'b0) begin// > 0 clockwise
                        x_iter <= x_iter + (y_iter >>> cnt);
                        y_iter <= y_iter - (x_iter >>> cnt);
                        theta_acc <= theta_acc + theta_step;
                    end else begin// > 0 counterclockwise di = -1
                        x_iter <= x_iter - (y_iter >>> cnt);
                        y_iter <= y_iter + (x_iter >>> cnt);
                        theta_acc <= theta_acc - theta_step;
                    end
                end
            end
        end
    end

endmodule

`endif