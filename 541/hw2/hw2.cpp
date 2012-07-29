// CIS541 HW#2
// Steve Harman

#include <math.h>
#include <sys/times.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream.h>

//define any constants
#define PI 3.14159265359

const double err_tol = pow(10,-12);
const double x_range = pow(10,5);
const int max_iterations = 100;
const int fxn_1 = 1;
const int fxn_2 = 2;
const int fxn_3 = 3;
const int quit = 0;

const int r_found = 0; //flag for root found
const int too_big = 1; //flag for xi too big
const int its = 2; //flag for too many iterations
const int no_root = 3; //flag for no root in interval
int result = r_found;
int iterations = 0;

//define helper functions to calculate f1, f2, & f3 & their primes

double f1(double x);
double f1P(double x);

double f2(double x);
double f2P(double x);

double f3(double x);
double f3P(double x);
//helper functions: bisection, newton, secant methods
double bisection(double a, double b, double fxn(double));
double newton(double a, double fxn(double), double fxnP(double));
double secant(double x0, double x1, double fxn(double));

int main()
{
  hrtime_t start, end;
  int fxn_num;
  printf("Which function: 1, 2, 3, or 0 to quit? ");
  cin >> fxn_num;

  while(fxn_num != quit)
  {
    int interval = 0;
    double root = 0;
    //-- Bisection method --
    printf("-- Bisection Method --\n");
    start = gethrtime();
    while(interval < 10)
    {
      double a, b;
      //	    int i = interval; //set base of current interval
      a = interval;
      b = interval+1;
      //cout << "Interval: [" << a << ',' << b << "] - ";
      printf("Interval: [%.0f,%.0f] - ", a, b);
      switch(fxn_num)
      {
        case fxn_1:
          root = bisection(a, b, f1);
          break;
        case fxn_2:
          root = bisection(a, b, f2);
          break;
        case fxn_3:
          root = bisection(a, b, f3);
          break;
      }

      if(result == r_found)
        //cout << "root: " << root << "\n";
        printf("Root: %.13f, iterations: %d\n", root, iterations);
      else
        printf("No root found.\n");
      interval++; //go to next interval 0-10
    }
    end = gethrtime();
    printf("Elapsed time = %lld nanoseconds.\n", (end-start));

    //-- Newton's Method --
    printf("-- Newton's Method --\n");
    interval = 0;
    root = 0;
    start = gethrtime();
    while(interval <= 10)
    {
      printf("x= %d - ", interval);
      switch(fxn_num)
      {
        case fxn_1:
          root = newton(interval, f1, f1P);
          break;
        case fxn_2:
          root = newton(interval, f2, f2P);
          break;
        case fxn_3:
          root = newton(interval, f3, f3P);
          break;
      }
      if(result == r_found)
        //cout << "root: " << root << "\n";
        printf("Root: %.13f, iterations: %d\n", root, iterations);
      else if(result == too_big)
        printf("No root found, xi too big.\n");
      else if(result == its)
        printf("No root found, too many iterations\n");

      interval++; //go to next interval 0-10
    }
    end = gethrtime();
    printf("Elapsed time = %lld nanoseconds.\n", (end-start));

    //-- Secant Method --
    printf("-- Secant Method --\n");
    interval = 0;
    root = 0;
    start = gethrtime();
    while(interval < 10)
    {
      double x0, x1;
      x0 = interval;
      x1 = interval+1;
      //cout << "Interval: [" << a << ',' << b << "] - ";
      printf("Interval: [%.0f,%.0f] - ", x0, x1);
      switch(fxn_num)
      {
        case fxn_1:
          root = secant(x0, x1, f1);
          break;
        case fxn_2:
          root = secant(x0, x1, f2);
          break;
        case fxn_3:
          root = secant(x0, x1, f3);
          break;
      }

      if(result == r_found)
        //cout << "root: " << root << "\n";
        printf("Root: %.13f, iterations: %d\n", root, iterations);
      else if(result == too_big)
        printf("No root found, xi too big.\n");
      else if(result == its)
        printf("No root found, too many iterations\n");
      else
        printf("No root found, unknown reason.\n");

      interval++; //go to next interval 0-10
    }
    end = gethrtime();
    printf("Elapsed time = %lld nanoseconds.\n", (end-start));


    printf("Which function: 1, 2, 3, or 0 to quit? ");
    cin >> fxn_num;
  }//while(fxn_num != quit)
  //     start = gethrtime();
  //     printf("Hello world!\n");
  //     end = gethrtime();
  //     printf("Elapsed time = %lld nanoseconds.\n", (end-start));
  return 1;
}

double bisection(double a, double b, double fxn(double))
{
  double c, fa, fb, fc;
  iterations = 0;
  fc = 1; //initialize fc = 1 to make sure while cond holds on first iteration

  while((iterations < max_iterations) && (fabs(fc) >= err_tol))
  {
    c = (a+b)/2;
    fa = fxn(a);
    fb = fxn(b);
    fc = fxn(c);
    if(fa*fb < 0) //make sure fa & fb have diff signs
    {
      if(fc*fa < 0) //fc & fa have different signs
      {
        b = c; //use new interval [a,c]
      }else //fc & fb have different signs
      {
        a = c; //use new interval [c,b]
      }
      iterations++;
    }else //fa & fb don't have diff signs, so no root!
    {
      result = no_root;
      return c;
    }
  }

  if(fabs(fc) >= err_tol) //if more than max_iterations, we must still be outside of the tolerance, so return -1
  {
    result = no_root;
    return c;
    //printf("no root found.");
  }else
  {
    result = r_found;
    return c;
  }
}

double newton(double x, double fxn(double), double fxnP(double))
{
  iterations = 0;
  double xi;

  while((iterations < max_iterations) && (fabs(x) < x_range))
  {
    //  	if(fxnP(x) < (1/x_range)) //make sure FxnP(x) > x_range
    //   	    return -100;
    xi = x - (fxn(x)/fxnP(x));
    if(fabs(xi-x) < err_tol)
    {
      result = r_found;
      return xi;
    }else
    {
      x = xi;
    }
    iterations++;
  }
  if(fabs(x) > x_range)
  {
    result = too_big;
    return xi;
  }
  result = its;
  return xi; //no root found, too many its
}

double secant(double x0, double x1, double fxn(double))
{
  iterations = 0;
  double xi = 0;

  while((iterations < max_iterations) && (fabs(xi) < x_range))
  {
    xi = x1 - fxn(x1)*((x1-x0)/(fxn(x1)-fxn(x0)));
    if(fabs(fxn(xi)) < err_tol)
    {
      result = r_found;
      return xi;
    }else
    {
      x0 = x1;
      x1 = xi;
    }
    iterations++;
  }
  if(fabs(xi) >= x_range)
  {
    result = too_big;
    return xi;
  }else if(iterations >= max_iterations)
  {
    result = its;
    return xi;
  }else
  {
    result = no_root;
    return xi;
  }
}

double f1(double x)
{
  return (cos(x+1)-log((x/5)+1));
}
double f1P(double x)
{
  return (-sin(x+1)-(1/(x+5)));
}

double f2(double x)
{
  return (tan(.5+(x/3)));
}
double f2P(double x)
{
  return ((1/3)*pow((1/(cos(.5+(x/3)))),2));
}

double f3(double x)
{
  return ((1000/(x+1))+pow(3,x)-2*pow(x,3));
}
double f3P(double x)
{
  return (-1000*pow((x+1),-2)+(log(3)*pow(x,3))-(6*pow(x,2)));
}
