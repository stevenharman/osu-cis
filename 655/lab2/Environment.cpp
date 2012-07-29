// Environment.cpp -- a data structure for Scheme environments

#include "Environment.h"
#include <string.h>

void
Environment::print(int n) {
  // there got to be a more efficient way to print n spaces
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << "#{Environment" << endl;
  scope->print(n+3);
  if (env != NULL)
    env->print(n+3);
  for (int i = 0; i < n; i++)
    cout << ' ';
  cout << '}' << endl;
}


// This is not in an object-oriented style, it's more or less a
// translation of the Scheme assq function.
static Node *
find (Node * id, Node * alist) {
  if (! alist->isPair())
    return NULL;	// in Scheme we'd return #f
  else {
    Node * bind = alist->getCar();
    if (strcmp(id->getName(), bind->getCar()->getName()) == 0)
      // return a list containing the value as only element
      return bind->getCdr();
    else
      return find(id, alist->getCdr());
  }
}

Node *
Environment::lookup (Node * id) {
  Node * val = find(id, scope);
  if (val == NULL && env == NULL) {
    cerr << "undefined variable" << endl;
    return NULL;
  }
  else if (val == NULL)
    // look up the identifier in the enclosing scope
      return env->lookup(id);
  else
    // get the value out of the list we got from find()
      return val->getCar();
}

void
Environment::define (Node * id, Node * val) {
  // TODO: implement this function
    //LAB #2

    Node * value = find(id, scope);
    if(value == NULL)
    {
	//add Name,Value pair as first element of innermost scope
	//scope = new Cons((new Cons(id, val)), scope);
	scope = new Cons(new Cons(id, new Cons(val, new Nil())), scope);
	//interaction_environment = new Cons(new Cons(id, new Cons(val, new Nil())), interaction_environment);
    }else
    {
	//name already exists in innermost scope, so update value

	value->setCar(val);
    }
//     Node * interaction_value = find(id, interaction_environment);
//     if(interaction_value == NULL)
//     {
// 	interaction_environment = new Cons(new Cons(id, new Cons(val, new Nil())), interaction_environment);
//     }
//     else{
// 	interaction_value->setCar(val);
//     }
}

void
Environment::assign (Node * id, Node * val) {
  // TODO: implement this function
    //LAB #2
    Node * value = find(id, scope);
    if(value == NULL && env == NULL)
    {
	//couldn't find the name in any env
	cerr << "Undefined Variable" << endl;
    }else if(value == NULL)
    {
	//look for the value in the enclosing scope
	assign(id, env);
    }else
    {
	//get the value out of the list returned by find()
	setCar(new Cons(id, val));
    }
  // You can use find() to get a list containing the value and
  // then update the value using setCar()
}
