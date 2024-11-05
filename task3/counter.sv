module counter #(
    parameter WIDTH = 8
) (
    input  logic             clk,
    input  logic             rst,
    input  logic [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] addr
);

logic [WIDTH-1:0] counter_reg;

always_ff @ (posedge clk or posedge rst) begin
    if (rst)
        count <= {WIDTH{1'b0}};
    else if (en)
        count <= count + incr;
end

assign addr = counter_reg // output the current counter value as the address
endmodule
