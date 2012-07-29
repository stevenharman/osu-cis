// Filename: PipeR.c
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



	/////////////////
	// Part B - #3 //
	/////////////////

	//printf("* Entering process C *\n");

	// Convert arguments from character back to integer

	fd[0] = atoi(arglist[0]);
	fd[1] = atoi(arglist[1]);

	close(fd[1]); // Close pipe for writing

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

		// Change numbers in the buffer into characters

		temp = 0;

		while (temp < bytes_read)
		{
			if (buffer[temp] == '1')
			{
				buffer[temp] = 'A';
			}

			else if (buffer[temp] == '2')
			{
				buffer[temp] = 'B';
			}

			else if (buffer[temp] == '3')
			{
				buffer[temp] = 'C';
			}

			else if (buffer[temp] == '4')
			{
				buffer[temp] = 'D';
			}

			else if (buffer[temp] == '5')
			{
				buffer[temp] = 'E';
			}

			else if (buffer[temp] == '6')
			{
				buffer[temp] = 'F';
			}

			else if (buffer[temp] == '7')
			{
				buffer[temp] = 'G';
			}

			else if (buffer[temp] == '8')
			{
				buffer[temp] = 'H';
			}

			else if (buffer[temp] == '9')
			{
				buffer[temp] = 'I';
			}

			else if (buffer[temp] == '0')
			{
				buffer[temp] = 'J';
			}

			temp++;
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