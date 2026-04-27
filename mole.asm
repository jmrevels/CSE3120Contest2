INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

.data
maxXcoord DWORD 1920d
maxYcoord DWORD 1080d
xCoord DWORD ?
yCoord DWORD ?

score WORD 0

testText BYTE "test",0
testTitle BYTE "title",0

msg	      MSGStruct <>
winRect   RECT <>
hMainWnd  DWORD ?
hInstance DWORD ?

SYSTEMTIME STRUCT
	wYear			WORD ?
	wMonth			WORD ?
	wDayOfWeek		WORD ?
	wDay			WORD ?
	wHour			WORD ?
	wMinute			WORD ?
	wSecond			WORD ?
	wMilliseconds	WORD ?
SYSTEMTIME ENDS

.code

main PROC
	call Randomize
	INVOKE MessageBox, hMainWnd, ADDR testText,
		ADDR testTitle, MB_OK

	; Start of gameplay loop
	;	(Loop can be based on either a systemtime time limit or # of moles)
	Game:
	; Get random coordinates for window
	mov eax, maxXcoord
	call RandomRange
	mov xCoord, eax

	mov eax, maxYcoord
	call RandomRange
	mov yCoord, eax

	; Get system time at start of window
	; Display window
	; On window close, get system time again
	;	Score is proportional to difference in system time
	; Add score to total score
	; Repeat loop if not out of time/moles
	; Display score
	; Display high score/save score to file if higher


main ENDP

END main