`ifndef M_get_radian
`define M_get_radian

module get_radian (
  input [5:0] address,
  output reg [27:0] data
);
    always @(*) begin
        case (address)
            5'd0:  data = 28'b1100100100001111110110101010;
            5'd1:  data = 28'b0111011010110001100111000001;
            5'd2:  data = 28'b0011111010110110111010111111;
            5'd3:  data = 28'b0001111111010101101110101001;
            5'd4:  data = 28'b0000111111111010101011011101;
            5'd5:  data = 28'b0000011111111111010101010110;
            5'd6:  data = 28'b0000001111111111111010101010;
            5'd7:  data = 28'b0000000111111111111111010101;
            5'd8:  data = 28'b0000000011111111111111111010;
            5'd9:  data = 28'b0000000001111111111111111111;
            5'd10: data = 28'b0000000000111111111111111111;
            5'd11: data = 28'b0000000000011111111111111111;
            5'd12: data = 28'b0000000000001111111111111111;
            5'd13: data = 28'b0000000000000111111111111111;
            5'd14: data = 28'b0000000000000011111111111111;
            5'd15: data = 28'b0000000000000001111111111111;
            5'd16: data = 28'b0000000000000000111111111111;
            5'd17: data = 28'b0000000000000000011111111111;
            5'd18: data = 28'b0000000000000000001111111111;
            5'd19: data = 28'b0000000000000000000111111111;
            5'd20: data = 28'b0000000000000000000011111111;
            5'd21: data = 28'b0000000000000000000001111111;
            5'd22: data = 28'b0000000000000000000000111111;
            5'd23: data = 28'b0000000000000000000000011111;
            5'd24: data = 28'b0000000000000000000000001111;
            5'd25: data = 28'b0000000000000000000000000111;
            5'd26: data = 28'b0000000000000000000000000011;
            5'd27: data = 28'b0000000000000000000000000010;
            default: data = 0;
        endcase
    end
endmodule

`endif