INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

.data
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
	INVOKE MessageBox, hMainWnd, ADDR testText,
		ADDR testTitle, MB_OK

main ENDP

END main