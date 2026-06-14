;   Labor 1 - Vorbereitungsaufgabe 2.5

;convert a 16bit hexadecimal variable val into a null-terminated ASCII-
;string.

;   Main program


; export symbols
        XDEF Entry, main

; import symbols
        XREF __SEG_END_SSTACK               ; End of stack
        XREF hexToASCII
        
; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; Defines

; RAM: Variable data section
.data:  SECTION

string:  DS.W    5                        ; Hier soll der String gespeichert werden

; ROM: Constant data
.const: SECTION                       


; ROM: Code section
.init:  SECTION 

main:                                   ; Begin of the program
Entry:                  
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger
        
;       
        LDX #string                     ; Adresse nach X speichern
        LDY #$0000                      ; Belege Y mit  0, D lässt sich nicht Inkrementieren
 loop:  TFR Y,D                         ; Kopiere Y nach D
              
                      
        JSR hexToASCII                  ; Rufe Unterfunktion auf
        INY                             ; Erhöhe Y um 1,

        BRA loop                        ; Läuft bis ans Ende aller Tage 
        
        
        
        
