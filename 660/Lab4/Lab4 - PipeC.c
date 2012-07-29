// Filename: PipeC.c
// Cis 660 Lab 4 / Part B

#include <stdio.h>
#include <unistd.h>

#include <stdlib.h>
#include <string.h>
#include <sys/types.h>    // for LSEEK, OPEN, CREAT
#include <unistd.h>       // for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>     // for OPEN, CREAT
#include <fcntl.h>        // for OPEN, CREAT
#include <signal.h>       // for KILL

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	char read_arg[5];
	char write_arg[5];
	char *arg[3] = {0,0,0};
	int fd[2];
	int B, C, X;
	int return_code;
	int temp;

	printf("\n");

	/////////////////
	// Part B - #1 //
	/////////////////

	// Create pipe

	temp = pipe(fd);

	if (temp < 0)
	{
		Error(1);
	}

	// Convert arguements from integer to character

	sprintf(read_arg, "%d", fd[0]);
	sprintf(write_arg, "%d", fd[1]);

	arg[0] = &read_arg[0];
	arg[1] = &write_arg[0];

	// Create process that will execute code from 'PipeW'

	B = fork();

	if (B == 0) // only for child process -> process B
	{
		execv("PipeW", arg);
	}

	// Create process that will execute code from 'PipeR'

	C = fork();

	if (C == 0) // only for child process -> process C
	{
		execv("PipeR", arg);
	}

	// Close both read and write ends of pipe since process A doesn't need them

	close(fd[0]);
	close(fd[1]);

	// Wait for process B and process C to terminate

	X = wait(&return_code); // X is the id of the child process that terminated
	X = wait(&return_code); // X is the id of the child process that terminated

	printf("\n\n");

	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	if (error_code == 1)
	{
		printf("An error has occurred during the creation of a pipe.");
	}

	else if (error_code == 2)
	{
		printf("An error has occurred during the opening of a file.");
	}

	else if (error_code == 3)
	{
		printf("An error has occurred during the reading of a file.");
	}

	else if (error_code == 4)
	{
		printf("An error has occurred during the writing to a pipe.");
	}

	else if (error_code == 5)
	{
		printf("An error has occurred during the termination of a process.");
	}

	else if (error_code == 6)
	{
		printf("An error has occurred during the reading from a pipe.");
	}

	else
	{
		printf("An error has occurred.");
	}

	exit(-1);
}