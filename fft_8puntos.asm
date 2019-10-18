%include "macros.asm"

section .data
	enR 	dd 5.0, -5.0, 2.0, -2.0, -2.1213, 2.1213, 4.9497, -4.9497
	enI 	dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	N 		equ 8
	nE      equ 3
	zero 	equ 0
	uno 	equ 1
	dos 	equ 2
	WR 		dd 1.0, 0.707107, 0.0, -0.707107
	WI 		dd 0.0, -0.707107, -1.0, -0.707107
	
section .bss
	indi_marip resb 4

section .text

global _start
;global etapa1

_start:
	xor r12, r12	; hacer 0 el contador de etapas
	; push r12		; contador de etapas r12  ---------------------------                   	%  E  %
	mov r15, nE		; contador para seleccion de W's en retroceso
	jmp fft_loop

fft_loop:
	cmp r12, nE		; comparar si nE = E
	je final		; ************************** HACERLO ******************************
    inc r12         ; significa que no ha llegado al final de las etapas
    dec r15			; contador en retroceso
    ; RELACIONADO CON LOS BLOQUES 
    pow r12       ; se eleva 2^etapa
	mov eax, N
	cdq
	idiv rdi   		; calcula # de bloques por etapa - nB, se guarda en RAX el cociente
	mov rbp, rax	; rbp puede ser usado como de PG -----------------------					%   nB  %
	;push rbp		
	; RELACIONADO CON LAS MARIPOSAS 
    mov rsi, r12
	dec rsi
    pow rsi       	; se eleva 2^(etapa-1)
    mov r13, rdi  	; calcula # de mariposas por bloque, guarda el resultado en r13 --------	%  nM  %
    ;push r13
    xor rbx, rbx	; inicializa contador de bloques en rbx ------------------ 					%  B  %
    inc rbx			; empieza en 1
    xor r14, r14 	; inicializa contador de mariposas en r14 ---------------- 					%  M  %
    pow r15			
    mov r9, rdi		; define offset que es 2^(cont inverso)
    push r9
    xor r8, r8 	; contador para ubicacion de indice a tomar para los W
    sub rsp, 16
    jmp definir_W


definir_W:
	mov rcx, 1
	imul rcx, r14
	imul rcx, rbx 	; se multiplica M*B*2^(cont inverso) que es el offset
	imul rcx, r9
	mov [indi_marip+r8], rcx ; guarda en indi_marip el valor del indice a tomar de los W
	inc r8
	jmp loop_etapa

loop_etapa:
	;lea rax, enR 	; se guarda en rax la direccion del elemento 1 en las entradas
	mov rdx, uno 	; se guarda un 1 en el registro para poder hacer las comparaciones necesarias
	xor rdi, rdi	
	cmp r13, r14 	; compara si M llego a ser nM
	cmove rdi, rdx
	xor rsi, rsi
	cmp rbp, rbx 	; compara si B llego a ser nB
	cmove rsi, rdx
	test rdi, rsi	; comparar si se cumple que se termina la etapa
	jnz  fft_loop
	cmp rdi, uno 	; si M llego a ser nM
	je cambio_bloque
	inc r14 		; significa que aun quedan mariposas por calcular en el bloque
	jmp hacer_mariposa


cambio_bloque:
	mov rdi, uno
	imul rdi, rbp 	; el valor 2^etapa se multiplica con B
	imul rdi, rbx 	; rdi tiene el offset para cada bloque
	inc rbx 		; se cambia de bloque
	xor r14, r14 	; se inicializa M
	jmp hacer_mariposa


hacer_mariposa:
	mov rdx, zero
	cmp rbx, uno 	; si se esta en el bloque 1, aun no se necesita el offset de cada bloque
	cmove rdi, rdx
	mov r10, enR
	mov r11, enI
	add r10, rdi
	add r11, rdi	
	mov rdx, enR 	; para tener el dato de desfase de mariposa de la parte real
	add rdx, r13
	add rdx, rdi 	; suma el offset de bloque
	mov rcx, enI 	; para tener el dato de desfase de mariposa de la parte imaginaria
	add rcx, r13
	add rcx, rdi 	; suma el offset de bloque
	mov rax, r14 	; mueve M a rax para definir cual dato tomar de indi_marip
	dec rax

	mov rax, [indi_marip+rax] ; guarda el dato en rax
	mariposa [r10], [r11], [rdx], [rcx], [WR+rax], [WI+rax], r10, r11, rdx, rcx; nM es igual al offset entonces se usa para tal fin
	cmp rbx, uno 	; si aun se esta en el bloque uno 
etapa1:
	je definir_W
	jmp loop_etapa


final:
	; pops
	exit
