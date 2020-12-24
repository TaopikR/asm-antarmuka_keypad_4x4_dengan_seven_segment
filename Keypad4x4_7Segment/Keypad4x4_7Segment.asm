/*
 * AVRAssembler1.asm
 *
 *  Created: 23/12/2020 12:31:42
 *   Author: Windows7
 *	TAOPIK ROMDONI - 1187070085
 */ 
	
.include "m32def.inc"	
.def temp =r22	
.def dly =r23	
.def dly1 =r24	
.def Key =r25	
.equ kol1 =0b01111111	;inisialisasi kolom 1
.equ kol2 =0b10111111	;inisialisasi kolom 2
.equ kol3 =0b11011111	;inisialisasi kolom 3
.equ kol4 =0b11101111	;inisialisasi kolom 4
.org 0x0000	
rjmp main	
main: 	
ldi r16,low(RAMEND)	
out SPL,r16	
ldi r16,high(RAMEND)	
out SPH,r16	
ldi r16,0xff	
out ddra,r16	;PortA = output
ldi temp,0x00	;PortA sebagai power ke 7-segmen
out PORTA,temp	
ldi r16,0xff	
out ddrb,r16	;PortB = output
ldi r16,0xc0	;tampilkan angka nol pertama kali
out portb,r16	
ldi r16,0xf0 	;PC[7:4] = output   PC[3:0] = input
out ddrc,r16	
loopx: rcall PUSH_BUT	
rjmp loopx	
; subrutin shift keypad	
PUSH_BUT:	
ldi temp,kol1 	;enable kolom 1
out PORTC,temp	
rcall delay	
sbic PINC,PC3	;tombol "1" tertekan?
rjmp key4		;jika tidak, cek tombol berikutnya
ldi key,0xf9	;jika ya...
out PORTB,key	;maka kirim kode angka ‘1’
ret 				
key4: 	
sbic PINC,PC2 	;tombol "4" tertekan?
rjmp key7 		;jika tidak, cek tombol berikutnya
ldi key,0x99	;jika ya...
out PORTB,key	;maka kirim kode angka ‘4’
ret 	
key7:	
sbic PINC,PC1	;tombol "7" tertekan?
rjmp keyF		;jika tidak, cek tombol berikutnya
ldi key,0xf8	;jika ya...
out PORTB,key	;maka kirim kode angka ‘7’
ret				
keyF:	
sbic PINC,PC0	;tombol "*" tertekan?
rjmp key2		;jika tidak, cek tombol berikutnya
ldi key,0x8e	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘F’
ret				
key2:	
ldi temp,kol2	;Disable kolom pertama ...
out PORTC,temp	;dan enable kolom kedua
rcall delay	
sbic PINC,PC3	;tombol "2" tertekan?
rjmp key5		;jika tidak, cek tombol berikutnya
ldi key,0xa4	;jika ya...
out PORTB,key	;maka kirim kode angka ‘2’
ret	
key5:	
sbic PINC,PC2	;tombol "5" tertekan?
rjmp key8		;jika tidak, cek tombol berikutnya
ldi key,0x92	;jika ya...
out PORTB,key	;maka kirim kode angka ‘5’
ret	
key8:	
sbic PINC,PC1	;tombol "8" tertekan?
rjmp key0		;jika tidak, cek tombol berikutnya
ldi key,0x80	;jika ya...
out PORTB,key	;maka kirim kode angka ‘8’
ret	
key0:	
sbic PINC,PC0	;tombol "0" tertekan?
rjmp key3		;jika tidak, cek tombol berikutnya
ldi key,0xc0	;jika ya...
out PORTB,key	;maka kirim kode angka ‘0’
ret	
key3:	
ldi temp,kol3	;Disable kolom kedua ...
out PORTC,temp	;dan enable kolom ketiga
rcall delay	
sbic PINC,PC3	;tombol "3" tertekan?
rjmp key6		;jika tidak, cek tombol berikutnya
ldi key,0xb0	;jika ya...
out PORTB,key	;maka kirim kode angka ‘3’
ret	
key6:	
sbic PINC,PC2	;tombol "6" tertekan?
rjmp key9		;jika tidak, cek tombol berikutnya
ldi key,0x82	;jika ya...
out PORTB,key	;maka kirim kode angka ‘6’
ret	
key9:	
sbic PINC,PC1	;tombol "9" tertekan?
rjmp keyE		;jika tidak, cek tombol berikutnya
ldi key,0x90	;jika ya...
out PORTB,key	;maka kirim kode angka ‘9’
ret	
keyE:	
sbic PINC,PC0	;tombol "#" tertekan?
rjmp keyA		;jika tidak, cek tombol berikutnya
ldi key,0x86	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘E’
ret				
keyA:	
ldi temp,kol4 	;Disable kolom ketiga ...
out PORTC,temp	;dan enable kolom keempat
rcall delay	
sbic PINC,PC3	;tombol "A" tertekan?
rjmp keyB		;jika tidak, cek tombol berikutnya
ldi key,0x88	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘A’
ret	
keyB:	
sbic PINC,PC2	;tombol "B" tertekan?
rjmp keyC		;jika tidak, cek tombol berikutnya
ldi key,0x83 	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘B’
ret 	
keyC:	
sbic PINC,PC1 	;tombol "C" tertekan?
rjmp keyD		;jika tidak, cek tombol berikutnya
ldi key,0xc6 	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘C’
ret 	
keyD:	
sbic PINC,PC0	; tombol "D" tertekan?
rjmp PUSH_BUT	;jika tidak, cek tombol berikutnya
ldi key,0xa1 	;jika ya...
out PORTB,key	;maka kirim kode huruf ‘D’
ret	
; Subrutin Delay 	
delay: ldi dly,0x10	
dl1: ldi dly1,0xff	
dl2: dec dly1	
brne dl2	
dec dly	
brne dl1	
ret	
