; All of the window handling code in this program used pg 490 of the textbook as an example

INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

.data
wWidth DWORD 200
wHeight DWORD 120
maxXcoord DWORD 1520d
maxYcoord DWORD 760d
xCoord DWORD ?
yCoord DWORD ?

score DWORD 0
scoreTmp WORD ?

testText BYTE "test",0
testTitle BYTE "title",0

MainWin WNDCLASS <NULL,WinProc,NULL,NULL,NULL,NULL,NULL,COLOR_WINDOW,NULL,testTitle>

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

oldTime SYSTEMTIME<>
newTime SYSTEMTIME<>

.code

main PROC
	call Randomize
	mov ECX, 10 ; Mole Count

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
	INVOKE GetLocalTime, ADDR oldTime
	; Display window
	INVOKE GetModuleHandle, NULL
	mov hInstance, eax
	mov MainWin.hInstance, eax

	INVOKE LoadIcon, NULL, IDI_APPLICATION
	mov MainWin.hIcon, eax
	INVOKE LoadCursor, NULL, IDC_ARROW
	mov MainWin.hCursor, eax

	INVOKE RegisterClass, ADDR MainWin

	INVOKE CreateWindowEx, 0, ADDR testTitle, ADDR testText, WS_CAPTION,
	xCoord, yCoord, wWidth, wHeight, NULL, NULL, hInstance, NULL
	
	mov hMainWnd, eax
	INVOKE ShowWindow, hMainWnd, SW_SHOW
	INVOKE UpdateWindow, hMainWnd
	MessageLoop:
	INVOKE GetMessage, ADDR msg, NULL,NULL,NULL

	cmp eax, 0
	je skip

	INVOKE DispatchMessage, ADDR msg
	jmp MessageLoop

	skip:
	; On window close, get system time again
	INVOKE GetLocalTime, ADDR newTime
	;	Score is proportional to difference in system time
	mov AX, newTime.wSecond
	mov scoreTmp, AX
	mov EAX, 0
	mov AX, oldTime.wSecond
	sub scoreTmp, AX
	mov scoreTmp, AX
	imul AX, 1000d
	mov scoreTmp, AX
	mov AX, oldTime.wMilliseconds
	add scoreTmp, AX
	mov scoreTmp, AX
	mov AX, newTime.wMilliseconds
	sub scoreTmp, AX
	add score, EAX
	; Repeat loop if not out of time/moles
	dec ECX
	cmp ECX, 0
	jbe GameEnd
	jmp Game

	GameEnd:
	; Display score
	mov AX, 'S'
	CALL WriteChar
	mov AX, 'c'
	CALL WriteChar
	mov AX, 'o'
	CALL WriteChar
	mov AX, 'r'
	CALL WriteChar
	mov AX, 'e'
	CALL WriteChar
	mov AX, ':'
	CALL WriteChar
	mov AX, ' '
	CALL WriteChar
	mov EAX, score
	CALL WriteDec
	mov AX, 10
	CALL WriteChar
	CALL ReadChar ; Waits for input before closing


main ENDP

WinProc PROC hWnd:DWORD, localMsg:DWORD, wParam:DWORD, lParam:DWORD
	cmp localMsg, WM_LBUTTONDOWN
	jne WindowProc
	mov localMsg, WM_CLOSE
	INVOKE PostQuitMessage, 0
	WindowProc:
	INVOKE DefWindowProc, hWnd, localMsg, wParam, lParam
	ret
WinProc ENDP

END main