;  [2015] by Joseph L'ingenieur
;  Created a blokgolf using assembly 
; (Electronic components used: LCD	2.6 inch, keypad and a  microcontroller  "PIC16F1870")

list  p=16F1870
#include "p16F1870.inc"

enable EQU 3           ;enable lijn keypad (enabled = 0)(port  C)
rw     EQU 5           ;r=l, w = 0 (write LCD)( port C)
e_disp EQU 5           
delayx EQU 20h        
delayy EQU 21h         
lus0   EQU 22h
lus1   EQU 23h

       org  0x00
	   bcf  STATUS,  RP1            
	   bsf  STATUS,  RP0     ;bank 1  for input/output settings port A,B,C
	   movlw 06h             
	   movwf ADCON1          
	   clrf  TRISA           
	   clrf  TRISB           
	   clrf  TRISC           
	   bcf   STATUS,  RP0     
	   bsf   PORTA, e_disp    ; e=1
	   bsf   PORTC, enable    ; keypad is disabled
	   bcf   PORTC, rw        ; Set lcd to write mode
	   clrf  PORTB            
	   
hoofd:
   bsf    PORTB, 7             ; pb7= 1
   movlw   d'5'                ;delay hoog = 5 ms
   movwf   delayx
	   
hoog:
   call delay1ms
   decfsz delayx, 1
   goto  hoog
   bcf  PORTB, 7               ;pb7=0
   movlw d'10'                 ;delay low = 10ms
   movwf delayy
	   
laag:
   call delay1ms
   decfsz delayy,1
   goto laag
   goto hoofd


delay1ms:
  movlw  d'8'
  movwf  lus1

init0:
  movlw   d'2'
  movwf  lus0

loop:
  decfsz lus0, 1
  goto loop
  decfsz lus1, 1
  goto init0
  return
  end
  