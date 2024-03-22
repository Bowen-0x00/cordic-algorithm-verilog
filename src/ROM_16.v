`ifndef M_get_radian
`define M_get_radian

module get_radian (
  input [4:0] address,
  output reg [15:0] data
);
    always @(*) begin
        case (address)
            4'd0:  data = 16'b1100100100001111;
            4'd1:  data = 16'b0111011010110001;
            4'd2:  data = 16'b0011111010110110;
            4'd3:  data = 16'b0001111111010101;
            4'd4:  data = 16'b0000111111111010;
            4'd5:  data = 16'b0000011111111111;
            4'd6:  data = 16'b0000001111111111;
            4'd7:  data = 16'b0000000111111111;
            4'd8:  data = 16'b0000000011111111;
            4'd9:  data = 16'b0000000001111111;
            4'd10: data = 16'b0000000000111111;
            4'd11: data = 16'b0000000000011111;
            4'd12: data = 16'b0000000000001111;
            4'd13: data = 16'b0000000000000111;
            4'd14: data = 16'b0000000000000011;
            4'd15: data = 16'b0000000000000001;
            default: data = 0;
        endcase
    end
endmodule

`endif