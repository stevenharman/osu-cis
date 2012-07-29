// Special.cpp -- the implementation of the special form classes

#include "Special.h"
#include "Printer.h"
#include "Closure.h"

// The print() methods for the Special node hierarchy were moved
// to file Special-print.cpp.  You can add your own code to the
// Special node hierarchy in this file and simply link in the
// compiled print() methods in Special-print.o by adding the file
// Special-print.o to the variable OBJ in the Makefile.

void
Quote::print(Node * t, int n, bool p) {
  Printer::printQuote(t, n, p);
}

//LAB #2
Node *
Quote::eval(Node * p, Environment * env) {
    return p->getCdr()->getCar();
}

void
Lambda::print(Node * t, int n, bool p) {
  Printer::printLambda(t, n, p);
}

//LAB #2
Node *
Lambda::eval(Node * p, Environment * env) {
    return new Closure(p->getCdr(), env);
}

void
Begin::print(Node * t, int n, bool p) {
  Printer::printBegin(t, n, p);
}

//LAB #2
Node *
Begin::eval(Node * p, Environment * env) {
    return NULL;
}

Node *
Begin::eval_begin(Node * p, Environment * env) {
    return NULL;
}
void
If::print(Node * t, int n, bool p) {
  Printer::printIf(t, n, p);
}

//LAB #2
Node *
If::eval(Node * p, Environment * env) {
    Node * cond, * exp;
    cond = p->getCdr()->getCar();
    //Node * val = cond->eval(env);
    //BoolLit * valsp = new BoolLit(val);
    //val = valsp->eval(p, env);
    if(cond->eval(env)->getBool())
    {//Then Do
	exp = p->getCdr()->getCdr()->getCar();
	//Now What, have to exp-eval, and then return p?
	//return NULL;
	return exp->eval(env);
    }else if(!(p->getCdr()->getCdr()->getCdr())->isNull())//Make sure there is an Else
    {//Else Do
	exp = p->getCdr()->getCdr()->getCdr()->getCar();
	//Now What?
	//return NULL;
	return exp->eval(env);
    }
    cout << "ERROR: No Else Expression.\n";
    return new Nil();
}

void
Let::print(Node * t, int n, bool p) {
  Printer::printLet(t, n, p);
}

//LAB #2
Node *
Let::eval(Node * p, Environment * env) {
    Node * args, * exp;
    Environment * local = new Environment(env);
    args = p->getCdr()->getCar(); 
    exp = p->getCdr()->getCdr()->getCar();
    args = eval_body(args, local);
    return exp->eval(local);
}
//helper fxn to eval <bindings><body> returns value of <body>
Node *
Let::eval_body(Node * p, Environment * env) {
    if(p == NULL || p->isNull())
    {
	Node * list = new Cons(new Nil(), new Nil());
	return list;
    }else
    {
	Node * arg, * exp, * rest;
	arg = p->getCar()->getCar();
	exp = p->getCar()->getCdr()->getCar();
	rest = p->getCdr();

	if(arg->isSymbol())
	{ //define var in local scope
	    env->define(arg,exp->eval(env));
	    return eval_body(rest, env);
	}else if (arg->isPair())//found exp to be evaluated, exp->eval(env)
	{
	    return arg->eval(env);
	}else if(arg == NULL || arg->isNull())
	{
	    return new Nil();
	}
    }
}

void
Cond::print(Node * t, int n, bool p) {
  Printer::printCond(t, n, p);
}

//LAB #2
Node *
Cond::eval(Node * p, Environment * env) {
    Node * exp;
    exp = p->getCdr();

    while((!(exp->getCar()->getCar()->eval(env)->getBool())) && (! exp->isNull()))
    {
	exp = exp->getCdr();
    }
    if(exp->isNull())
	return new Nil();
    else
	return (exp->getCar()->getCdr()->getCar()->eval(env));
}

void
Define::print(Node * t, int n, bool p) {
  Printer::printDefine(t, n, p);
}

//LAB #2
Node *
Define::eval(Node * p, Environment * env) {
    Node * id, * val;
 
    id = p->getCdr()->getCar();
    val = p->getCdr()->getCdr()->getCar();

    if(id->isSymbol()) { //defining a variable
	env->define(id, val);
    }
    else { //defining a function
	Closure * func = new Closure(new Cons(p->getCdr()->getCar()->getCdr(), p->getCdr()->getCdr()), env);
	env->define(id->getCar(), func);

    }

    return new StrLit("No values returned\n");
}

void
Set::print(Node * t, int n, bool p) {
  Printer::printSet(t, n, p);
}

//LAB #2
Node *
Set::eval(Node * p, Environment * env) {
    //do we need some err check to make sure id is defined?
    Node * id, * exp;
    id = p->getCdr()->getCar();
    exp = p->getCdr()->getCdr()->getCar();
    env->define(id,exp->eval(env));
    return new StrLit("");
}

void
Regular::print(Node * t, int n, bool p) {
  Printer::printRegular(t, n, p);
}

//LAB #2
Node *
Regular::eval(Node * p, Environment * env) {

    Node * front, * args;
    front = p->getCar();
    args = eval_list(p->getCdr(), env);

    while(front->isSymbol()){
	front = env->lookup(front);
    }
    if(front == NULL || front->isNull()){
	cerr << "Undefined function\n";
	return new Nil();
    }
    if(front->isProcedure()){ //built-in
	return front->apply(args);
    }
    else{
	return front->eval(env)->apply(args);
    }
 
 
}

//LAB #2
Node *
Regular::eval_list(Node * p, Environment * env) {
    if (p == NULL || p->isNull()){
	Node * list = new Cons(new Nil(), new Nil());
	return list;
    }
    else{
	Node * arg1, * rest;
	arg1 = p->getCar();
	rest = p->getCdr();

	if(arg1->isSymbol()){
	    arg1 = env->lookup(arg1);
	}
	if(arg1 == NULL || arg1->isNull()){
	    return new Nil();
	}
	Node * list = new Cons(arg1->eval(env), eval_list(rest, env));
	return list;
    }
} 
