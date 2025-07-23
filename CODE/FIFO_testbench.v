`timescale 1ns / 1ps

module fifo_tb;

    // Inputs
    reg clk, rst;
    reg wr_en, rd_en;
    reg [7:0] buf_in;

    // Outputs
    wire [7:0] buf_out;
    wire buf_empty, buf_full;
    wire [6:0] fifo_counter;

    // Instantiate the FIFO
    fifo uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .fifo_counter(fifo_counter)
    );

    // Clock generation
    always #5 clk = ~clk;

    integer i;

    initial begin
        $display("Starting FIFO Testbench...");
        $monitor("T=%0t | Wr=%b, Rd=%b, In=%0d, Out=%0d, Cnt=%0d, Full=%b, Empty=%b",
                  $time, wr_en, rd_en, buf_in, buf_out, fifo_counter, buf_full, buf_empty);

        // Initialization
        clk = 0; rst = 1;
        wr_en = 0; rd_en = 0; buf_in = 0;

        // Reset
        #10;
        rst = 0;

        // === Write 64 values ===
        $display("\n--- Writing to FIFO ---");
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 0;
            buf_in = i;
        end
        @(posedge clk); wr_en = 0;

        // === Overflow protection test ===
        $display("\n--- Writing when FIFO is full ---");
        @(posedge clk);
        wr_en = 1; buf_in = 8'hAA;
        @(posedge clk);
        wr_en = 0;

        // === Read all 64 values ===
        $display("\n--- Reading from FIFO ---");
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            wr_en = 0;
            rd_en = 1;
        end
        @(posedge clk); rd_en = 0;

        // === Underflow protection test ===
        $display("\n--- Reading when FIFO is empty ---");
        @(posedge clk);
        rd_en = 1;
        @(posedge clk);
        rd_en = 0;

        // === Simultaneous Read/Write ===
        $display("\n--- Simultaneous Read and Write ---");
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 1;
            buf_in = i + 100;
        end
        wr_en = 0; rd_en = 0;

        // Read remaining
        $display("\n--- Reading remaining values ---");
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
        end
        rd_en = 0;

        $display("\n--- Testbench Complete ---");
        $finish;
    end

endmodule
