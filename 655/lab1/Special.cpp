// Special.cpp -- the implementation of the special form classes

#include "Special.h"

void
Quote::print(Node * t, int n, bool p) {
    // TODO: implement this function.
    cout << '\'';
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n, FALSE);
	Cdr = Cdr->getCdr();
    }
}

void
Lambda::print(Node * t, int n, bool p) {
    // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "lambda ";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    Car = Cdr->getCar();
    Car->print(0, FALSE);
    cout << '\n';
    Cdr = Cdr->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
Begin::print(Node * t, int n, bool p) {
    // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "begin\n";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
If::print(Node * t, int n, bool p) {
    // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "if\n";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
Let::print(Node * t, int n, bool p) {
  // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "let\n";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
Cond::print(Node * t, int n, bool p) {
  // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "cond\n";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
Define::print(Node * t, int n, bool p) {
  // TODO: implement this function.
    if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "define ";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    Car = Cdr->getCar();
    Car->print(0, FALSE);
    cout << '\n';
    Cdr = Cdr->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
}

void
Set::print(Node * t, int n, bool p) {
        if(!p)
    {
	for(int i=0; i<n; i++)
	{
	    cout << ' ';
	}
	cout << '(';
    }
    cout << "set!\n";
    Node * Car, * Cdr;
    Cdr = t->getCdr();
    while(!Cdr->isNull())
    {
	Car = Cdr->getCar();
	Car->print(n+2, FALSE);
	cout << '\n';
	Cdr = Cdr->getCdr();
    }
    Cdr->print(n, TRUE);
  // TODO: implement this function.
//     Node * Car, * Cdr;
//     Car = t->getCar();
//     Cdr = t->getCdr();
//     for(int i = 0; i < n; i++)
//     {
// 	cout << " ";
//     }
//     if(!p)
//     {
// 	cout << "(SET!\n";
//     }else
//     {
// 	cout << "SET!\n";
//     }
//     if(n<0)
//     {n = -n;}
//     Cdr->print(n, TRUE);
}

void
Regular::print(Node * t, int n, bool p) {
  // TODO: implement this function.
    Node * Car, * Cdr;
    Car = t->getCar();
    Cdr = t->getCdr();
    for(int i = 0; i < n; i++)
    {
	cout << " ";
    }
    if(!p)
    {
	cout << "("; //Note: removed \n after (
    }
    //if(n<0)
    //{ n = -n; }
    Car->print(0); //Note: changed n+2 to n
    //if((Cdr->isNull()) || (Cdr->isPair()))
    //{
    if(Cdr->isNull() || Cdr->isPair())
    {
	cout << " ";
	Cdr->print(0, TRUE);
    }
    else
    {
	cout << " . ";
	Cdr->print(0, TRUE);
	cout << ")";
    }
	//}else
	//{
	//cout << ".\n";
//	Cdr->print(n+2, TRUE);
	//cout << ")\n";
	//}
}
