// Scanner.cpp -- the implementation of class Scanner

#include <iostream.h>
#include <string.h>
#include <ctype.h>
#include "Scanner.h"

Token * 
Scanner::getNextToken() {
  char ch;  

  // It would be more efficient if we'd maintain our own input buffer
  // and read characters out of that buffer, but reading individual
  // characters from the input stream is easier.
  in->get(ch);

  // TODO: skip white space and comments (done)

  while(ch == '\t' || ch == '\n' || ch == ' ' || ch == ';' || ch == '\r' || ch == '\f')
  {
      if(ch == ';')
      {
	  while(ch != '\n' && ch != '\r')
	  {
	      if(in->eof())
		  return NULL;	      
	      in->get(ch);
	  }
	  //in->get(ch);
      }
      if(in->eof())
	  return NULL;
      in->get(ch);
  }
  
  if(in->eof())
    return NULL;

  // Special characters
  else if (ch == '\'')
    return new Token(QUOTE);
  else if (ch == '(')
    return new Token(LPAREN);
  else if (ch == ')')
    return new Token(RPAREN);
  else if (ch == '.')
  {
      in->get(ch);
      if(ch == '.')
      {
	  in->get(ch);
	  if(ch == '.')
	  {
	      buf[0] = '.'; buf[1] = '.'; buf[2] = '.';
	      return new IdentToken(buf);
	  }
	  else
	  {
	      cerr << "Illegal token \"..\"" << endl;
	      in->putback(ch);
	      return getNextToken();
	  }
      }
      else
      {
	  in->putback(ch);
	  return new Token(DOT);
      }
  }
    

  // Boolean constants
  else if (ch == '#') {
    in->get(ch);
    if (ch == 't')
      return new Token(TRUET);
    else if (ch == 'f')
      return new Token(FALSET);
    else {
      cerr << "Illegal character '" << ch << "' following #" << endl;
      return getNextToken();
    }
  }

  // String constants
  else if (ch == '"') {
      // TODO: scan a string into the buffer variable buf (done)
      in->get(ch);
      int strlen = 0;
      while(ch != '"')
      {
	  buf[strlen] = ch;
	  strlen++;
	  in->get(ch);
      }
      buf[strlen] = '\0';
      return new StrToken(buf);
  }

  // Integer constants
  else if (ch >= '0' && ch <= '9') {
    int i = ch - '0';
    // TODO: scan the number and convert it to an integer (done)
    in->get(ch);
    while(ch >= '0' && ch <= '9')
    {
	i *= 10;
	i += (ch - '0');
	in->get(ch);
    }
    // put the character after the integer back into the input
    in->putback(ch);
    return new IntToken(i);
  }

  // Identifiers
  else if ((ch >= '<' && ch <= 'Z')|| (ch >= 'a' && ch <= 'z')
	   || (ch >= '$' && ch <= '&') || (ch >= '-' && ch <= '/')
	   || ch == ':' || ch == '*' || ch == '+' || ch == '!'
	   || ch == '^' || ch == '-' || ch == '_' || ch == '~')
	   /* or ch is some other valid first character for an
	    * identifier */
  {
    // TODO: scan an identifier into the buffer
      
      //what if it's a + or - token? need to do some err checks and
      //return new IdentToken(buf)
      if(ch == '+' || ch == '-')
      {
	  char tmp_ch;
	  in->get(tmp_ch);
	  if(tmp_ch != ' ' && tmp_ch != '\t' && tmp_ch != '\n')
	  {
	      cerr << "Illegal input charater '" << tmp_ch << "' following '+' or '-'\n";
	      in->putback(tmp_ch);
	      return getNextToken();
	  }
	  buf[0] = ch;
	  buf[1] = '\0'; //NULL terminate string
	  return new IdentToken(buf);
      }
      buf[0] = tolower(ch);//need to make sure any letters are in lowecase    
      in->get(ch);
      int i = 1;
      while((ch >= '0' && ch <= '9') || (ch >= '<' && ch <= 'Z')|| (ch >= 'a' && ch <= 'z')
	    || (ch >= '$' && ch <= '&') || (ch >= '-' && ch <= '/')
	    || ch == ':' || ch == '*' || ch == '+' || ch == '!'
	    || ch == '^' || ch == '-' || ch == '_' || ch == '~') //included 0-9 this time
      {
	  buf[i] = tolower(ch);
	  i++;
	  in->get(ch);
      }
      buf[i] = '\0'; //terminate string w/ NULL
      // put the character after the identifier back into the input
      in->putback(ch);
      return new IdentToken(buf);
  }

  // Illegal character
  else {
    cerr << "Illegal input character '" << ch << '\'' << endl;
    return getNextToken();
  }
}
