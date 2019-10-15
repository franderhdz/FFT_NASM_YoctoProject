#include <stdio.h>      /* printf */
#include <math.h>       /* sin */
#include <inttypes.h>

//double sum(double[], int);

int main ()
{
  //variables declaration
  double PI = acos(-1);
  double W, W_imag, W_real;
  int N = 128;
  double p = (double) N;			//convert int N to double p
  double w_i[N/2];				//initialize imaginary array 
  double w_r[N/2];				//initialize real array
  
  //program
  for (int i = 0; i < N/2; i++) {		//for generate imaginary and real parts
  	W = i/p;
  	W_imag = sin (2*PI*W);
  	W_real = cos (2*PI*W);
        w_i[i] = W_imag;
	w_r[i] = W_real;
  	printf ("exp(2*pi*n/N) of %d/%d is = %.6f%+.6fi\n", i, N, W_real, W_imag );
	}
  
  for(int loop = 0; loop < N/2; loop++) {
	printf(" %.6f ", w_r[loop]);
	printf("%.6fi ", w_i[loop]);
        printf("\n");
        }
        return 0;

}
