// Main.cpp -- the main program
//
// Defines
//
//   int main(int, char**)

#include <iostream.h>

#include "Tokens.h"
#include "Tree.h"
#include "Scanner.h"
#include "Parser.h"
#include "Closure.h"
#include "Environment.h"

// Array of token names used for debugging the scanner
static char * TokenName[] = {
  "QUOTE",				// '
  "LPAREN",				// (
  "RPAREN",				// )
  "DOT",				// .
  "TRUET",				// #t
  "FALSET",				// #f
  "INT",				// integer constant
  "STRING",				// string constant
  "IDENT"				// identifier
};


int main (int argc, char ** argv) {
  // create scanner that reads from standard input
  Scanner * scanner = new Scanner(&cin);

  if (argc > 2) {
    cerr << "Usage: " << argv[0] << "[-d]" << endl;
    return 1;
  }

  // if commandline option -d is provided, debug the scanner
  if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'd') {
    // debug scanner
    Token * tok = scanner->getNextToken();
    while (tok != NULL) {
      TokenType tt = tok->getType();
      cout << TokenName[tt];
      if (tt == INT)
	cout << ", intVal = " << tok->getIntVal();
      else if (tt == STRING)
	cout << ", strVal = " << tok->getStrVal();
      else if (tt == IDENT)
	cout << ", name = " << tok->getName();
      cout << endl;
      tok = scanner->getNextToken();
    }
  }

  // Create parser
  Parser * parser = new Parser(scanner);
  Node * root;
  
  //LAB #2
  Environment * builtin_env = new Environment();
  Ident * id;
  id = new Ident("b+");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("car");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("symbol?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("number?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("b/");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("b-");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("b*");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("b=");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("b<");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("cdr");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("cons");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("set-car!");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("set-cdr!");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("null?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("pair?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("eq?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("procedure?");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("read");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("write");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("display");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("newline");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("eval");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("apply");
  builtin_env->define(id, new BuiltIn(id));
  id = new Ident("interaction-environment");
  builtin_env->define(id, new BuiltIn(id));
  Environment * env = new Environment(builtin_env);
  BuiltIn * x = new BuiltIn(env); //define the interaction_environment

  // Parse and pretty-print each input expression
  root = parser->parseExp();
  while (root != NULL) {
      root->eval(env)->print(0);
      root = parser->parseExp();
  }

  return 0;
}
