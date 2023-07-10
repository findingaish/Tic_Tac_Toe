module tic_tac_toe_game(
    input clock,
    input reset,
    input play,
    input pc,
    input [3 : 0] computer_position, player_position,

    // positions to play

    output wire [1 : 0] p1, p2, p3,
    p4, p5, p6, p7, p8, p9,

    // LED display for positions
    // 01: Player
    // 10: Computer
    output wire [1 : 0] who
    // who the winner is
);

wire [15:0] PC_en; // Computer enable signals
wire [15:0] PL_en; // Player enable signals
wire illegal_move; // disable writing when an illegal move is detected

// wire [1:0] p1,p2,p3,p4,p5,p6,p7,p8,p9;   // positions stored

wire win;           // win signal
wire computer_play; // computer enabling signal
wire player_play;   // player enabling signal
wire no_space;      // no space signal

// Position registers

position_registers position_reg_unit(
    clock,
    reset,
    illegal_move,
    PC_en [8:0],
    PL_en [8:0],
    p1, p2, p3, p4, p5, p6, p7, p8, p9 // positions stored
);

// Winner Detector

winner_detector win_detect_unit(p1, p2, p3, p4, p5, p6, p7, p8, p9, win, who);

// position decoder for computer

position_decoder pd1(computer_position, computer_play, PC_en);

// position decoder for player

position_decoder pd2(player_position, player_play, PL_en);

// illegal move detector
illegal_move_detector imd_unit(
    p1, p2, p3, p4, p5, p6, p7, p8, p9,
    PC_en [8:0], PL_en [8:0],
    illegal_move);

// no space detector
nospace_detector nsd_unit(
    p1, p2, p3, p4, p5, p6, p7, p8, p9,
    no_space);
fsm_controller tic_tac_toe_controller(
    clock,
    reset,
    play,
    pc,
    illegal_move,
    no_space,
    win,
    computer_play,
    player_play);
endmodule

    // Position registers to store player or computer positions
    // when enabling by the FSM controller

    module
    position_registers(
        input clock,
        input reset,
        input illegal_move,
        input [8:0] PC_en,
        input [8:0] PL_en,
        output reg [1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9);

// Position 1
always @(posedge clock or posedge reset)
        begin
    if (reset)
        p1
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p1 <= p1; // keep previous position
else if (PC_en[0] == 1'b1)
        p1 <= 2'b10; // store computer data
else if (PL_en[0] == 1'b1)
        p1 <= 2'b01; // store player data
else p1 <= p1;       // keep previous position
end
        end

            // Position 2
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p2
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p2 <= p2;
else if (PC_en[1] == 1'b1)
        p2 <= 2'b10;
else if (PL_en[1] == 1'b1)
        p2 <= 2'b01;
else p2 <= p2;
end
        end

            // Position 3
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p3
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p3 <= p3;
else if (PC_en[2] == 1'b1)
        p3 <= 2'b10;
else if (PL_en[2] == 1'b1)
        p3 <= 2'b01;
else p3 <= p3;
end
        end

            // Position 4
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p4
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p4 <= p4;
else if (PC_en[3] == 1'b1)
        p4 <= 2'b10;
else if (PL_en[3] == 1'b1)
        p4 <= 2'b01;
else p4 <= p4;
end
        end

            // Position 5
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p5
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p5 <= p5;
else if (PC_en[4] == 1'b1)
        p5 <= 2'b10;
else if (PL_en[4] == 1'b1)
        p5 <= 2'b01;
else p5 <= p5;
end
        end

            // Position 6
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p6
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p6 <= p6;
else if (PC_en[5] == 1'b1)
        p6 <= 2'b10;
else if (PL_en[5] == 1'b1)
        p6 <= 2'b01;
else p6 <= p6;
end
        end

            // Position 7
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p7
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p7 <= p7;
else if (PC_en[6] == 1'b1)
        p7 <= 2'b10;
else if (PL_en[6] == 1'b1)
        p7 <= 2'b01;
else p7 <= p7;
end
        end

            // Position 8
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p8
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p8 <= p8;
else if (PC_en[7] == 1'b1)
        p8 <= 2'b10;
else if (PL_en[7] == 1'b1)
        p8 <= 2'b01;
else p8 <= p8;
end
        end

            // Position 9
            always @(posedge clock or posedge reset)
                begin
    if (reset)
        p9
    <= 2'b00;
else begin if (illegal_move == 1'b1)
        p9 <= p9;
else if (PC_en[8] == 1'b1)
        p9 <= 2'b10;
else if (PL_en[8] == 1'b1)
        p9 <= 2'b01;
else p9 <= p9;
end
    end
        endmodule

            // FSM controller to control how player and computer play the TIC TAC TOE GAME
            // The FSM is implemented based on the designed state diagram

            module
            fsm_controller(
                input clock,
                input reset,
                play,
                pc,
                illegal_move,
                no_space,
                win,
                output reg computer_play,
                player_play);

// FSM States
parameter IDLE = 2'b00;
parameter PLAYER = 2'b01;
parameter COMPUTER = 2'b10;
parameter GAME_DONE = 2'b11;
reg [1:0] current_state, next_state;

// current state registers
always @(posedge clock or posedge reset)
        begin
    if (reset)
        current_state
    <= IDLE;
else current_state <= next_state;
end

    // next state
    always @(*)
        begin
    case (current_state)
        IDLE:
begin if (reset == 1'b0 && play == 1'b1)
        next_state <= PLAYER; // player to play
else next_state <= IDLE;
player_play <= 1'b0;
computer_play <= 1'b0;
end
        PLAYER : begin
                     player_play <= 1'b1;
computer_play <= 1'b0;
if (illegal_move == 1'b0)
    next_state <= COMPUTER; // computer to play
else
    next_state <= IDLE;
end
        COMPUTER : begin
                       player_play <= 1'b0;
if (pc == 1'b0)
    begin
            next_state <= COMPUTER;
computer_play <= 1'b0;
end else if (win == 1'b0 && no_space == 1'b0)
        begin
            next_state <= IDLE;
computer_play <= 1'b1; // computer to play when PC=1
end else if (no_space == 1 || win == 1'b1)
        begin
            next_state <= GAME_DONE; // game done
computer_play <= 1'b1;               // computer to play when PC=1
end
        end
            GAME_DONE : begin // game done
                            player_play <= 1'b0;
computer_play <= 1'b0;
if (reset == 1'b1)
    next_state <= IDLE; // reset the game to IDLE
else
    next_state <= GAME_DONE;
end default : next_state <= IDLE;
endcase
    end
        endmodule

            // NO SPACE detector
            // to detect if no more spaces to play

            module nospace_detector(
                input [1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9,
                output wire no_space);
wire temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9;

// detect no more space
assign temp1 = p1[1] | p1[0];
assign temp2 = p2[1] | p2[0];
assign temp3 = p3[1] | p3[0];
assign temp4 = p4[1] | p4[0];
assign temp5 = p5[1] | p5[0];
assign temp6 = p6[1] | p6[0];
assign temp7 = p7[1] | p7[0];
assign temp8 = p8[1] | p8[0];
assign temp9 = p9[1] | p9[0];

// output
assign no_space = ((((((((temp1 & temp2) & temp3) & temp4) & temp5) & temp6) & temp7) & temp8) & temp9);
endmodule

    // Illegal move detector
    // to detect if a player plays on an exist position

    module illegal_move_detector(
        input [1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9,
        input [8:0] PC_en, PL_en,
        output wire illegal_move);
wire temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9;
wire temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19;
wire temp21, temp22;
// player : illegal moving
assign temp1 = (p1[1] | p1[0]) & PL_en[0];
assign temp2 = (p2[1] | p2[0]) & PL_en[1];
assign temp3 = (p3[1] | p3[0]) & PL_en[2];
assign temp4 = (p4[1] | p4[0]) & PL_en[3];
assign temp5 = (p5[1] | p5[0]) & PL_en[4];
assign temp6 = (p6[1] | p6[0]) & PL_en[5];
assign temp7 = (p7[1] | p7[0]) & PL_en[6];
assign temp8 = (p8[1] | p8[0]) & PL_en[7];
assign temp9 = (p9[1] | p9[0]) & PL_en[8];
// computer : illegal moving
assign temp11 = (p1[1] | p1[0]) & PC_en[0];
assign temp12 = (p2[1] | p2[0]) & PC_en[1];
assign temp13 = (p3[1] | p3[0]) & PC_en[2];
assign temp14 = (p4[1] | p4[0]) & PC_en[3];
assign temp15 = (p5[1] | p5[0]) & PC_en[4];
assign temp16 = (p6[1] | p6[0]) & PC_en[5];
assign temp17 = (p7[1] | p7[0]) & PC_en[6];
assign temp18 = (p8[1] | p8[0]) & PC_en[7];
assign temp19 = (p9[1] | p9[0]) & PC_en[8];

// intermediate signals
assign temp21 = ((((((((temp1 | temp2) | temp3) | temp4) | temp5) | temp6) | temp7) | temp8) | temp9);
assign temp22 = ((((((((temp11 | temp12) | temp13) | temp14) | temp15) | temp16) | temp17) | temp18) | temp19);

// output illegal move
assign illegal_move = temp21 | temp22;
endmodule

    // To decode the position being played, a 4-to-16 decoder with high active output is needed.
    // When a button is pressed, a player will play and the position at IN [3:0] will be decoded
    // to enable writing to the corresponding registers
    module position_decoder(input [3:0] in, input enable, output wire [15:0] out_en);
reg [15:0] temp1;
assign out_en = (enable == 1'b1) ? temp1 : 16'd0;
always @(*)
    begin
    case (in)4'd0:
temp1 <= 16'b0000000000000001;
4'd1 : temp1 <= 16'b0000000000000010;
4'd2 : temp1 <= 16'b0000000000000100;
4'd3 : temp1 <= 16'b0000000000001000;
4'd4 : temp1 <= 16'b0000000000010000;
4'd5 : temp1 <= 16'b0000000000100000;
4'd6 : temp1 <= 16'b0000000001000000;
4'd7 : temp1 <= 16'b0000000010000000;
4'd8 : temp1 <= 16'b0000000100000000;
4'd9 : temp1 <= 16'b0000001000000000;
4'd10 : temp1 <= 16'b0000010000000000;
4'd11 : temp1 <= 16'b0000100000000000;
4'd12 : temp1 <= 16'b0001000000000000;
4'd13 : temp1 <= 16'b0010000000000000;
4'd14 : temp1 <= 16'b0100000000000000;
4'd15 : temp1 <= 16'b1000000000000000;
default:
temp1 <= 16'b0000000000000001;
endcase
    end
        endmodule

            // winner detector circuit
            // We will win when we have 3 similar (x) or (O) in the following pairs:
            // (1,2,3); (4,5,6);(7,8,9); (1,4,7); (2,5,8);(3,6,9); (1,5,9);(3,5,7);

            module winner_detector(input [1:0] p1, p2, p3, p4, p5, p6, p7, p8, p9, output wire winner, output wire [1:0] who);
wire win1, win2, win3, win4, win5, win6, win7, win8;
wire [1:0] who1, who2, who3, who4, who5, who6, who7, who8;
winner_detect_3 u1(p1, p2, p3, win1, who1); // (1,2,3);
winner_detect_3 u2(p4, p5, p6, win2, who2); // (4,5,6);
winner_detect_3 u3(p7, p8, p9, win3, who3); // (7,8,9);
winner_detect_3 u4(p1, p4, p7, win4, who4); // (1,4,7);
winner_detect_3 u5(p2, p5, p8, win5, who5); // (2,5,8);
winner_detect_3 u6(p3, p6, p9, win6, who6); // (3,6,9);
winner_detect_3 u7(p1, p5, p9, win7, who7); // (1,5,9);
winner_detect_3 u8(p3, p5, p6, win8, who8); // (3,5,7);
assign winner = (((((((win1 | win2) | win3) | win4) | win5) | win6) | win7) | win8);
assign who = (((((((who1 | who2) | who3) | who4) | who5) | who6) | who7) | who8);
endmodule

    // winner detection for 3 positions and determine who the winner is
    // Player: 01
    // Computer: 10
    module winner_detect_3(input [1:0] pos0, p1, p2, output wire winner, output wire [1:0] who);
wire [1:0] temp0, temp1, temp2;
wire temp3;
assign temp0[1] = !(pos0[1] ^ p1[1]);
assign temp0[0] = !(pos0[0] ^ p1[0]);
assign temp1[1] = !(p2[1] ^ p1[1]);
assign temp1[0] = !(p2[0] ^ p1[0]);
assign temp2[1] = temp0[1] & temp1[1];
assign temp2[0] = temp0[0] & temp1[0];
assign temp3 = pos0[1] | pos0[0];
// winner if 3 positions are similar and should be 01 or 10
assign winner = temp3 & temp2[1] & temp2[0];
// determine who the winner is
assign who[1] = winner & pos0[1];
assign who[0] = winner & pos0[0];
endmodule

    // testbench

`timescale 1ns /
    1ps

    module tb_tic_tac_toe;

// Inputs
reg clock;
reg reset;
reg play;
reg pc;
reg [3:0] computer_position;
reg [3:0] player_position;

// Outputs
wire [1:0] pled1;
wire [1:0] pled2;
wire [1:0] pled3;
wire [1:0] pled4;
wire [1:0] pled5;
wire [1:0] pled6;
wire [1:0] pled7;
wire [1:0] pled8;
wire [1:0] pled9;
wire [1:0] who;

tic_tac_toe_game uut(
        .clock(clock),
        .reset(reset),
        .play(play),
        .pc(pc),
        .computer_position(computer_position),
        .player_position(player_position),
        .p1(pled1),
        .p2(pled2),
        .p3(pled3),
        .p4(pled4),
        .p5(pled5),
        .p6(pled6),
        .p7(pled7),
        .p8(pled8),
        .p9(pled9),
        .who(who));
// clock
initial begin
    clock = 0;
forever #5 clock = ~clock;
end
    initial begin
        // Initialize Inputs
        play = 0;
reset = 1;
computer_position = 0;
player_position = 0;
pc = 0;
# 100;
reset = 0;
# 100;
play = 1;
pc = 0;
computer_position = 4;
player_position = 0;
# 50;
pc = 1;
play = 0;
# 100;
reset = 0;
play = 1;
pc = 0;
computer_position = 8;
player_position = 1;
# 50;
pc = 1;
play = 0;
# 100;
reset = 0;
play = 1;
pc = 0;
computer_position = 6;
player_position = 2;
# 50;
pc = 1;
play = 0;
# 50
pc = 0;
play = 0;

$dumpfile("dump.vcd");
$dumpvars();

end

    endmodule
