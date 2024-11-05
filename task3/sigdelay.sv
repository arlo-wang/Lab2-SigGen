module sigdelay #(
    parameter A_WIDTH = 9,
              D_WIDTH = 8
) (
    input logic                 clk,
    input logic                 rst,
    input logic                 wr_en,
    input logic                 rd_en,
    input logic [A_WIDTH-1:0]   offset,
    input logic [D_WIDTH-1:0]   mic_signal,

    output logic [D_WIDTH-1:0]  delayed_signal
);

logic [A_WIDTH-1:0] wr_addr;
logic [A_WIDTH-1:0] rd_addr;
logic [D_WIDTH-1:0] ram_data_out; // output read from ram


// write address counter
always_ff @(posedge clk or posedge rst) begin 
    if (rst) 
        wr_addr <= 9'd0;
    else if (wr_en)
        wr_addr <= wr_addr + 1;
end

assign rd_addr = wr_addr + offset; // obatin the read address

ram2ports radio_ram (
    .clk        (clk),
    .wr_addr    (wr_addr),
    .rd_addr    (rd_addr),
    .data_in    (mic_signal),
    .wr_en      (wr_en),
    .data_out   (ram_data_out)
);

assign delayed_signal = ram_data_out;

endmodule
