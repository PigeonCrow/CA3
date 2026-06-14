;   Labor 1 - Problem 2.4
;   Convert a zero-terminated ASCIIZ string to lower characters
;   Subroutine toLower
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
        XDEF toLower

; Defines

; Defines

; RAM: Variable data section
.data: SECTION

; ROM: Constant data
.const: SECTION

; ROM: Code section
.init: SECTION

toLower:

;       ... ??? ...                     ; Add your code here

   

      TFR D,X                           ; Pointer auf String -> X
next: LDAB 0,X                          ; Zeichen -> B
      TSTB                              ; String Ende
      
      BEQ ende
      
      CMPB #'A'                          ; Prüfen ob Großbuchstabe
      BLO ink
      CMPB #'Z'
      BHI ink
      
      ADDB #32                          ; Großbuchstabe umwandeln
      STAB 0,X                          ; Ergebnis abspeichern

ink:  INX                               ; Pointer auf nächstes Zeichen
      BRA next

ende: 
      RTS                               ; Return