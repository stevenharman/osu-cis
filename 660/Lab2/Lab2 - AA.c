// AA.c //


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
	int B, C1, C2, D, X; // Process Identifiers
	int return_code, kl_err;
	char *arg[1] = {0};
	bool d_terminated;


	////////////////////
	// *** PART 1 *** //
	////////////////////

	cout << "Program AA.c: Creating processes from files BB.c and CC.c, and waiting for\n"
		 << "              one to terminate.\n\n";

	// Create duplicate process B and get code from BB.c

	B = fork();

	if (B == 0) // process is a child
	{
		execv("BB", arg);
	}

	// Create duplicate process C1 and get code from CC.c

	C1 = fork();

	if (C1 == 0) // process is a child
	{
		execv("CC", arg);
	}

	// Process A waits for either process B or process C1 to terminate

	X = wait(&return_code); // X is the identifier of the child process that terminated


	////////////////////
	// *** PART 4 *** //
	////////////////////

	cout << "Program AA.c: Creating processes from files DD.c and CC.c, and waiting for\n"
		 << "              the process from file DD.c to terminate.\n\n";

	// Create duplicate process D and get code from DD.c

	D = fork();

	if (D == 0) // process is a child
	{
		execv("DD", arg);
	}

	// Create duplicate process C2 and get code from CC.c

	C2 = fork();

	if (C2 == 0) // process is a child
	{
		execv("CC", arg);
	}

	// Wait until process D is terminated

	X = wait(&return_code); // X is the identifier of the child process that terminated

	cout << "Program AA.c: Process with ID = " << X << " has terminated\n\n";

	if (X == D) // D is the process that terminated
	{
		d_terminated = true;
	}
	else // D was not the process that terminated
	{
		d_terminated = false;
	}

	while (d_terminated == false) // Keep waiting until D terminates
	{
		X = wait(&return_code); // X is the identifier of the child process that terminated

		cout << "Program AA.c: Process with ID = " << X << " has terminated\n\n";

		if (X == D) // D is the process that terminated
		{
			d_terminated = true;
		}
		else // D was not the process that terminated
		{
			d_terminated = false;
		}
	}


	/////////////////////
	// *** PART 10 *** //
	/////////////////////

	// Kill the C1 process

	kl_err = kill(C1, SIGKILL); // 'SIGKILL' signal used to kill process

	if (kl_err < 0)
	{
		Error(KILL_ERROR);
	}

	cout << "Program AA.c: Process C1 killed\n\n";

	// Kill the C2 process

	kl_err = kill(C2, SIGKILL); // 'SIGKILL' signal used to kill process

	if (kl_err < 0)
	{
		Error(KILL_ERROR);
	}

	cout << "Program AA.c: Process C2 killed\n\n";

	// Terminate process

	cout << "Program AA.c: Process terminated\n\n";
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