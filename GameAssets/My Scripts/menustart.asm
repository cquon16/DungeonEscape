LDY optionselected
LDA menuscreens,y
STA tempx

; reset lives for a new game
LDA #$03
STA myLives

; set respawn point to first real gameplay screen
LDA #$00
STA continueMap

LDA #$00
STA continueScreen

WarpToScreen #$00, tempx, #$01
RTS