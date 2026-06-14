; export symbols
        XDEF hexToASCII
        
; Defines

; Defines

; RAM: Variable data section
.data: SECTION

; ROM: Constant data 
.const: SECTION                       
H2A:  DC.B  "0123456789ABCDEF"                     

; ROM: Code section
.init: SECTION  

hexToASCII:

                PSHD                                      ; Sichere Register
                PSHX
                PSHY
                
                LDY #$04                                  ; Y mit 4 Vorbelegen für 4 Ziffern
loop:           CPY #$0                                   ; Prüft ob Y Reg 0 ist
                BLE finish                                ; Wenn ja sind wir mit abarbeitung fertig und können zurück

                DEY                                       ; Y um 1 Reduzieren gibt die Aktuelle Position des Arrays wieder
                PSHD                                      ; Wir sichern uns das D Reg damit wir mit A & B Arbeiten können
                PSHX                                      ; Adresse in X auf Stack werfen
                
                
                                 
                ANDB  #$0F                                ; Mit 00001111 Verunden, gibt uns den Index des Arrays 

                TFR   B,X
                                                          ; Schreibe Index für Tabelle in X Reg
                LDAB  H2A,X 
                                                          ; Schreibe ASCII Wert nach B Reg
                PULX
                                                          ; Lade Adresse wieder in X Reg
                                                          
                TFR   Y,A                                                          
                STAB  A,X                                 ; Schreibt ASCII Wert an Aktuelle Array Position
                                                          
                PULD                                      ; Lade D Reg wieder in ausgangszustand
                LSRD                                      ; D um 4 Stellen nach links verschieben um nächste Ziffer zu bekommen
                LSRD
                LSRD
                LSRD
                
                                                          
                BRA loop                                 ; Zum anfang der Schleife springen                                          
                                                          
finish:         LDAA 0
                STAA 4,X                                          
                                                          
                PULY                                      ; Stelle Register wieder her
                PULX
                PULD

                RTS                                       ; Rücksprung ins hauptmenü   