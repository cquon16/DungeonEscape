LDY optionselected
LDA menuscreens,y
STA tempx
WarpToScreen #$00, tempx, #$01
;change the first arg to #$01 if you want to warp to the Underworld)
RTS