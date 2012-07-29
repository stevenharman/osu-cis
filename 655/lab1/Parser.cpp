// Parser.cpp -- the implementation of class Parser

#include "Parser.h"

Node *
Parser::parseExp()
{
  // TODO: write code for parsing an exp
//     Token * t = scanner->getNextToken();
//     if (! LookAhead) //if the lookahead token hasn't been read...
//     {
// 	LookAheadToken = t;//...make t the "lookahead"!
//     }

    
    if(LookAheadToken == NULL) //We don't have a LookAheadToken
    {
	Token * NextTok = scanner->getNextToken();
	//we can check the TokenType of the NextTok in 2 ways... which
	//do you prefer?
	//1st way?
	TokenType NextTokType = NextTok->getType();
	if(NextTokType == LPAREN)
	{//cout << "found LPAREN\n";
	    return parseRest();
	}else if(NextTok->getType() == QUOTE) //or 2nd way?
	{
	    Cons * NewConsNode;
	    NewConsNode = new Cons(parseExp(), new Nil());
	    return new Cons(new Ident("quote"), NewConsNode);
	}else if(NextTok->getType() == FALSET)
	{
	    return new BoolLit(false);
	}else if(NextTok->getType() == TRUET)
	{
	    return new BoolLit(true);
	}else if(NextTok->getType() == INT)
	{
	    return new IntLit(NextTok->getIntVal());
	}else if(NextTok->getType() == STRING)
	{
	    return new StrLit(NextTok->getStrVal());
	}else if(NextTokType == IDENT)
	{//cout << "no LA, getting IDENT\n";
	    return new Ident(NextTok->getName());
	}else
	{
	    cerr << "Parse Error: Unexpected Token Hi!\n";
	    return parseExp();
	}
    }else //We have the LookAheadToken already
    {
	if(LookAheadToken->getType() == LPAREN)
	{//cout << "LA, found LAPREN\n";
	    return parseRest();
	}
	else if(LookAheadToken->getType() == QUOTE)
	{
	///??? Cliff, does this look right? -not sure...I'm a little
	///fuzzy on the whole Cons phenomenon
	    LookAheadToken = NULL; //don't want LookAhead in next parseExp
	    Cons * NewConsNode;
	    NewConsNode = new Cons(parseExp(), new Nil());
	    return new Cons(new Ident("quote"), NewConsNode);
	}
	else if (LookAheadToken->getType() == FALSET)
	{
	    return new BoolLit(false);
	}
	else if (LookAheadToken->getType() == TRUET)
	{
	    return new BoolLit(true);
	}
	else if (LookAheadToken->getType() == INT)
	{
	    return new IntLit(LookAheadToken->getIntVal());
	}
	else if (LookAheadToken->getType() == STRING)
	{
	    return new StrLit(LookAheadToken->getStrVal());
	}
	else if (LookAheadToken->getType() == IDENT)
	{//cout << "have LA, getting IDENT\n";
	    return new Ident(LookAheadToken->getName());
	}
	else //I don't know if we need this, and it's giving me an error
	//message for stuff that shouldn't be an erroR, so I'm taking it
	//out for now
	{
	    cerr << "\nWarning : Invalid expression";
            //need to continue parsing
	    LookAheadToken = NULL;
	    return parseExp();
	}
    }
    return NULL;
}

Node *
Parser::parseRest()
{
    // TODO: write code for parsing rest
    Token * NextTok = scanner->getNextToken();
    
    if(NextTok->getType() == RPAREN)
    {//cout << "parseRest() found RPAREN\n";
	return new Nil();
    }else if(NextTok->getType() == DOT)
    {
	Node * DotNode;
	NextTok = scanner->getNextToken();
	LookAheadToken = NextTok;
	DotNode = parseExp();
	NextTok = scanner->getNextToken();
	if(NextTok->getType() != RPAREN)
	{
	    cerr << "Parse Error: Expecting Expression following dot\n";
	    //LookAheadToken = NULL;
	}
	return DotNode;
    }else
    {
	//what about the lookahead token (NextToken)? It needs to be
	//put back before we return?
	//cout << "parseRest() setting LookAheadToken = NextTok\n";
	LookAheadToken = NextTok;
	//cout << "parseRest() building a Cons(parseExp, parseRest)\n";
	return new Cons(parseExp(), parseRest());
    }
    return NULL;
}
