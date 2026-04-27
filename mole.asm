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

	# Start of gameplay loop
	#	(Loop can be based on either a systemtime time limit or # of moles)
	# Get random coordinates for window
	# Get system time at start of window
	# Display window
	# On window close, get system time again
	#	Score is proportional to difference in system time
	# Add score to total score
	# Repeat loop if not out of time/moles
	# Display score
	# Display high score/save score to file if higher


main ENDP

END main