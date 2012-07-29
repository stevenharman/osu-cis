// Parser.cpp -- the implementation of class Parser

#include "Parser.h"

Node *
Parser::parseExp()
{
  // TODO: write code for parsing an exp
    Token * t = scanner->getNextToken();
    if (! LookAhead) //if the lookahead token hasn't been read...
    {
	LookAheadToken = t;//...make t the "lookahead"!
    }

    
    if(LookAheadToken == NULL) //We don't have a LookAheadToken
    {
	Token * NextTok = scanner->getNextToken();
	//we can check the TokenType of the NextTok in 2 ways... which
	//do you prefer?
	//1st way?
	TokenType NextTokType = NextTok->getType();
	if(NextTokType == LPAREN)
	{
	    return parseRest();
	}else if(NextTok->getType() == QUOTE) //2nd way?
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
	}else if(NextTok->getType() == IDENT)
	{
	    return new Ident(NextTok->getName());
	}else
	{
	    cerr << "Parse Error: Unexpected Toke\n";
	    return parseExp();
	}
    }else //We have the LookAheadToken already
    {
	if(LookAheadToken->getType() == LPAREN)
	{
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
	{
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
    //Token * NextToken;
    //NextToken = scanner->getNextToken();
    LookAheadToken = scanner->getNextToken();
    LookAhead = true;
    
    if(LookAheadToken->getType() == RPAREN)
    {
	return new Nil();
    }else if(LookAheadToken->getType() == DOT)
    {
	Node * DotNode;
	LookAhead = scanner->getNextToken();
	DotNode = parseExp();
	LookAhead = scanner->getNextToken();
	if(LookAheadToken->getType() != RPAREN)
	{
	    cerr << "Parse Error: Expecting Expression following dot\n";
	    LookAheadToken = NULL;
	}
	return DotNode;
    }else
    {
	//what about the lookahead token (NextToken)? It needs to be
	//put back before we return?
	return new Cons(parseExp(), parseRest());
    }
    return NULL;
}
