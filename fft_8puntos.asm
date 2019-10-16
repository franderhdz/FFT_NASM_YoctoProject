section .data
	enR: dd 5, -5, 2, -2, -2.1213, 2.1213, 4.9497, -4.9497
	enI: dd 0, 0, 0, 0, 0, 0, 0, 0
	N: db 8
	uno: db 1
	dos: db 2
	WR dd 1, 0.707107, 0, -0.707107
	WI dd 0, -0.707107, -1, -0.707107

section .text

global main
extern printf, memset, memcpy, srand, rand, time, cexp, __muldc3, cabs, log2, pow

main:
	movsd xmm0, [N] 	
	call log2
	cvtsd2si r12, xmm0	; numero de etapas xmm5	---------------------------- 					%  nE  %
	push r12
	xor r13, r13	; hacer 0 el contador de etapas
	push r13		; contador de etapas r13  ---------------------------                   	%  E  %
	jmp fft_loop

fft_loop:
	cmp r12, r13	; comparar si nE = E
	je final		; ************************** HACERLO ******************************
    inc r13         ; significa que no ha llegado al final de las etapas
    ; RELACIONADO CON LOS BLOQUES 
    sub rsp, 8
    movsd xmm0, [dos]
    cvtsi2sd xmm1, r13 
    call pow        ; se eleva 2^etapa
    add rsp, 8
    cvtsd2si rdi, xmm0   ; guarda el resultado en rbx
	mov eax, [N]
	cdq
	idiv rdi   		; calcula # de bloques por etapa - nB, se guarda en RAX el cociente
	mov rbp, rax	; rbp puede ser usado como de PG -----------------------					%   nB  %
	push rbp
	; RELACIONADO CON LAS MARIPOSAS 
	;sub rsp, 16     ----------------------------- no estoy segura de que vaya
    mov r14, r13
	dec r14
	movsd xmm0, [dos]
	cvtsi2sd xmm1,r14	; r14 es r13-1
    call pow        ; se eleva 2^(etapa-1)
    cvtsd2si r14, xmm0   ; calcula # de mariposas por bloque, guarda el resultado en r14 --------	%  nM  %
    push r14
    xor rbx, rbx	; inicializa contador de bloques en rbx ------------------ 					%  B  %
    xor r15, r15 	; inicializa contador de mariposas en r15 ---------------- 					%  M  %
    push rbx
    push r15
    jmp loop_etapa


loop_etapa:
	xor rdi, rdi	
	cmp r14, r15 	; compara si M llego a ser nM
	cmove rdi, [uno]
	xor rsi, rsi
	cmp rbp, rbx 	; compara si B llego a ser nB
	cmove rsi, [uno]
	test rdi, rsi	; comparar si se cumple que se termina la etapa
	jnz  fft_loop
	cmp rdi, [uno]
	jmp cambio_bloque ; PONER CODIGO PARA QUE SALTE AL OTRO BLOQUE Y DE AHI LLAMAR A MARIPOSA TAMBIEN
	inc r15 		; significa que aun quedan mariposas por calcular en el bloque
	jmp mariposa

cambio_bloque:
	xor r15, r15
	jmp mariposa

mariposa:
	
	

;	jmp loop_etapa

final:
	; pop
ret
