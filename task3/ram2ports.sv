module ram2ports #(
    parameter   ADDRESS_WIDTH = 9,
                DATA_WIDTH = 8
)(
    input logic                     clk,
    input logic                     wr_en,
    input logic                     rd_en,
    input logic [ADDRESS_WIDTH-1:0] wr_addr,
    input logic [ADDRESS_WIDTH-1:0] rd_addr,
    input logic [DATA_WIDTH-1:0]    data_in,

    output logic [DATA_WIDTH-1:0]   data_out
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (wr_en == 1'b1)
        ram_array[wr_addr] <= data_in; // write data
    if (rd_en == 1'b1)
        data_out <= ram_array [rd_addr]; // read data
end
endmodule
