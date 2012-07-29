// Filename: PipeRW.c
// Cis 660 Lab 4 / Part A

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
	char *arg[1] = {0};
	char buffer[100];
	int fd[2];
	int B;
	int counter = 1;

	int temp, bytes_read, bytes_written, kl_err;

	int xx_id;

	printf("\n");

	/////////////////
	// Part A - #1 //
	/////////////////

	// Create pipe

	temp = pipe(fd);
	if (temp < 0)
	{
		Error(1);
	}

	// Create duplicate process that will execute parent's code

	B = fork();

	if (B == 0) // only for child process -> process B
	{
		// Child process closes up input side of pipe
		close(fd[0]);
	}

	else
	{
		// Parent process closes up output side of pipe
		close(fd[1]);
	}


	/////////////////
	// Part A - #2 //
	/////////////////

	if (B == 0) // only for child process -> process B
	{
		//printf("* Entering child section *\n");

		// Open the source file named "x.x"

		xx_id = open("x.x", 0); // Open "x.x" for reading

		if (xx_id < 0) // Error occurred
		{
			Error(2);
		}

		bytes_read = 100; // Initialize value to enter loop

		while (bytes_read == 100)
		{
			//printf("\n* Entering child loop *");

			memset (buffer, 0, 100); // Clear buffer

			bytes_read = read(xx_id, &buffer, 100); // Read characters from file "x.x"
			if (bytes_read < 0) // Error occurred
			{
				Error(3);
			}

			bytes_written = write(fd[1], &buffer, 100); // Write characters into pipe
			if (bytes_written < 0) // Error occurred
			{
				Error(4);
			}
		}

		close(fd[1]); // Close pipe for writing
	}


	/////////////////
	// Part A - #3 //
	/////////////////

	else // only for parent process -> process A
	{
		//printf("* Entering parent section *\n");

		counter = 1; // Initialize counter variable

		bytes_read = 80; // Initialize value to enter loop

		while (bytes_read == 80)
		{
			memset (buffer, 0, 100); // Clear buffer

			bytes_read = read(fd[0], &buffer, 80); // Read characters from pipe
			if (bytes_read < 0) // Error occurred
			{
				Error(6);
			}

			printf("%s", buffer); // Print out characters just read from pipe
			printf("\n");

			if ((counter / 1000) >= 1)
			{
				sleep(1); // After reading each 1000 characters, wait for 1 second
				counter = counter % 1000;
			}

			counter = counter + 80;
		}

		close(fd[0]); // Close pipe for reading

		printf("\n\n");
	}





//	printf("\n\nPipeRW has finished execution.\n\n");

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