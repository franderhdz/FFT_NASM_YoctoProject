%macro exit 0
	mov rax, 60
	mov rdi, zero
	syscall
%endmacro 

%macro pow 1
	mov r10, uno 
 	mov rcx, 0
 	mov rax, %1
	mov rdi, uno
%%LOOP:
	imul rdi, dos
	cmp %1, 0
	cmove rdi, r10
	inc rcx
	cmp rcx, rax
	jl %%LOOP
%endmacro

%macro mariposa 10

	;calcula mariposa superior
	movss xmm0, %1		;recibe [X1re]
	movss xmm1, %2      ;recibe [X1im]
	movss xmm2, %3		;recibe [X2re]
	movss xmm3, %4		;recibe [X2im]
	movss xmm4, %5      ;recibe [Wre]
	movss xmm5, %6      ;recibe [Wim]
	movss xmm6, %5      ;se guarda [Wre] de nuevo para no perderlo luego 
	movss xmm7, %6      ;se guarda [Wim] de nuevo para no perderlo luego
	
	;operaciones
	mulss xmm4, xmm2    ;[Wre]*[X2re]
	addss xmm0, xmm4    ;[X1re]+[Wre]*[X2re]
	mulss xmm6, xmm3											;[Wre]*[X2im]
	addss xmm1, xmm6											;[X1im]+[Wre]*[X2im]
	mulss xmm5, xmm3	;[Wim]*[X2im]
	mulss xmm7, xmm2											;[Wim]*[X2re]
	subss xmm0, xmm5    ;[X1re]+[Wre]*[X2re]-[Wim]*[X2im]
	addss xmm1, xmm7 											;[X1im]+[Wre]*[X2Im]+[Wim]*[X2re]
	movss [%7], xmm0    ;contiene el resultado real
	movss [%8], xmm1    ;contiene el resultado imaginario

	;calcula mariposa inferior
	movss xmm0, %1		;recibe [X1re]
	movss xmm1, %2      ;recibe [X1im]
	movss xmm2, %3		;recibe [X2re]
	movss xmm3, %4		;recibe [X2im]
	movss xmm4, %5      ;recibe [Wre]
	movss xmm5, %6      ;recibe [Wim]
	movss xmm6, %5      ;se guarda [Wre] de nuevo para no perderlo luego 
	movss xmm7, %6      ;se guarda [Wim] de nuevo para no perderlo luego
	
	;operaciones
	mulss xmm4, xmm2    ;[Wre]*[X2re]
	subss xmm0, xmm4    ;[X1re]-[Wre]*[X2re]
	mulss xmm6, xmm3											;[Wre]*[X2im]
	subss xmm1, xmm6											;[X1im]-[Wre]*[X2im]
	mulss xmm5, xmm3	;[Wim]*[X2im]
	mulss xmm7, xmm2											;[Wim]*[X2re]
	addss xmm0, xmm5    ;[X1re]-[Wre]*[X2re]+[Wim]*[X2im]
	subss xmm1, xmm7 											;[X1im]-[Wre]*[X2Im]-[Wim]*[X2re]
	movss [%9], xmm0    ;contiene el resultado real
	movss [%10], xmm1    ;contiene el resultado imaginario

%endmacro