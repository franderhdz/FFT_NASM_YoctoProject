********************************************************************
# Proyecto 1: FFT_NASM_YoctoProject                   
********************************************************************
Name: 	**Transformada rápida de Fourier con Yocto Project**
Authors:
   Frander Hernández Matarrita <anhema15@gmail.com> 
   Bessy Urrea Mayorga  <bessy.lum7@gmail.com> 
   Cristhian González Vargas 	<cristhiandgv1996@gmail.com>   		 
   Bryan Salazar Hernández   <> 		 
Instituto Tecnológico de Costa Rica
II Semestre, 2019
********************************************************************
CONTENTS OF THIS FILE
=====================
   
 * Description
 * Requirements
 * How to use program

********************************************************************
DESCRIPTION
===========

This is a student project that implement FFT algorithm using Netwide Assembler (NASM) and some tools of Yocto Project, in order to create a Linux image with an aplication that calculate Fast Fourier Transform.

********************************************************************
REQUIREMENTS
============

********************************************************************
HOW TO USE THE PROGRAM
============

Pasos para crear un archivo **ejecutable** de emsamblador, con NASM.

Una vez creado el <nombre_archivo>.asm se debe crear un **arhivo objeto** o archivo de codigo maquina, es decir, el archivo que tiene las instrucciones que entiende y maneja el procesador directamente.

1. Para ensamblar, crear el **archivo objeto** (extension .o), se usa el comando: `nasm -f elf64 -o <nombre_archivo>.o` <nombre_archivo>.asm

2. Comprobar que el archivo <nombre_archivo>.o se ha creado en el directorio con ls

3. Para enlazar (linkear), crear el ejecutable a partir del archivo objeto, se utiliza el comando: ld -o <nombre_ejecutable> <nombre_archivo>.o

4. Para abrir el arhivo ejecutable del programa se utiliza el comando: ./<nombre_ejecutable>

**En resumen: son 3 comandos**

nasm -f elf64 -o <nombre_archivo>.o <nombre_archivo>.asm
ld -o <nombre_ejecutable> <nombre_archivo>.o
./<nombre_ejecutable>

********************************************************************
