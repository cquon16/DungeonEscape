; IF YOU HAVE A SELECT SOUND, UNCOMMENT THE NEXT LINE:
;PlaySound #sfx_select

LDA optionselected ; get the current option setting
CMP #$01 ; SET THIS NUMBER TO 1 LESS THAN THE NUMBER OF MENU OPTIONS YOU HAVE ON YOUR SCREEN
BNE +
    LDA #$00
    STA optionselected ; if we are at the last option, go back to 0
    RTS
+
INC optionselected ; if we arent at the last option, increase the variable by 1
RTS