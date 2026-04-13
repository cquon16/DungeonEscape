;;; mantle input script
;;; runs while A+B is held
;;; Tile 13 collision = #$0D

LDX player1_object

    LDA myMantle
    BEQ +checkStartMantle

    SEC
    SBC #$01
    STA myMantle

    ChangeActionStep player1_object, #$04

    LDA Object_direction,x
    AND #%00000001
    BEQ +mantleRightMove

+mantleLeftMove
    LDA Object_x_hi,x
    SEC
    SBC #$0A
    STA Object_x_hi,x

    LDA Object_y_hi,x
    SEC
    SBC #$02
    STA Object_y_hi,x

    LDA myMantle
    BEQ +mantleLeftEnd
    RTS

+mantleLeftEnd
    ChangeActionStep player1_object, #$00
    RTS

+mantleRightMove
    LDA Object_x_hi,x
    CLC
    ADC #$0A
    STA Object_x_hi,x

    LDA Object_y_hi,x
    SEC
    SBC #$02
    STA Object_y_hi,x

    LDA myMantle
    BEQ +mantleRightEnd
    RTS

+mantleRightEnd
    ChangeActionStep player1_object, #$00
    RTS

+checkStartMantle
    LDA Object_direction,x
    AND #%00000001
    BEQ +checkRight

+checkLeft
    LDA Object_x_hi,x
    SEC
    SBC #$01
    STA temp
    JMP +setY

+checkRight
    LDA Object_x_hi,x
    CLC
    ADC #$10
    STA temp

+setY
    LDA Object_y_hi,x
    CLC
    ADC #$08
    STA temp1
    JSR getPointColTable

    CheckCollisionPoint temp, temp1, #$0D, tempA
    BEQ +startMantle
    RTS

+startMantle
    LDA #$07
    STA myMantle
    ChangeActionStep player1_object, #$04
    RTS