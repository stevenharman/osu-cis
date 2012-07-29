#include <iostream.h>   // provides cout
#include <iomanip.h>		// provides output formatting
#include <math.h>			// provides sqrt, fabs

// function prototypes
void print_A_Matrix(float* A[], int n);
void print_B_or_X_Matrix(float array[], int n);
void print_P_Matrix(int array[], int n);
void gauss(float* A[], float x[], float B[], int n, int P[], bool &success);

void main(void)
{
  bool is_Solved = true;   // this variable tells us if gauss() was able to
  // solve the system Ax = B for a square matrix A.
  // please note: the intitial value must be "true."

#if 0
  // test system
  float A1_1[3] = {0.0, 4.0, 3.0};
  float A1_2[3] = {4.0, 2.0, 6.0};
  float A1_3[3] = {2.0, 1.0, -3.0};
  float B1[3] = {10.0, 34.0, 5.0};
#endif

  // dimensions for the systems of equations
  const int n1 = 3;
  const int n2 = 4;
  const int n3 = 3;
  const int n4 = 3;

  /////////////////////////////////////////////////////////////////////////////
  //
  // Define System I: A1 * x1 = B1
  float* A1[n1];

  // define rows for A1 matrix
  float A1_1[n1] = {5.0, -2.0, 3.0};
  float A1_2[n1] = {10.0, -3.0, 4.0};
  float A1_3[n1] = {15.0, 1.0, -3.0};

  // set row addresses
  A1[0] = A1_1;
  A1[1] = A1_2;
  A1[2] = A1_3;

  float B1[n1] = {18.0, 28.0, 4.0};
  float x1[n1];
  int   P1[n1] = {0, 1, 2}; // pivot array in "natural" order.
  // if you don't start in this order
  // things won't work in gauss().
  //
  /////////////////////////////////////////////////////////////////////////////
  // Define System II: A2 * x2 = B2
  float * A2[n2];

  // define rows for A2 matrix
  float A2_1[n2] = {-1.0, 2.0, 5.0, 3.0};
  float A2_2[n2] = {4.0, -8.0, 1.0, 2.0};
  float A2_3[n2] = {2.0, 3.0, -3.0, -1.0};
  float A2_4[n2] = {1.0, 2.0, 1.0, 4.0};

  // set row addresses
  A2[0] = A2_1;
  A2[1] = A2_2;
  A2[2] = A2_3;
  A2[3] = A2_4;

  float B2[n2]    =   {4.0, 12.0, 2.0, 10.0};
  float x2[n2];
  int   P2[n2]    =   {0, 1, 2, 3};
  //
  /////////////////////////////////////////////////////////////////////////////
  //
  // Define System III: A3 * x3 = B3
  //
  float * A3[n3];

  // define rows for A3 matrix
  float A3_1[n3] = {3.0, 1.0, 1.0};
  float A3_2[n3] = {-6.0, -2.0, 2.0};
  float A3_3[n3] = {-3.0, -1.0, 3.0};

  // set row addresses
  A3[0] = A3_1;
  A3[1] = A3_2;
  A3[2] = A3_3;

  float B3[n3]    =   {2.0, 8.0, 10.0};
  float x3[n3];
  int   P3[n3]    =   {0, 1, 2}; // pivot array, pivot row order
  //
  /////////////////////////////////////////////////////////////////////////////
  //
  // Define System IV: A4 * x4 = B4
  //
  float * A4[n4];

  // define rows for A4 matrix
  float A4_1[n4] = {3.0, 1.0, 4.0};
  float A4_2[n4] = {-6.0, -1.0, 1.0};
  float A4_3[n4] = {-3.0, 0.0, 5.0};

  // set row addresses
  A4[0] = A4_1;
  A4[1] = A4_2;
  A4[2] = A4_3;

  float B4[n4]    =   {3.0, 17.0, 8.0};
  float x4[n4];
  int   P4[n4]    =   {0, 1, 2}; // pivot array, pivot row order
  //
  /////////////////////////////////////////////////////////////////////////
  //
  // Print out heading...
  //
  cout << "\nNumerical Comp\n"
    << "Solving Ax = B using Gaussian Elimination with Partial Pivoting"
    << endl;

  // Print original A1 and B1 matrices...
  //
  cout << "\nLinear System I before gauss():" << endl;
  cout << "A1 =" << endl;
  print_A_Matrix(A1, n1);
  cout << endl;

  cout << "B1 = " << endl;
  print_B_or_X_Matrix(B1, n1);
  cout << endl;
  gauss(A1, x1, B1, n1, P1, is_Solved); // try to solve system I

  // Report results...
  cout << "Did gauss() succeed?";
  if (is_Solved)
  {
    cout << " Yes!" << "\n\nLinear System I after gauss():" << endl;
    cout << "A1 =" << endl;
    print_A_Matrix(A1, n1);
    cout << endl;

    cout << "B1 =" << endl;
    print_B_or_X_Matrix(B1, n1);
    cout << endl;

    cout << "P1 = " << endl;
    print_P_Matrix(P1, n1);
    cout << endl;

    cout << "x1 =" << endl;
    print_B_or_X_Matrix(x1, n1);
    cout << endl;
  }
  else
  {
    cout << " No! Better luck next time." << endl;
  }
  //
  /////////////////////////////////////////////////////////////////////////
  //
  // Print original A2 and B2 matrices...
  //
  cout << "\nLinear System II before gauss():" << endl;
  cout << "A2 =" << endl;
  print_A_Matrix(A2, n2);
  cout << endl;

  cout << "B2 = " << endl;
  print_B_or_X_Matrix(B2, n2);
  cout << endl;
  gauss(A2, x2, B2, n2, P2, is_Solved); // try to solve system II

  // Report results...
  cout << "Did gauss() succeed?";
  if (is_Solved)
  {
    cout << " Yes!" << "\n\nLinear System II after gauss():" << endl;
    cout << "A2 =" << endl;
    print_A_Matrix(A2, n2);
    cout << endl;

    cout << "B2 =" << endl;
    print_B_or_X_Matrix(B2, n2);
    cout << endl;

    cout << "P2 = " << endl;
    print_P_Matrix(P2, n2);
    cout << endl;

    cout << "x2 =" << endl;
    print_B_or_X_Matrix(x2, n2);
    cout << endl;
  }
  else
  {
    cout << " No! Better luck next time." << endl;
  }
  //
  /////////////////////////////////////////////////////////////////////////
  //
  // Print original A3 and B3 matrices...
  //
  cout << "\nLinear System III before gauss():" << endl;
  cout << "A3 =" << endl;
  print_A_Matrix(A3, n3);
  cout << endl;

  cout << "B3 = " << endl;
  print_B_or_X_Matrix(B3, n3);
  cout << endl;
  gauss(A3, x3, B3, n3, P3, is_Solved); // try to solve system III

  // Report results...
  cout << "Did gauss() succeed?";
  if (is_Solved)
  {
    cout << " Yes!" << "\n\nLinear System III after gauss():" << endl;
    cout << "A3 =" << endl;
    print_A_Matrix(A3, n3);
    cout << endl;

    cout << "B3 =" << endl;
    print_B_or_X_Matrix(B3, n3);
    cout << endl;

    cout << "P3 = " << endl;
    print_P_Matrix(P3, n3);
    cout << endl;

    cout << "x3 =" << endl;
    print_B_or_X_Matrix(x3, n3);
    cout << endl;
  }
  else
  {
    cout << " No! Better luck next time." << endl;
  }
  //
  /////////////////////////////////////////////////////////////////////////
  //
  // Print original A4 and B4 matrices...
  //
  cout << "\nLinear System IV before gauss():" << endl;
  cout << "A4 =" << endl;
  print_A_Matrix(A4, n4);
  cout << endl;

  cout << "B4 = " << endl;
  print_B_or_X_Matrix(B4, n4);
  cout << endl;
  gauss(A4, x4, B4, n4, P4, is_Solved); // try to solve system IV

  // Report results...
  cout << "Did gauss() succeed?";
  if (is_Solved)
  {
    cout << " Yes!" << "\n\nLinear System IV after gauss():" << endl;
    cout << "A4 =" << endl;
    print_A_Matrix(A4, n4);
    cout << endl;

    cout << "B4 =" << endl;
    print_B_or_X_Matrix(B4, n4);
    cout << endl;

    cout << "P4 = " << endl;
    print_P_Matrix(P4, n4);
    cout << endl;

    cout << "x4 =" << endl;
    print_B_or_X_Matrix(x4, n4);
    cout << endl;
  }
  else
  {
    cout << " No! Better luck next time." << endl;
  }
  //
  //
}  // end main() ///////////////////////////////////////////////////////////////

void print_A_Matrix(float* A[], int n)
{
  // input parms: A is an (n x n) matrix.
  // return value: none

  for(int i = 0; i < n; i++)
  {
    for(int j = 0; j < n; j++)
    {
      // format output
      cout.width(10);
      cout.setf(ios::right);
      cout << A[i][j];
    }
    cout << endl; // break line after row prints
  }
} // end print_A_Matrix()

void print_B_or_X_Matrix(float array[], int n)
{
  // input parms: array[] is a 1-dimensional array of size n.
  // return value: none

  for (int i = 0; i < n; i++)
  {
    // format output
    cout.width(10);
    cout.setf(ios::right);
    cout << array[i] << endl;
  }
  cout << endl; // break line after row prints
} // end print_B_or_X_Matrix()

void print_P_Matrix(int array[], int n)
{
  // input parms: array[] is a 1-dimensional array of size n.
  // return value: none

  for (int i = 0; i < n; i++)
  {
    // format output
    cout.width(10);
    cout.setf(ios::right);
    cout << array[i] << endl;
  }
  cout << endl; // break line after row prints
} // end print_P_Matrix()

void gauss(float* A[], float x[], float B[], int n, int P[], bool &is_Solved)
{
  // gauss() solves the system Ax = B with partial pivoting so long as the
  //         A is not singular. that is, so long as there are not
  //         infinitely many solutions or no solutions at all for Ax = B.
  //
  // input parms:
  //
  //		A = the (n x n) matrix that is to be transformed
  // 	n = the row and column size of matrix A.  A is an (n x n) or square matrix.
  //		B = the right hand side (RHS) of the equation Ax = B.
  //    P = the index or pivot array.  this array will keep track of the order
  //        in which pivot rows are employed.  for example, at the start of
  //        this function, P always equals the "natural order". that is,
  //        P = {0,1,2} for a (3x3) matrix A or P = {0,1,2,3} for a (4x4) matrix A.
  //
  //        after this function "performs" P can equal something like this:
  //        {1,0,2}.  (this would be the case for a 3x3 matrix.) what this
  //        means is that the second row in A was used as the first pivot row
  //        then the first row in A was used as a pivot row.
  //
  //        if P={2,1,0} at the end of this function, then the 3rd row in A
  //        was used as the first pivot row, followed by the second row.
  //
  //        please note:  the number of pivot rows used in a system is always
  //        one less than the number of rows in the A matrix.  in the case
  //        of a 3x3 matrix, only 2 pivot rows are used (computed and employed.)
  //
  //
  //
  //    please note: A, B, P and is_Solved are passed by reference.  A will
  //    be destroyed by this function.  that is, A's data values will be
  //    changed.  if you need to save the values of A, please save them
  //    before calling this function.
  //
  //    return values:
  //
  //    x will contain soltions to the system Ax = B so long as A is not
  //    singular.
  //
  //    A will be transformed via elimination.  multipliers will be stored
  //      where zeros created from elimination could be stored.
  //
  //    B is transformed as well by the elimination process.
  //
  //    P contains the order in which pivot rows were selected.
  //
  //    n is passed in by value, therefore it dies when gauss() returns.
  //
  //    is_Solved returns true if the system Ax = B can be solved or false if
  //            the system cannot be solved.
  //
  /////////////////////////////////////////////////////////////////////////////
  //
  // define LOCAL VARS...
  //
  float* s = new float[n];  // scale vector -- will contain #'s with the largest
  // magnitude for each row in A matrix
  float r;     // temp ratio of column entry/scale entry
  float rmax;  // the greatest ratio
  float smax;  // the greatest scale
  float xmult; // multiplier used to algebraically eliminate (simplify equations)
  int j;       // index where the greatest ratio occurs
  int temp;

  int k;     // k is the index of the column in which new zeros will be created.
  // however, we must remember that no zeros are actually stored in
  // A, instead, those storage locations are used to store
  // multipliers.  tricky, no?

  float sum; // used in the backward substitution part of the algo.

  // initialize return value
  is_Solved = true;

  //
  /////////////////////////////////////////////////////////////////////////////
  //
  // populate scale array (vector)...
  // for each row in A, find the number with the largest magnitude and
  // store this number in the array s.
  //
  for(int i = 0; i < n; i++)
  {
    smax = 0;  // max for in each row
    for(j = 0; j < n; j++)
    {
      if(smax < fabs(A[i][j]))
      {
        smax = (float) fabs(A[i][j]); // we want to use single precision,
        // hence, the typecast.
      }

    }
    s[i] = smax; // populate s array.
  }

  /*
  // print the s array for debugging purposes...
  cout << "Contents of Scale Array:" << endl;
  for (int i=0; i<n; i++)
  {
  cout << "\t\t\t\ts[" << i << "] = " << s[i] << endl;
  }
  cout << endl;
  */

  // find pivot rows, and perform elimination process
  for(k = 0; k < (n-1); k++)
  {
    rmax = 0;
    for(int i = k; i < n; i++)
    {
      // divide all row elements in the k-th column of matrix A by an element
      // in the scale array.  the P array elements tell us which
      // scale values to use.
      r = (float)fabs((A[P[i]][k]) / (s[P[i]]));

      if(r > rmax)
      {
        rmax = r;
        j = i; // index where the greatest ratio occurs
      }
    }
    // rearrange the P array by swapping P[j] and P[k].
    // this rearrangement of P values simulates the switching of rows.
    temp = P[j];
    P[j] = P[k];
    P[k] = temp;

    // look at this new pivot row and examine the k-th column's element.
    // if it's zero, the matrix A is singular. that is, it has infinitely
    // many solutions or no solutions at all.
    if(A[P[k]][k] == 0)  // test system for singularity
    {
      is_Solved = false;
      cout << "Matrix A is singular...you're out of luck!" << endl;
      return;
    }

    /*
    // print P and A arrays for debugging purposes
    cout << "P = ";
    for(int i = 0; i < n; i++)
    {
    cout << P[i] << " ";
    }
    cout << endl << endl;

    cout << "The A matrix, when k = " << k << ", is:" << endl;
    print_A_Matrix(A, n);
    cout << endl << endl;
    */
    // compute and store multipliers in A matrix.  remember, conceptually these
    // locations in the A matrix would be zero, but we are going to store
    // the multiplier values here instead.
    for(int i = k + 1; i < n; i++)
    {
      // compute multiplier and store in A matrix
      xmult = ((A[P[i]][k])/(A[P[k]][k]));
      A[P[i]][k] = xmult; // store multiplier in A matrix
      /*
      // print debug
      cout << "i = " << i << endl;
      cout << "xmult = " << xmult << endl;
      */
      // subtract multiples of P[k] from rows P[k+1], P[k+2], P[k+3], ...
      for(j = k + 1; j < n; j++)
      {
        A[P[i]][j] = (A[P[i]][j]) - (xmult * (A[P[k]][j]));
        /*
        // print debug
        cout << "j = " << j << endl;
        cout << "A[" << P[i] << "][" << j << "] = " << A[P[i]][j] << endl;
        */
      }
      /*
      // print debug
      cout << endl;
      */
      // don't forget to process the B matrix...
      B[P[i]] = B[P[i]] - ((A[P[i]][k]) * B[P[k]]);
    }
  } // end for(k = 0; k < (n-1); k++) -- finding rows and elimination process

  // test system for singularity once more
  if(A[P[n-1]][n-1] == 0)
  {
    is_Solved = false;
    cout << "Matrix A is singular...you're out of luck!" << endl;
    return;
  }


  /////////////////////////////////////////////////////////////////////////////
  //
  // at this point, if we made it this far, then A has been transformed
  // into a triangular system and can be solved relative to the B matrix...
  //
  // start backward substitution process...
  //

  // solve the equation with the one unknown
  x[n-1] = B[P[n-1]] / A[P[n-1]][n-1];

  // solve the rest of the equations...
  for (int i = (n-2); i >= 0; i--)
  {
    sum = B[P[i]];
    for (int j = i; j < n; j++)
    {
      sum = sum - (A[P[i]][j] * x[j]);
    }
    x[i] = sum / A[P[i]][i]; // store solutions in x array
  }

  delete [] s;
  // it's miller time, baby!

} // end gauss()

