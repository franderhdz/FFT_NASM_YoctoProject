global main

extern printf

section .data
    valRe: dq -22.45, 123.456, 0.9867
    valIm: dq 100.00, -345.333, 11.564
    msg: db "%f				%fi",10, 0
    N:	 equ 3

section .text
    main:


%macro salida 3				; entradas N:puntos, salida real, salida imag
    mov rbp, 0
%%LOOP:
    sub rsp, 8				;alinea la pila
    mov rdi,msg
    movsd xmm0,[%2+8*rbp]	;recorre el vector de reales
    movsd xmm1,[%3+8*rbp]	;recorre el vector de imag
    mov eax,1
    call printf

    mov rax, 0
    add rsp, 8				;alinea la pila

    inc rbp
    cmp rbp, %1				;compara si ya se llegó al final del vector, si es así se detiene
    jne %%LOOP
%endmacro
	
	salida N, valRe, valIm
    ret