// Closure.cpp -- the data structure for function closures

#include <iostream.h>
#include <string.h>
#include "Closure.h"
#include "Environment.h"
void
BuiltIn::print(int n) {
  // there got to be a more efficient way to print n spaces
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << "#{Built-in Procedure" << endl;
  symbol->print(n+3);
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << '}' << endl;
}


Node *
BuiltIn::apply(Node * args) {
    // TODO: implement this, see the comment in Closure.h
    //LAB #2
    char * sym_name = symbol->getName();
    Node * arg1 = args->getCar();
    if(arg1 == NULL || arg1->isNull()){
	arg1 = new Nil();
    }
    Node * arg2 = args->getCdr();
    if(arg2==NULL || arg2->isNull()){
	arg2 = new Nil();
    }else
    {
	arg2 = arg2->getCar();
    }
   
    if(strcmp(sym_name, "b+")== 0){
	if(arg1->isNumber() && arg2->isNumber()){
	    int x = arg1->getVal();	
	    int y = arg2->getVal();
	    return new IntLit(x+y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b+\n";
	    return new StrLit("");
	}
    }else if(strcmp(sym_name, "b-")== 0){

	if(arg1->isNumber() && arg2->isNumber())
	{
	    int x = arg1->getVal();
	    int y = arg2->getVal();
	    return new IntLit(x - y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b-\n";
	    return new StrLit("");
	}
    }else if(strcmp(sym_name, "b/")== 0){

	if(arg1->isNumber() && arg2->isNumber())
	{
	    int x = arg1->getVal();
	    int y = arg2->getVal();
	    return new IntLit(x / y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b/\n";
	    return new StrLit("");
	}
    }else if(strcmp(sym_name, "b*")== 0){

	if(arg1->isNumber() && arg2->isNumber())
	{
	    int x = arg1->getVal();
	    int y = arg2->getVal();
	    return new IntLit(x * y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b*\n";
	    return new StrLit("");
	}
    }else if(strcmp(sym_name, "b<")== 0){
	
	if(arg1->isNumber() && arg2->isNumber())
	{
	    int x = arg1->getVal();
	    int y = arg2->getVal();
	    return new BoolLit(x < y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b<\n";
	}
    }else if(strcmp(sym_name, "b=")== 0){
	
	if(arg1->isNumber() && arg2->isNumber())
	{
	    int x = arg1->getVal();
	    int y = arg2->getVal();
	    return new BoolLit(x == y);
	}else
	{
	    cout << "ERROR: Incorrect argument type for b=\n";
	}
    }else if(strcmp(sym_name, "number?")== 0){
	
	    return new BoolLit(arg1->isNumber());
    }else if(strcmp(sym_name, "eval")== 0){	
	return arg1;
    }else if(strcmp(sym_name, "null?")== 0){
	
	return new BoolLit(arg1->isNull());
    }else if(strcmp(sym_name, "car")== 0){
	if(arg1->isNull()){
	    return arg1;
	}
	return arg1->getCar();
    }else if(strcmp(sym_name, "cdr")== 0){
	if(arg1->isNull()){
	    return arg1;
	}
	return arg1->getCdr();
    }else if(strcmp(sym_name, "cons")== 0){
	return new Cons(arg1, arg2);
    }else if(strcmp(sym_name, "pair?")== 0){
	return new BoolLit(arg1->isPair());
    }
    else if(strcmp(sym_name, "symbol?")== 0){
	return new BoolLit(arg1->isSymbol());
    }else if(strcmp(sym_name, "set-car!")== 0){
	arg1->setCar(arg2);
	return arg1;
    }else if(strcmp(sym_name, "set-cdr!")== 0){
	arg1->setCdr(arg2);
	return arg1;
    }else if(strcmp(sym_name, "procedure?")== 0){
	return new BoolLit(arg1->isProcedure());
    }else if(strcmp(sym_name, "newline")== 0){
	return new StrLit("\n", FALSE);
    }else if(strcmp(sym_name, "eq?")== 0){

	if(arg1->isBool() && arg2->isBool()){
	    return new BoolLit(arg1->getBool() == arg2->getBool());
	}
	else if(arg1->isNumber() && arg2->isNumber()){
	    return new BoolLit(arg1->getVal() == arg2->getVal());
	}
	else if(arg1->isString() && arg2->isString()){
	    return new BoolLit(strcmp(arg1->getName(), arg2->getName())==0);
	}
	else if(arg1->isSymbol() && arg2->isSymbol()){
	    return new BoolLit(strcmp(arg1->getName(), arg2->getName())==0);
	}
	else if(arg1->isNull() && arg2->isNull()){
	    return new BoolLit(TRUE);
	}
	else if(arg1->isPair() && arg2->isPair()){
	    //make new lists, with the elements of each list being
	    //args for another call to apply; these lists will allow
	    //apply to compare the car and the cdr of a list element
	    //by element (recursively) in order to find their equality
	    //Perhaps a "cleaner" way to do this would be to create a
	    //helper function; it could possibly also be more effiecient
	    Node * frontArgs = new Cons(arg1->getCar(), new Cons(arg2->getCar(), new Nil()));
	    Node * backArgs = new Cons(arg1->getCdr(), new Cons(arg2->getCdr(), new Nil()));
	    return new BoolLit(apply(frontArgs)->getBool() && apply(backArgs)->getBool());
	}
	return new BoolLit(FALSE);
    }else if(strcmp(sym_name, "write") == 0){
	arg1->print(0);
	return new StrLit("");
    }else if(strcmp(sym_name, "interaction-environment") == 0){
	interaction_environment->print(0);
    }else if(strcmp(sym_name, "apply") == 0){
	return arg1->apply(arg2);
    }else
	cerr << "BuiltIn function \"" << sym_name << "\" not found!\n";
	return new StrLit("");
}


void
Closure::print(int n) {
  // there got to be a more efficient way to print n spaces
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << "#{Procedure" << endl;
  fun->print(n+3);
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << '}' << endl;
}


Node *
Closure::apply(Node * args) {
    // TODO: implement this, see the comment in Closure.h
    Environment * e = this->getEnv();
    Node * fun = getFun();
    Node * sym = fun->getCar();
    fun = fun->getCdr()->getCar();
    while(!args == NULL && !args->getCar()->isNull()){
	e->define(sym->getCar(), args->getCar());
	sym = sym->getCdr();
	args = args->getCdr();
    }
    //now, the Closure has to be evaluated, since the args have been
    //defined

    return fun->eval(e);
}
