;   Labor 1 - Vorbereitungsaufgabe 2.4
;   Umwandlung eines Null-Terminierten Strings in Kleinbuchstaben
;   Hauptprogramm
;
;   Computerarchitektur 3
;   (C) 2014-2015 J. Friedrich, W. Zimmermann
;   Hochschule Esslingen
;
;   Author:   W.Zimmermann,  July 17, 2013    
;            (based on code provided by J. Friedrich)
;   Modified: W.Zimmermann, July 21, 2014
;

; export symbols
        XDEF Entry, main

; import symbols
        XREF __SEG_END_SSTACK               ; End of stack
        XREF decToASCII
        
; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; Defines
SEVEN_SEGS_OFF  EQU 1                   ; Uncomment this to turn seven segment display off   
                 ; Change this number to change counting speed

; RAM: Variable data section
.data: SECTION
Vtext:  DS.B    80                      ; Hier soll der String gespeichert werde

; ROM: Constant data
.const:SECTION                        

; ROM: Code section
.init: SECTION  

main:                                   ; Begin of the program
Entry:                  
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger
        
      
        LDX #Vtext                      ; Adresse nach X speichern
        
        LDD #$7FFF                      ; Belege D mit 32767 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$8000                      ; Belege D mit -32768 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$2329                      ; Belege D mit 9001 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$00FF                      ; Belege D mit 255 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$0100                      ; Belege D mit 256 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$FF00                      ; Belege D mit -256 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$0064                      ; Belege D mit 100 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$FF9D                      ; Belege D mit -99 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf
        
        LDD #$0000                      ; Belege D mit 0 Vor 
        JSR decToASCII                  ; Ruf unterprogramm auf

 loop:  BRA loop                        ; Läuft bis ans Ende aller Tage 

