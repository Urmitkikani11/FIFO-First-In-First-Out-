module fifo (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] buf_in,
    output reg [7:0] buf_out,
    output reg buf_empty,
    output reg buf_full,
    output [6:0] fifo_counter  // 7-bit for 0–64 range
);

    // Internal memory and pointers
    reg [7:0] buf_mem [0:63];
    reg [5:0] wr_ptr, rd_ptr;            // 6-bit for 64 entries
    reg [6:0] fifo_counter_reg;          // 7-bit counter

    assign fifo_counter = fifo_counter_reg;

    // -------- FIFO counter logic --------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fifo_counter_reg <= 0;
        end else begin
            case ({wr_en && !buf_full, rd_en && !buf_empty})
                2'b10: fifo_counter_reg <= fifo_counter_reg + 1; // Write only
                2'b01: fifo_counter_reg <= fifo_counter_reg - 1; // Read only
                default: fifo_counter_reg <= fifo_counter_reg;   // No change (read+write or idle)
            endcase
        end
    end

    // -------- Status flags (buf_empty, buf_full) --------
    always @(*) begin
        buf_empty = (fifo_counter_reg == 0);
        buf_full  = (fifo_counter_reg == 64);
    end

    // -------- Write logic --------
    always @(posedge clk) begin
        if (wr_en && !buf_full)
            buf_mem[wr_ptr] <= buf_in;
    end

    // -------- Read logic --------
    always @(posedge clk or posedge rst) begin
        if (rst)
            buf_out <= 8'd0;
        else if (rd_en && !buf_empty)
            buf_out <= buf_mem[rd_ptr];
    end

    // -------- Pointer update logic --------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
        end else begin
            if (wr_en && !buf_full)
                wr_ptr <= wr_ptr + 1;
            if (rd_en && !buf_empty)
                rd_ptr <= rd_ptr + 1;
        end
    end

endmodule
