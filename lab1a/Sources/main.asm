
;   Labor 1 - Problem 2.2
;   Incrementing a value once per second and binary output to LEDs
;
;   Computerarchitektur 3
;   (C) 2015-2016 J. Friedrich, W. Zimmermann
;   Hochschule Esslingen
;
;   Author:   W.Zimmermann, July 17, 2013
;            (based on code provided by J. Friedrich)
;   Modified: W.Zimmermann, Jan  10, 2016
;

; export symbols
        XDEF Entry, main

; import symbols
        XREF __SEG_END_SSTACK           ; End of stack

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'
        
        IMAX: EQU 2000           ;fuer 0.5sec mit CPUclk benoetigt man 12000000 cycl.  
        
        SEVEN_SEGS_OFF  EQU 1                   ; Uncomment this to turn seven segment display off
        
        

; Defines
SPEED:  EQU     $FFFF                   ; Change this number to change counting speed

; RAM: Variable data section
.data: SECTION

; ROM: Constant data
.const:SECTION

; ROM: Code section
.init: SECTION

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger

;       ... ??? ...                     ; Add your code here


        BSET DDRJ, #2                   ; Bit Set:   Port J.1 as output
        BCLR PTJ,  #2                   ; Bit Clear: J.1=0 --> Activate LEDs

  ifdef SEVEN_SEGS_OFF        
        MOVB #$0F, DDRP                 ; Port P.3..0 as outputs (seven segment display control)
        MOVB #$0F, PTP                  ; Turn off seven segment display
  endif

        MOVB #$FF, DDRB                 ; $FF -> DDRB:  Port B.7...0 as outputs (LEDs)
        MOVB #$55, PORTB                ; $55 -> PORTB: Turn on every other LED






;________________2.2______
        CLRA
        LDAA   #$3F          
        
   
   
   L1:  CMPA   #0
              ;....Ausgabe.....
             
             
             
        BEQ    L2
                                             
        DECA
        BSR    waitO   ;....Warten......
        Bra L1    
       
   
        
   L2:  CMPA  #$3F
              ;....Ausgabe.....
        BEQ  L1
             
        INCA
        BSR     waitO;....Warten......
        Bra L2       
;____________________________ 


;---------------Delay aus BlinkLEDs-------------------             
        LDX  #IMAX                      ; Delay loop to control toggle Frequency 
waitO:  LDY  #IMAX                      ; (Uses two nested counter loops with registers X and Y)
waitI:  DBNE Y, waitI                   ; --- Decrement Y and branch to waitI if not equal to 0
        DBNE X, waitO                   ; --- Decrement X and branch to waitO if not equal to 0

        RTS 
    
        
    
    
        