data segment
	va1 db 'YES$'
	va2 db 'NO$'
data ends
 
code segment
	assume cs:code,
	ds:data
start:
		mov ax,data
		mov ds,ax

		call decibin  
		call crlf
			
		call judge
		call crlf
		mov ah,4ch
		int 21h
	
	decibin proc near
		mov bx,0
	newchar:
		mov ah,1
		int 21h
		sub al,30h
		jl exit
		cmp al,9
		jg exit
		cbw
		xchg ax,bx
		mov cx,10
		mul cx
		xchg ax,bx
		add bx,ax
		jmp newchar
	exit:
		ret
	decibin endp
	judge proc near
		mov cx,bx
		sub cx,2 
		cmp bx,2
		jle print1
			mov dl,1
	jud:
	
		mov ax,bx
		inc dl
		div dl
		cmp ah,0
		jz print2
		loop jud
		jmp print1
	print1:
		mov ah,09h
		lea dx,va1
		int 21h
		ret
	print2:
		mov ah,09h
		lea dx,va2
		int 21h 	
	ret
	judge endp
	
	crlf proc near
		mov dl,0dh
		mov ah,2h
		int 21h
		mov dl,0ah
		mov ah,02h
		int 21h
	
	ret
	crlf endp
	
	code ends
	end start
 
 
 
 
 