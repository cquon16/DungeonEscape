;;; slide input script
;;; runs while B is held
;;; mySlide = timer
;;; mySlideLock = prevents retrigger until B is released
;;; action step 5 = slide

LDX player1_object

    ;========================
    ; active slide movement
    ;========================
    LDA mySlide
    BEQ +notSlidingNow

    SEC
    SBC #$01
    STA mySlide

    ChangeActionStep player1_object, #$05

    LDA gamepad
    AND #%11000000
    CMP #%10000000
    BEQ +slideRightMove

    LDA gamepad
    AND #%11000000
    CMP #%01000000
    BEQ +slideLeftMove

    RTS

+slideLeftMove
    LDA Object_x_hi,x
    SEC
    SBC #$02
    STA Object_x_hi,x

    LDA mySlide
    BNE +keepSlidingLeft
    ChangeActionStep player1_object, #$00
+keepSlidingLeft
    RTS

+slideRightMove
    LDA Object_x_hi,x
    CLC
    ADC #$02
    STA Object_x_hi,x

    LDA mySlide
    BNE +keepSlidingRight
    ChangeActionStep player1_object, #$00
+keepSlidingRight
    RTS

    ;========================
    ; not currently sliding
    ;========================
+notSlidingNow
    ; if lock is still on, do not start another slide
    LDA mySlideLock
    BEQ +checkStartSlide
    RTS

    ;========================
    ; grounded check to start slide
    ;========================
+checkStartSlide
    LDA Object_x_hi,x
    CLC
    ADC #$04
    STA temp
    JSR getPointColTable

    LDA Object_y_hi,x
    CLC
    ADC #$10
    STA temp1

    CheckCollisionPoint temp, temp1, #$01, tempA
    BNE +notGrounded

    ; start slide once
    LDA #$08
    STA mySlide

    LDA #$01
    STA mySlideLock

    ChangeActionStep player1_object, #$05
    RTS

+notGrounded
    RTS