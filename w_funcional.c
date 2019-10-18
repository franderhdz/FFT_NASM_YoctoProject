//gcc w_funcional.c -o w_funcional -lm && ./w_funcional

#include <stdio.h>      /* printf */
#include <math.h>       /* sin */
#include <inttypes.h>
#define LEN 256

//double sum(double[], int);

int main ()
{
  //variables declaration
  double PI = acos(-1);
  double W, W_imag, W_real;
  int N = 32;
  double p = (double) N;			//convert int N to double p
  double w_i[N/2];				//initialize imaginary array 
  double w_r[N/2];				//initialize real array
 
  FILE * fp;
  /* open the file for writing*/
  fp = fopen ("/home/franderhdz/Desktop/data.txt","w+");
 
  //program
  for (int i = 0; i < N/2; i++) {		//for generate imaginary and real parts
  	W = i/p;
  	W_imag = sin (-2*PI*W);
  	W_real = cos (-2*PI*W);
        w_i[i] = W_imag;
	w_r[i] = W_real;
  	printf ("exp(2*pi*n/N) of %d/%d is = %.6f%+.6fi\n", i, N, W_real, W_imag );
	
        //fprintf (fp, "This is line %f\n", W_imag);
        //fprintf (fp, "%f	%f\n", W_real, W_imag);
	fprintf (fp, "%.4f\t", W_real);          //print horizontal lines of real parts
  }
  fprintf (fp, "\n");
  fprintf (fp, "\n");
  for (int i = 0; i < N/2; i++) {		//print horizontal lines of imaginary parts
	fprintf (fp, "%.4f\t", w_i[i]);
        
  }	
  /* close the file*/  
  fclose (fp);
  return 0;
}
