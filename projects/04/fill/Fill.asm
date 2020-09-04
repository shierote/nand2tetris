// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
  @R0
  M=0
(LOOP)
  @24576
  D=M
  @KEY_PUSHED
  D;JNE
(KEY_NOT_PUSHED)
  @R1
  M=0
  @CHECK_STATE_CHANGE
  0;JMP
(KEY_PUSHED)
  @R1
  M=1
(CHECK_STATE_CHANGE)
  @R0 // before
  D=M
  @R1 // now
  D=D-M
  @LOOP
  D;JEQ // not change

  @R1
  D=M
  @R0
  M=D
  @EMPTY_DISPLAY_LOOP
  D;JEQ // D=0

(BLACK_DISPLAY_LOOP)
  @i // i: 0~255(step 32)
  M=0 // i=0
(BLACK_DISPLAY_ROW_LOOP)
  @j // j: 0~15
  M=0 // j=0
(BLACK_DISPLAY_COLUMN_LOOP)
  @i
  D=M
  @j
  D=D+M
  @SCREEN
  A=A+D
  M=-1

  @j
  M=M+1 // j++

  @32
  D=A
  @j
  D=M-D // 16-j
  @BLACK_DISPLAY_COLUMN_LOOP // when 16-j=0
  D;JNE

  @32
  D=A
  @i
  M=M+D // i=i+32

  @8192
  D=A
  @i
  D=M-D
  @BLACK_DISPLAY_ROW_LOOP
  D;JNE

  @LOOP
  0;JMP

(EMPTY_DISPLAY_LOOP)
  @i // i: 0~255(step 32)
  M=0 // i=0
(EMPTY_DISPLAY_ROW_LOOP)
  @j // j: 0~15
  M=0 // j=0
(EMPTY_DISPLAY_COLUMN_LOOP)
  @i
  D=M
  @j
  D=D+M
  @SCREEN
  A=A+D
  M=-1

  @j
  M=M+1 // j++

  @32
  D=A
  @j
  D=M-D // 16-j
  @EMPTY_DISPLAY_COLUMN_LOOP // when 16-j=0
  D;JNE

  @32
  D=A
  @i
  M=M+D // i=i+32

  @8192
  D=A
  @i
  D=M-D
  @EMPTY_DISPLAY_ROW_LOOP
  D;JNE

  @LOOP
  0;JMP
