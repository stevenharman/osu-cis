// Filename: PipeW.c
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
int main(int numarg, char *arglist[])
{
	char buffer[100];
	int fd[2];
	int counter = 1;

	int temp, bytes_read, bytes_written;

	int xx_id;


	/////////////////
	// Part B - #2 //
	/////////////////

	//printf("* Entering process B *\n");

	// Convert arguments from character back to integer

	fd[0] = atoi(arglist[0]);
	fd[1] = atoi(arglist[1]);

	close(fd[0]); // Close pipe for reading

	// Open the source file named "x.x"

	xx_id = open("x.x", 0); // Open "x.x" for reading

	if (xx_id < 0) // Error occurred
	{
		Error(2);
	}

	counter = 1;

	bytes_read = 50; // Initialize value to enter loop

	while (bytes_read == 50)
	{
		memset (buffer, 0, 100); // Clear buffer

		bytes_read = read(xx_id, &buffer, 50); // Read characters from file "x.x"

		if (bytes_read < 0) // Error occurred
		{
			Error(3);
		}

		bytes_written = write(fd[1], &buffer, 50); // Write characters into pipe

		if (bytes_written < 0) // Error occurred
		{
			Error(4);
		}
/*
		if ((counter / 500) >= 1)
		{
			sleep(2);
			counter = counter % 500;
		}
*/
		counter = counter + 50;
	}

	close(fd[1]); // Close pipe for writing




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