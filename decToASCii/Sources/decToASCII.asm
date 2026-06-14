; export symbols
        XDEF decToASCII
        
; Defines

; Defines

; RAM: Variable data section
.data: SECTION

; ROM: Constant data 
.const: SECTION                       
D2A:            DC.B  "0123456789- ", 0                     ; Umrechnungstabelle                     

; ROM: Code section
.init: SECTION  


decToASCII:     PSHD                                      ; Sichere Register
                PSHX
                PSHY


                PSHA                                      ; A Reg sichern, wird für Index verwendet
                LDAA  #$6
initloop:       MOVB  #32,A,X                             ; String mit leerzeichen vorbelegen, wichtig falls 2 mal hintereinander aufgerufen
                TSTA                                      ; Ist Index 0?
                BEQ   finishinit                          ; Wenn ja sind wir hier fertig
                DECA                                      ; Index um 1 verringern
                BRA   initloop                            ; Schleife durchgehen bis alles Initialisiert ist
                
                
                
finishinit:     LDY   #$0                                 ; Y = 0 keine Neg zahl                
                PULA                                      ; A Reg wieder laden 
                PSHA                                      ; A Gleich wieder sicher, da wir auf Minus Prüfen wollen
                ANDA  #$80                                ; Mit 80H verunden
                CMPA  #$00                                ; Wenn A jetzt 0 ist ist es ein Positiver werd
                PULA                                      ; A wieder laden, Minus ist bereits abgehandelt
                BEQ   nominus                               ; Zahl ist positiv, also wird kein - benötigt.
                
                COMA                                      ; Bits in Reg A Invertieren
                COMB                                      ; Bits in Reg B Invertieren
                ADDD  #$1                                 ; 1 zu D Reg addieren für 2er Komplement
                LDY   #1                                  ; Y = 1 Neg zahl
                
                
                
                
nominus:        PSHY
                MOVB #32,7,+X                             ; Nur Nötig um Pointer Adresse zu inkrementiere, sicher nicht sauber aber besser als 7x INCX            
convertloop:    TFR X, Y                                  ; Adresse in X nach Y sichern, soll ja nicht verloren gehen                                                                                                           
                DEY                                       ; Adresspointer in Y um 1 reduzieren
                LDX   #$0A;                               ; X mit 10 Vorbelegen für Division
                IDIV                                      ; D / X, Ergebnis in X, Rest in D
                EXG D,Y                                   ; D und Y Register vertausch, Y Enthält jetzt Array Position, D enthält adresse
                DEY                                       ; Adresspointer in Y um 1 reduzieren
                LDY D2A, Y                                ; Asciwert in Y reg laden  
                EXG D,Y                                   ; Register Tauschen                              
                STAB  Y                                   ; Zeichen speichern
                EXG D,X                                   ; Zahlenwert in X wieder in D Reg schieben
                TFR Y,X                                   ; Adresse in Y wieder nach X kopieren                 
                CPD #$0                                   ; Schauen ob der Wert / 10 bereits 0 ist
                BEQ finishconvert                         ; convert beenden
                
                BRA   convertloop                         ; Wieder an schleifenanfang springen
finishconvert:  
                PULY
                CPY #1
                BNE finish
                DEX
                MOVB  #45,X                               ; Füge Minus vor der Zahl ein  
                                               
finish:         PULY                                      ; Stelle Register wieder her
                PULX
                PULD                                
                MOVB  #0,7,X                               ; Abschließende 0 Für String Terminierung einfügen           
                

                RTS                                       ; Rücksprung ins hauptmenü   