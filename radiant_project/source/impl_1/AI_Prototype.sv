module seven_segment_multiplexer (
    input  logic        clk,         // System clock
    input  logic        rst_n,       // Active-low reset
    input  logic [3:0]  in0,         // First 4-bit input
    input  logic [3:0]  in1,         // Second 4-bit input
    output logic [6:0]  seg,         // Seven-segment outputs (a to g)
    output logic [1:0]  an           // Anode signals for two displays (active-low)
);

    // Internal register to store which digit is active (0 or 1)
    logic sel;

    // Muxed input to decoder
    logic [3:0] muxed_input;

    // Clock divider for multiplexing (about 1 kHz for human persistence of vision)
    logic [15:0] clk_div;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_div <= 0;
            sel     <= 0;
        end else begin
            clk_div <= clk_div + 1;
            if (clk_div == 0)  // rollover => toggle digit
                sel <= ~sel;
        end
    end

    // Select input based on current digit (sel)
    always_comb begin
        case (sel)
            1'b0: begin
                muxed_input = in0;
                an = 2'b10; // enable digit 0 (common-anode, active-low)
            end
            1'b1: begin
                muxed_input = in1;
                an = 2'b01; // enable digit 1 (common-anode, active-low)
            end
        endcase
    end

    // Decoder logic (4-bit to 7-segment)
    always_comb begin
        case (muxed_input)
            4'h0: seg = 7'b0000001;
            4'h1: seg = 7'b1001111;
            4'h2: seg = 7'b0010010;
            4'h3: seg = 7'b0000110;
            4'h4: seg = 7'b1001100;
            4'h5: seg = 7'b0100100;
            4'h6: seg = 7'b0100000;
            4'h7: seg = 7'b0001111;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0000100;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b1100000;
            4'hC: seg = 7'b0110001;
            4'hD: seg = 7'b1000010;
            4'hE: seg = 7'b0110000;
            4'hF: seg = 7'b0111000;
            default: seg = 7'b1111111; // All segments off
        endcase
    end

endmodule
