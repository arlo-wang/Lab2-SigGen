module counter #(
    parameter WIDTH = 8
) (
    input  logic             clk,    // clock
    input  logic             rst,    // reset
    input  logic [WIDTH-1:0] incr,   // 8-bit increment input

    output logic [WIDTH-1:0] addr
);
    
    logic [WIDTH-1:0]

always_ff @ (posedge clk) begin
    if (rst)
        count <= {WIDTH{1'b0}};
    else if (en)
        count <= count + incr;
end
endmodule
