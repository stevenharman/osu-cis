//  /*----------------------------------------------------------------*\
//  |   Main Program: DUML-to-HTML Converter
//  |*----------------------------------------------------------------*|
//  |   Date:    8 October 2001
//  |   Author:  Steve Harman
//  |   
//  |   Brief User's Manual:
//  |   Reads Dewey, Cheetham, and Howe's DUML file from stdin,
//  |   marks it up with HTML tags so it looks good when viewed
//  |   in a browser, and outputs the marked-up version to
//  |   stdout.  A list of DCH login names is in addresses.txt.
//  |   
//  \*----------------------------------------------------------------*/

///---------------------------------------------------------------------
/// Global Context -----------------------------------------------------
///---------------------------------------------------------------------

#include "RESOLVE_Foundation.h"

#include "CT/Set/Kernel_1a_C_Body.h"

///---------------------------------------------------------------------
/// Interface ----------------------------------------------------------
///---------------------------------------------------------------------

/*!
    math operation LINES (
	    s: string of character
	): string of string of character
	implicit definition
	    if s = empty_string
	    then LINES(s) = empty_string
	    else if "\n" is not substring of s
	    then LINES(s) = <s>
	    else there exists a, b: string of character
		     (s = a * "\n" * b  and
		      "\n" is not substring of a  and
		      LINES(s) = <a> * LINES(b))

    math operation SEPARATORS: set of character
        explicit definition
	    {' ', '\t', '\n'}
	    
    math operation IS_WORD (
	    s: string of character
	): boolean
        explicit definition
            s /= empty_string  and
            elements(s) intersect SEPARATORS = empty_set

    math operation CONTAINS_WORD (
	    s: string of character
	): boolean
	explicit definition
	    there exists w: string of character
	        (w is substring of s  and
		 IS_WORD(w))

    math operation TO_HTML (
	    s: string of character
	): string of character
	explicit definition
	   [string obtained by replacing DUML tags of s with HTML tags]
!*/

//----------------------------------------------------------------------
//----------------------------------------------------------------------

// Concrete instances

concrete_instance
class Set_Of_Text :
    instantiates
	Set_Kernel_1a_C <Text>
{};

//----------------------------------------------------------------------
//----------------------------------------------------------------------

// Global operations

global_procedure Get_Lines_From_Input (
	alters Character_IStream& input,
	produces Set_Of_Text& s
    );
    /*!
	requires
	    input.is_open = true
        ensures
	    input.is_open = true  and
	    input.ext_name = #input.ext_name  and
	    input.content = empty_string  and
	    s = elements (LINES (#input.content))
    !*/
    
//----------------------------------------------------------------------

global_procedure Remove_First_Word (
        alters Text& t,
        produces Text& w
    );
    /*!
	requires
	    there exists c: character
	        (<c> is suffix of t  and
		 c is in SEPARATORS)
        ensures
            if CONTAINS_WORD(#t) then
	        there exists a: string of character, c: character
		    (#t = a * w * <c> * t  and
		     elements(a) is subset of SEPARATORS  and
		     IS_WORD(w)  and
		     c is in SEPARATORS)
	    else
	        (w = empty_string  and
		 t = empty_string)
    !*/
    
//----------------------------------------------------------------------
//----------------------------------------------------------------------

// Global operation bodies

procedure_body Get_Lines_From_Input (
	alters Character_IStream& input,
	produces Set_Of_Text& s
    )
{
     object Text t;

    s.Clear();

    //bring in the next line from the file and check to see if it is
    //already in the set, if not, add it to the set
    while (not input.At_EOS())
    {
	input >> t;

	if (not s.Is_Member(t))
	{
	    s.Add(t);
	}
    }
}

//----------------------------------------------------------------------

procedure_body Remove_First_Word (
        alters Text& t,
        produces Text& w
    )
{
    object Character ch;
    w.Clear ();

	t.Remove (0,ch);

	//check for new-line, tab, or space characters in t and get
	//rid of any that exist, and get next character from w
	while ((t.Length ()>0) and  ((ch == '\n') or (ch == '\t') or (ch == ' ')))
	{
	    t.Remove (0,ch);
	}

	//check for non-special characters, and add them to w, then
	//remove the next character from t
	while ((t.Length ()>0) and (ch != '\n') and (ch != '\t') and (ch != ' '))
	{
	    w.Add (w.Length(),ch);
	    t.Remove (0,ch);
	}
}    

//----------------------------------------------------------------------
//----------------------------------------------------------------------

procedure_body main ()
{
    object Character_IStream input;
    object Character_OStream output;
    object Set_Of_Text addresses;
    object Integer state;

    // Finite state machine states
    
    enumeration Environment_State
    {
	in_nothing,
	in_italics,
	in_boldface,
	in_heading,
	in_address
    };
    
    // Get login names (a.k.a. e-mail addresses) from file

    input.Open_External ("addresses.txt");
    Get_Lines_From_Input (input, addresses);
    input.Close_External ();
    
    // Open input and output streams
    
    input.Open_External ("");
    output.Open_External ("");

    // Output prologue

    output << "<HTML>\n<BODY BGCOLOR=WHITE>\n";

    // Process input one line at a time, marking up as needed

    state = in_nothing;
    while (not input.At_EOS ())
        /*!
            alters input, out
            requires
                input.is_open = true  and
                output.is_open = true
            ensures
                input.is_open = true  and
                input.ext_name = #input.ext_name  and
                input.content = empty_string  and
                output.is_open = true  and
                output.ext_name = #output.ext_name  and
                output.content =
                    #output.content * TO_HTML(#input.content))
        !*/
    {
	object Text line, word;
	object Character fch, lch,junk,junk2;
	object Integer len;

	// Read line and replace newline that terminated it
	
	input >> line;
	line.Add (line.Length (), '\n');


	//-------- for students to fill in --------

	while(line.Length() > 0)
	{
	    Remove_First_Word(line, word);
	    len = word.Length();
	    fch = word[0];
	    lch = word[word.Length()-1];
	
	    case_select (state)
	    {
	    case in_nothing:
	    {
		    
		if(len >= 2)
		{
		    //if statement to take care of changing to italics
		    if(fch == '*')
		    {
			state = in_italics;
			word.Remove(0,junk);
			output << "<i>";

			if(lch == '*')
			{
			    state = in_nothing;
			    word.Remove(word.Length()-1,junk);
			    output << word << "</i> ";
			}
			else
			{
			    output << word << " ";
			}
			break;
		    }
		    
		

		    //if statement to take care of changing to boldface
		    else if(fch == '^')
		    {
			state = in_boldface;
			word.Remove(0,junk);
			output << "<b>";

			if(lch == '^')
			{
			    state = in_nothing;
			    word.Remove(word.Length()-1,junk);
			    output << word << "</b> ";
			}
			else
			{
			    output << word << " ";
			}
			break;
		    }
		    

		    //if statement to take care of changing to heading
		    else if(fch == '=')
		    {
			state = in_heading;
			word.Remove(0,junk);
			output << word << "<h2>";

			if(lch == '=')
			{
			    state = in_nothing;
			    word.Remove(word.Length()-1,junk);
			    output << word << "</h2> ";
			}
			else
			{
			    output << word << " ";
			}
			break;
		    }
		   

		    //if statement to check if a word is a username
		    //used for email, and mark it up if it is
		    else if(fch == '(')
		    {
			if(lch == ')')
			{
			    word.Remove(word.Length()-1,junk2);
			    word.Remove(0,junk);

			    if(addresses.Is_Member(word))
			    {
				output << "<a href=\"mailto:" << word << "@cartalk.com\">" << "(" << word << ")" << "</a> ";
			    }
			    else
			    {
				output << "(" << word << ") ";
			    }
			}
			else
			{
			    output << word << " ";
			}
			break;
		    }
		  
		}
		else
		{
		    output << word << " ";
		}
	    }
	    break;

	    case in_italics:
	    {
		if(len >= 2)
		{
		    if(lch == '*')
		    {
			state = in_nothing;
			word.Remove(word.Length()-1,junk);
			output << word << "</i> ";
		    }
		    else
		    {
			output << word << " ";
		    }
		}
		else
		{
		    output << word << " ";
		}
	    }
	    break;

	    case in_boldface:
	    {
		if(len >= 2)
		{
		    if(lch == '^')
		    {
			state = in_nothing;
			word.Remove(word.Length()-1,junk);
			output << word << "</b> ";
		    }
		    else
		    {
			output << word << " ";
		    }
		    
		}
		else
		{
		    output << word << " ";
		}
	    }
	    break;

	    case in_heading:
	    {
		if(len >= 2)
		{
		    if(lch == '=')
		    {
		        state = in_nothing;
		        word.Remove(word.Length()-1,junk);
		        output << word << "</h2> ";
		    }
		    else
		    {
		        output << word << " ";
		    }
		}
	        else
		{
		    output << word << " ";
		}
	    }
	    break;
	}
    }
    }
    // while (not input.At_EOS ())

    // Output epilogue

    output << "</BODY>\n</HTML>\n";

    // Close input and output streams
    
    input.Close_External ();
    output.Close_External ();
}

