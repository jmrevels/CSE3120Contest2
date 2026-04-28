INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

.data
wWidth DWORD 100
wHeight DWORD 75
maxXcoord DWORD 1920d
maxYcoord DWORD 1080d
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

	INVOKE CreateWindowEx, 0, ADDR testTitle, ADDR testText, MAIN_WINDOW_STYLE,
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
	; Add score to total score
	; Repeat loop if not out of time/moles
	; Display score
	; Display high score/save score to file if higher


main ENDP

WinProc PROC hWnd:DWORD, localMsg:DWORD, wParam:DWORD, lParam:DWORD
	cmp localMsg, WM_LBUTTONDOWN
	jne WindowProc
	mov localMsg, WM_CLOSE
	WindowProc:
	INVOKE DefWindowProc, hWnd, localMsg, wParam, lParam
	ret
WinProc ENDP

END main