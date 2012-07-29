// DD.c //

#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>  // for LSEEK, OPEN, CREAT
#include <unistd.h>     // for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>   // for OPEN, CREAT
#include <fcntl.h>      // for OPEN, CREAT
#include <sys/wait.h>   // for WAIT
#include <signal.h>     // for KILL


const int OPEN_ERROR		= 1;
const int LSEEK_ERROR		= 2;
const int READ_ERROR		= 3;
const int CREATE_ERROR		= 4;
const int WRITE_ERROR		= 5;
const int KILL_ERROR		= 6;


void Error(int error_type);

///////////////////////////////////////////////////////////

void main()
{
	int C3, EE, X, LS, PS; // Process Identifiers
	int return_code, kl_err;
	char *arg[1] = {0};

	////////////////////
	// *** PART 5 *** //
	////////////////////

	cout << "Program DD.c: Creating processes from files CC.c and EE.c, and waiting for\n"
		 << "              four seconds.\n\n";

	// Create duplicate process C3 and get code from CC.c

	C3 = fork();

	if (C3 == 0) // process is a child
	{
		execv("CC", arg);
	}

	// Create duplicate process EE and get code from EE.c

	EE = fork();

	if (EE == 0) // process is a child
	{
		execv("EE", arg);
	}

	// Sleep for four seconds

	sleep(4);


	////////////////////
	// *** PART 7 *** //
	////////////////////

	cout << "Program DD.c: Creating process that executes the Unix command: ls, then waits\n"
		 << "              for 5 seconds.\n\n";

	// Creates another process that executes the Unix command: 'ls'

	LS = fork();

	if (LS == 0) // process is a child
	{
		execlp("/bin/ls", "ls", NULL);
	}

	// Sleep for five seconds

	sleep(5);


	////////////////////
	// *** PART 8 *** //
	////////////////////

	cout << "Program DD.c: Creating process that executes the Unix command: 'ps -u wolfm'.\n\n";

	// Creates another process that executes the Unix command: 'ps -u wolfm'

	PS = fork();

	if (PS == 0) // process is a child
	{
		execlp("/bin/ps", "ps -u wolfm", NULL);
	}


	////////////////////
	// *** PART 9 *** //
	////////////////////

	cout << "Program DD.c: Waiting for three of four children to terminate, then killing\n"
		 << "              fourth child.\n\n";

	// Wait until three processes have terminated

	X = wait(&return_code); // X is the identifier of the child process that terminated

	cout << "Program DD.c: Process with ID = " << X << " has terminated\n\n";

	X = wait(&return_code); // X is the identifier of the child process that terminated

	cout << "Program DD.c: Process with ID = " << X << " has terminated\n\n";

	X = wait(&return_code); // X is the identifier of the child process that terminated

	cout << "Program DD.c: Process with ID = " << X << " has terminated\n\n";

	// Kill the C3 process

	kl_err = kill(C3, SIGKILL); // 'SIGKILL' signal used to kill process

	if (kl_err < 0)
	{
		Error(KILL_ERROR);
	}

	cout << "Program DD.c: Process C3 killed\n\n";

	// Terminate process

	cout << "Program DD.c: Process terminated\n\n";
}

///////////////////////////////////////////////////////////

void Error(int error_type)
{

	if (error_type == OPEN_ERROR)
	{
		cout << "An error occurred during the opening of a file.";
	}

	else if (error_type == LSEEK_ERROR)
	{
		cout << "An error occurred during an lseek command.";
	}

	else if (error_type == READ_ERROR)
	{
		cout << "An error occurred during the reading of a file.";
	}

	else if (error_type == CREATE_ERROR)
	{
		cout << "An error occurred during creation of a file.";
	}

	else if (error_type == WRITE_ERROR)
	{
		cout << "An error occurred during writing of data into a file.";
	}

	else if (error_type = KILL_ERROR)
	{
		cout << "An error occurred while killing a process.";
	}


	cout << "\n\n";
	exit(-1);
}