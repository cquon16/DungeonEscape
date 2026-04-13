;;; reset slide lock when B is released

    LDA #$00
    STA mySlideLock
    RTS