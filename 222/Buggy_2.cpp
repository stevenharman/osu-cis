//  /*--------------------------------------------------------*\
//  |   Main Program: Simple tester for Text Swap_Substring
//  |*--------------------------------------------------------*|
//  |   Date:         3 November 1997
//  |   Author:       Paolo Bucci
//  |   
//  |   Brief User's Manual:
//  |   Allows user either to exercise the Swap_Substring
//  |   operation in either an interactive menu-driven mode or
//  |   in a batch file mode (using input redirection).
//  |   
//  \*--------------------------------------------------------*/


///-------------------------------------------------------------
/// Global Context ---------------------------------------------
///-------------------------------------------------------------

#include "RESOLVE_Foundation.h"


///-------------------------------------------------------------
/// Interface --------------------------------------------------
///-------------------------------------------------------------

global_procedure Swap_Substring (
	alters Text& t1,
	preserves Integer pos,
	preserves Integer len,
	alters Text& t2
    );
    /*!
	requires
	    0 <= pos <= pos + length <= |t1|
	ensures
	    there exists a, b: string of character
	        (#t1 = a * t2 * b  and
		 |a| = pos  and
		 |t2| = len  and
		 t1 = a * #t2 * b)
    !*/

//--------------------------------------------------------------

procedure_body Swap_Substring (
	alters Text& t1,
	preserves Integer pos,
	preserves Integer len,
	alters Text& t2
    )
{
    object Integer index = pos + len - 1;
    object Text tmp;


    while (index >= pos)
    {
	//debug ("while1: index: " << index << " pos: " << pos << " t1: "<< t1 << " t2= " << t2 << "\n");
	object Character c;

	t1.Remove (index, c);
	tmp.Add (0, c);
	index--;
    }

    index = t2.Length () - 1;
    while (index >= 0)
    {
	//debug ("while2: index: "<< index << " pos: " << pos << " t1: " << t1 << " t2: " << t2 <<"\n");
	object Character c;

	t2.Remove (index, c);
	t1.Add (pos, c);
	index--;
    }

    t2 &= tmp;

}


//--------------------------------------------------------------
//--------------------------------------------------------------

procedure_body main ()
{
    object Character_IStream ins;
    object Character_OStream outs;
    object Text response;
    object Boolean interactive_mode;
    object Text t1, t2;
    object Integer pos, len;

    // Open input and output streams
    
    ins.Open_External ("");
    outs.Open_External ("");

    // Ask user about interactive mode
    
    outs << "Run in interactive mode (y/n)? ";
    ins >> response;
    interactive_mode = (response == "y");
    outs << "\n";

    // Ask user for whether to test

    if (interactive_mode)
    {
	outs << "Start testing (y/n)? ";
    }
    ins >> response;

    // Execute interactive testing loop until finished

    while (response != "n")
    {
	if (response != "y")
	{
	    outs << response << "\n";
	}
	else
	{
	    // Get values for t1, pos, len, and t2 for this test case
	
	    if (interactive_mode)
	    {
		outs << "\nt1 = ";
	    }
	    ins >> t1;

	    if (interactive_mode)
	    {
		outs << "pos = ";
	    }
	    ins >> pos;

	    if (interactive_mode)
	    {
		outs << "len = ";
	    }
	    ins >> len;

	    if (interactive_mode)
	    {
		outs << "t2 = ";
	    }
	    ins >> t2;

	    // Report results of this test case
	
	    outs << "-------------------------------------------------\n"
		 << "                       |  t1  = \"" << t1 << "\"\n"
		 << "                       |  pos = " << pos << '\n'
		 << "                       |  len = " << len << '\n'
		 << "                       |  t2  = \"" << t2 << "\"\n"
		 << "-------------------------------------------------\n";
	    Swap_Substring (t1, pos, len, t2);
	    outs << "Swap_Substring (t1, pos, len, t2);  |\n"
		 << "-------------------------------------------------\n"
		 << "                       |  t1  = \"" << t1 << "\"\n"
		 << "                       |  pos = " << pos << '\n'
		 << "                       |  len = " << len << '\n'
		 << "                       |  t2  = \"" << t2 << "\"\n"
		 << "-------------------------------------------------\n";
	}
	
	// Determine whether to continue testing
	
	if (interactive_mode)
	{
	    outs << "\nContinue testing (y/n)? ";
	}
	ins >> response;
    }

    // Close input and output streams
    
    ins.Close_External ();
    outs.Close_External ();
}
