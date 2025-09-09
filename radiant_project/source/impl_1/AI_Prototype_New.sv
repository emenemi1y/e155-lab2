//============================================================
// Two-digit 7-seg time-multiplex using a single decoder
// - Common-anode displays (active-low segments).
// - One decoder instance, alternately fed by two 4-bit inputs.
// - Each display's 7-bit bus is registered so both hold steady.
//============================================================

module top_mux2_7seg #(
    // Select which counter bit sets the multiplex rate.
    // With a ~12–48 MHz on-chip osc, 15..18 yields ~1–3 kHz refresh.
    parameter int SEL_BIT = 16
)(
    input  logic        reset_n,         // active-low reset
    output logic [6:0]  seg0,            // 7-bit segments for digit 0 (active-low)
    output logic [6:0]  seg1,            // 7-bit segments for digit 1 (active-low)

    // Two 4-bit values to display (hex 0..F)
    input  logic [3:0]  a,               // left (or first) digit value
    input  logic [3:0]  b                // right (or second) digit value
);

    // -------------------------
    // On-chip oscillator
    // -------------------------
    logic clk;

    // TODO: hook up your oscillator here.
    // Replace this block with the exact instance from your provided file.
    // Example 1 (Lattice iCE40 primitive):
    // SB_HFOSC #(.CLKHF_DIV("0b00")) u_osc (.CLKHF(clk), .CLKHFEN(1'b1), .CLKHFPU(1'b1));
    //
    // Example 2 (your custom oscillator module with a 'clk' output):
    // my_oscillator u_osc (.clk(clk));
    //
    // To keep this text self-contained, default to a simple 'clk' wire
    // driven elsewhere if you paste this into an existing top that already has a clock.
    // For synthesis, ensure 'clk' is driven by your on-chip oscillator.

    // -------------------------
    // Refresh / select counter
    // -------------------------
    logic [SEL_BIT:0] divcnt;
    logic             sel;       // 0 -> update seg0 from 'a', 1 -> update seg1 from 'b'

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            divcnt <= '0;
        end else begin
            divcnt <= divcnt + 1'b1;
        end
    end

    assign sel = divcnt[SEL_BIT];

    // -------------------------
    // Single decoder instance
    // -------------------------
    logic [3:0] s_mux;
    logic [6:0] seg_decoded; // active-low segments from decoder

    // Mux which nibble feeds the decoder on this cycle
    always_comb begin
        s_mux = (sel == 1'b0) ? a : b;
    end

    // TODO: hook up your seven-segment decoder here.
    // Must match your provided module's exact name/ports.
    // Expected interface (common-anode active-low output):
    //   module seven_seg_decoder(input logic [3:0] s, output logic [6:0] seg);
    sevseg u_dec (
        .s   (s_mux),
        .seg (seg_decoded)
    );

    // -------------------------
    // Per-digit output registers
    // (Hold last decoded value so both digits appear steady)
    // -------------------------
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            seg0 <= 7'h7F;  // all OFF for common anode (active-low)
            seg1 <= 7'h7F;
        end else begin
            if (sel == 1'b0) begin
                // Currently decoding 'a' -> update digit 0 outputs
                seg0 <= seg_decoded;
            end else begin
                // Currently decoding 'b' -> update digit 1 outputs
                seg1 <= seg_decoded;
            end
        end
    end

endmodule

//============================================================
// Example top that wires in the oscillator and this mux module
// (Use this if you want a single drop-in top-level. Otherwise,
//  instantiate top_mux2_7seg inside your project’s top.)
//============================================================
module top (
    input  logic        reset_n,         // active-low reset
    input  logic [3:0]  a,
    input  logic [3:0]  b,
    output logic [6:0]  seg0,
    output logic [6:0]  seg1
);
    // On-chip oscillator instance (replace with your provided one)
    logic clk;

    // ------- Replace this with your exact oscillator -------
    // Example for Lattice iCE40 (uncomment if applicable):
    // SB_HFOSC #(.CLKHF_DIV("0b00")) u_osc (.CLKHF(clk), .CLKHFEN(1'b1), .CLKHFPU(1'b1));

    // If your provided oscillator is named differently, e.g.:
    // oscillator u_osc (.clk(clk));
    // ------------------------------------------------------

    // Tie off 'clk' temporarily if your project’s top already provides it elsewhere:
    // assign clk = 1'b0; // REMOVE: placeholder — you must drive clk from your oscillator

    // Instantiate the 2-digit mux using the single decoder
    top_mux2_7seg #(.SEL_BIT(16)) u_mux (
        .reset_n (reset_n),
        .seg0    (seg0),
        .seg1    (seg1),
        .a       (a),
        .b       (b)
    );

    // In case your flow expects 'clk' inside u_mux, you can expose and connect it:
    // Modify top_mux2_7seg to take 'clk' as an input if preferred.

endmodule
