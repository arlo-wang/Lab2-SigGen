module counter #(
    parameter WIDTH = 8
) (
    input  logic             clk,    // clock
    input  logic             rst,    // reset
    input  logic             en,
    input  logic [WIDTH-1:0] incr,   // 8-bit increment input
    input  logic [WIDTH-1:0] vbdValue,

    output logic [WIDTH-1:0] count
);

always_ff @ (posedge clk) begin
    if (rst)
        count <= {WIDTH{1'b0}};
    else if (en)
        count <= count + incr;
end
endmodule
