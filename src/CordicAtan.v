
`ifndef M_CordicAtan
`define M_CordicAtan
`include "includes/defines.v"
`include "Trigonometric/ROM_16.v"

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

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt <= 5'b11111;
        else if (!valid)
            cnt <= cnt + 1;
    end

    reg signed [31:0] x_iter;
    reg signed [31:0] y_iter;
    reg [31:0] theta_acc;
    reg [15:0] theta_step;

    get_radian u_get_radian (
        .address(cnt),
        .data(theta_step)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid <= 0;
            x_iter <= x_in;
            y_iter <= y_in;
            theta_acc <= 0;
        end else begin
            if (y_iter == 0) begin
                x_iter <= x_iter;
                y_iter <= y_iter;
                theta_acc <= theta_acc;
                theta <= theta_acc;
                valid <= 1;
            end else begin
                if (cnt == 5'b11111) begin
                    case ({x_in[15], y_in[15]})
                        2'00: begin
                            x_iter <= x_in;
                            y_iter <= y_in;
                            theta_acc <= 0;
                        end
                        2'01: begin
                            x_iter <= -x_in;
                            y_iter <= y_in;
                            theta_acc <= 90 << 16;
                        end
                        2'11: begin
                            x_iter <= x_in;
                            y_iter <= y_in;
                            theta_acc <= 0;
                        end
                        2'10: begin
                        end 

                    endcase
                    
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