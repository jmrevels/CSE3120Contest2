INCLUDE Irvine32.inc

.data
score WORD 0

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

main ENDP

END main