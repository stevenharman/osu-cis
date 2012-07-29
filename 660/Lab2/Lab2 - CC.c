// CC.c //

#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>  // for LSEEK, OPEN, CREAT
#include <unistd.h>     // for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>   // for OPEN, CREAT
#include <fcntl.h>      // for OPEN, CREAT
#include <sys/wait.h>   // for WAIT
#include <signal.h>     // for KILL


///////////////////////////////////////////////////////////

void main()
{
	////////////////////
	// *** PART 3 *** //
	////////////////////

	// Enter infinite loop

	cout << "Program CC.c: Entering an infinite loop.\n\n";

	while (true)
	{ };
}

///////////////////////////////////////////////////////////
