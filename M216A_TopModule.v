`timescale 1ns / 100ps

//Do NOT Modify This Module
module P1_Reg_8_bit (DataIn, DataOut, rst, clk);

    input [7:0] DataIn;
    output [7:0] DataOut;
    input rst;
    input clk;
    reg [7:0] DataReg;
   
    always @(posedge clk)
  	if(rst)
            DataReg <= 8'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg;
endmodule

//Do NOT Modify This Module
module P1_Reg_5_bit (DataIn, DataOut, rst, clk);

    input [4:0] DataIn;
    output [4:0] DataOut;
    input rst;
    input clk;
    reg [4:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg <= 5'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg;
endmodule

//Do NOT Modify This Module
module P1_Reg_4_bit (DataIn, DataOut, rst, clk);

    input [3:0] DataIn;
    output [3:0] DataOut;
    input rst;
    input clk;
    reg [3:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg <= 4'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg;
endmodule

//Do NOT Modify This Module's I/O Definition
module M216A_TopModule(
    clk_i,
    width_i,
    height_i,
    index_x_o,
    index_y_o,
    strike_o,
    rst_i
);

input clk_i;
input [4:0] width_i;
input [4:0] height_i;
output [7:0] index_x_o;
output [7:0] index_y_o;
output [3:0] strike_o;
input rst_i;

wire clk_i;
wire [4:0] width_i;
wire [4:0] height_i;
wire rst_i;

//Add your code below 
//Make sure to Register the outputs using the Register modules given above

// Parameters to store max height information
localparam HEIGHT1 = 8; 
localparam HEIGHT2 = 8;
localparam HEIGHT3 = 9;
localparam HEIGHT4 = 7;
localparam HEIGHT5 = 10;
localparam HEIGHT6 = 6;
localparam HEIGHT7 = 11;
localparam HEIGHT8 = 5;
localparam HEIGHT9 = 12;
localparam HEIGHT10 = 4;
localparam HEIGHT11 = 16;
localparam HEIGHT12 = 16;
localparam HEIGHT13 = 16;

// Parameters to store Y index information given strip ID
localparam INDEX1 = 0;
localparam INDEX2 = 8;
localparam INDEX3 = 16;
localparam INDEX4 = 25;
localparam INDEX5 = 32;
localparam INDEX6 = 42;
localparam INDEX7 = 48;
localparam INDEX8 = 59;
localparam INDEX9 = 64;
localparam INDEX10 = 76;
localparam INDEX11 = 80;
localparam INDEX12 = 96;
localparam INDEX13 = 112;

// 1) Input flops:

reg [4:0] width_d1;
reg [4:0] height_d1;

P1_Reg_5_bit ff_width(.DataIn(width_i), DataOut(width_d1), rst(rst_i), clk(clk_i));
P1_Reg_5_bit ff_height(.DataIn(height_i), DataOut(height_d1), rst(rst_i), clk(clk_i));

// 2) possible candidate strips -> output: strip_A, strip_B, strip_C (strip IDs)

// Stage flops
reg [4:0] width_d2;
reg [1:0] num_cand_d2;
reg [3:0] id_a_d2;
reg [3:0] id_b_d2;
reg [3:0] id_c_d2;

// Wires
reg [3:0] strip_ID_A;
reg [3:0] strip_ID_B;
reg [3:0] strip_ID_C;
reg [1:0] numCand;

always @(clk_i) begin
    case(width_d1)
        5'b00100 :	begin //program height = 4
                strip_ID_A = 4'b1010; //Strip ID = 10 
                strip_ID_B = 4'b1000; //Strip ID = 8
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b00101 :	begin //program height = 5
                strip_ID_A = 4'b1000; //Strip ID = 8
                strip_ID_B = 4'b0110; //Strip ID = 6
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b00110 :	begin //program height = 6
                strip_ID_A = 4'b0110; //Strip ID = 6
                strip_ID_B = 4'b0100; //Strip ID = 4
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b00111 :	begin //program height = 7
                strip_ID_A = 4'b0100; //Strip ID = 4
                strip_ID_B = 4'b0001; //Strip ID = 1
                strip_ID_C = 4'b0010; //Strip ID = 2
                numCand = 2'b11;
                end
        5'b01000 :	begin //program height = 8
                strip_ID_A = 4'b0001; //Strip ID = 1
                strip_ID_B = 4'b0010; //Strip ID = 2
                strip_ID_C = 4'b0011; //Strip ID = 3
                numCand = 2'b11;
                end
        5'b01001 :	begin //program height = 9
                strip_ID_A = 4'b0011; //Strip ID = 3
                strip_ID_B = 4'b0101; //Strip ID = 5
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b01010 :	begin //program height = 10
                strip_ID_A = 4'b0101; //Strip ID = 5
                strip_ID_B = 4'b0111; //Strip ID = 7
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b01011 :	begin //program height = 11
                strip_ID_A = 4'b0111; //Strip ID = 7
                strip_ID_B = 4'b1001; //Strip ID = 9
                strip_ID_C = 4'b0000;
                numCand = 2'b10;
                end
        5'b01100 :	begin //program height = 12
                strip_ID_A = 4'b1001; //Strip ID = 9
                strip_ID_B = 4'b0000;
                strip_ID_C = 4'b0000;
                numCand = 2'b01;
                end
        default : 	begin //program height = 13, 14, 15, 16
                strip_ID_A = 4'b1101; //Strip ID = 13
                strip_ID_B = 4'b1100; //Strip ID = 12
                strip_ID_C = 4'b1011; //Strip ID = 11
                numCand = 2'b11;
                end
        // FIXME: Default should be an incorrect case because this is comb logic
    endcase
end

always @(posedge clk_i) begin
    if (rst_i) begin
        // Reset flops
        width_d2    <= 5'b0;
        num_cand_d2 <= 2'b0;

        id_a_d2     <= 4'b0;
        id_b_d2     <= 4'b0;
        id_c_d2     <= 4'b0;
    end else begin
        width_d2    <= width_d1;
        height_d2   <= height_d1;
        num_cand_d2 <= numCand;
        
        id_a_d2     <= strip_ID_A;
        id_b_d2     <= strip_ID_B;
        id_c_d2     <= strip_ID_C; 
    end
end
	
// 3) read cycle: output: width_A, width_B, width_C

// Stage flops
reg [4:0] width_d3;
reg [1:0] num_cand_d3;
reg [3:0] id_a_d3;
reg [3:0] id_b_d3;
reg [3:0] id_c_d3;
reg [7:0] occupied_A_d3;
reg [7:0] occupied_B_d3;
reg [7:0] occupied_C_d3;

// Wires
reg [7:0] occupied_width_A;
reg [7:0] occupied_width_B;
reg [7:0] occupied_width_C;


//TODO: reg
//TODO: Julia - Read reg

always @(posedge clk_i) begin
    if (rst_i) begin
        // Reset flops
        width_d3    <= 5'b0;
        num_cand_d3 <= 2'b0;

        id_a_d3     <= 4'b0;
        id_b_d3     <= 4'b0;
        id_c_d3     <= 4'b0;
        occupied_A_d3   <= 8'b0;
        occupied_B_d3   <= 8'b0;
        occupied_C_d3   <= 8'b0;
    end else begin
        width_d3    <= width_d2;
        num_cand_d3 <= num_cand_d2;
        
        id_a_d3     <= id_a_d2;
        id_b_d3     <= id_b_d2;
        id_c_d3     <= id_c_d2; 
        occupied_A_d3   <= occupied_width_A;
        occupied_B_d3   <= occupied_width_B;
        occupied_C_d3   <= occupied_width_C;
    end
end

// 3) Select the strip

// Stage flops
reg [4:0] width_d4;
reg [3:0] id_selected_d4;
reg [7:0] utilization_d4;

// Wires
reg [3:0] selected_strip;
reg [7:0] occupied_width;

always @(*) begin
    case (num_cand_d3)
        2'b01:
            selected_strip = id_a_d3;
        2'b10: begin
            if (occupied_A_d3 > occupied_B_d3) begin
                selected_strip = id_b_d3;
                occupied_width = occupied_B_d3;
            end
            else begin // (occupied_A_d3 <= occupied_B_d3) 
                selected_strip = id_a_d3; // In the equal case, A should be first preference
                occupied_width = occupied_A_d3;
            end
        end
        2'b11: begin
            if (occupied_A_d3 < occupied_B_d3) begin
                if (occupied_A_d3 > occupied_C_d3) begin 
                    selected_strip = id_c_d3;
                    occupied_width = occupied_C_d3;
                end
                else begin // (occupied_A_d3 <= occupied_C_d3)
                    selected_strip = id_a_d3; // When equal, A is preferred over C
                    occupied_width = occupied_A_d3;
                end
            end
            else if (occupied_A_d3 > occupied_B_d3) begin
                if (occupied_B_d3 > occupied_C_d3) begin 
                    selected_strip = id_c_d3;
                    occupied_width = occupied_C_d3;
                end
                else begin // (occupied_B_d3 <= occupied_C_d3)
                    selected_strip = id_b_d3; // When equal, B is preferred over C
                    occupied_width = occupied_B_d3;
                end
            end
            else (occupied_A_d3 == occupied_B_d3) begin
                if (occupied_A_d3 > occupied_C_d3) begin
                    selected_strip = id_c_d3; 
                    occupied_width = occupied_C_d3;
                end
                else begin // (occupied_A_d3 <= occupied_C_d3)
                    selected_strip = id_a_d3; // When equal, A is preferred over C
                    occupied_width = occupied_A_d3;
                end
            end
        end
    endcase
end

always @(posedge clk_i) begin
    if (rst_i) begin
        // Reset flops
        width_d4        <= 5'b0;
        id_selected_d4  <= 4'b0;
        utilization_d4  <= 8'b0;
    end else begin
        width_d4        <= width_d3;
        id_selected_d4  <= selected_strip;
        utilization_d4  <= occupied_width;
    end   
end

// 4) Adder

// Stage flops
reg [7:0] utilization_d5;
reg [7:0] y_d5;

// Wires

// Adder goes here (something like width_d4 + utilization_d4)

// Comb logic to match id_selected_d4 to the correct x coordinate (use localparams INDEX# at the top)

always @(posedge clk_i) begin
    if (rst_i) begin
        // Reset flops
        utilization_d5  <= 8'b0;
        y_d5            <= 8'b0;
    end else begin
        utilization_d4  <= // TODO: Result from adder;
        y_d5            <= // TODO: Requires a case statement;
    end   
end

// 5) Write back and outputs

// Stage flops
reg [3:0] strike_d6;
reg [7:0] x_d6;
reg [7:0] y_d6;

// Strike condition logic goes here

always @(posedge clk_i) begin
    if (rst_i) begin
        // Reset flops
        strike_d6   <= 4'b0;
        x_d6        <= 8'b0;
        y_d6        <= 8'b0;
    end else begin
        strike_d6   <= ; 
        x_d6        <= ; // TODO: x and y are dependent on strike condition
        y_d6        <= ;
    end   
end

// 6) Delay stage?

// 7) Output stage?

endmodule
