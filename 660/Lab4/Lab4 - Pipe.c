// Filename: Pipe.c
// Cis 660 Lab 4 / Part C

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
	int B, C, X;
	int return_code;
	int fd[2];
	int count, temp, n;
	char ch;
	char *arg[1] = {0};
	char full_command_1[50];
	char full_command_2[50];
	char p1_cmnd[40];
	char p2_cmnd[40];
	char p1_arg[20] = {0};
	char p2_arg[20] = {0};

	////////////
	// Part C //
	////////////

	// Print out shall-prompt onto screen

	printf("\nshall_prompt> ");

	// Get first Unix command and put it in 'p1_cmnd'

	ch = getchar();

	while (ch == ' ') // Get rid of whitespaces
	{
		ch = getchar();

		//printf("*$*\n");
	}

	n = 0;

	while ((ch != '\n') && (ch != ' ') && (ch != '|')) // Grab command only
	{
		p1_cmnd[n] = ch;
		n++;
		ch = getchar();
	}

	p1_cmnd[n] = '\0';

	while (ch == ' ') // Get rid of whitespaces
	{
		ch = getchar();

		//printf("*$*\n");
	}

	n = 0;
	
	while ((ch != '\n') && (ch != '|')) // Grab argument only
	{
		p1_arg[n] = ch;
		n++;
		ch = getchar();
	}

	p1_arg[n] = '\0';

	// Get second Unix command and put it in 'p2_cmnd'

	ch = getchar();

	while (ch == ' ') // Get rid of whitespaces
	{
		ch = getchar();

		//printf("*$*\n");
	}

	n = 0;

	while ((ch != '\n') && (ch != ' ') && (ch != '|')) // Grab command only
	{
		p2_cmnd[n] = ch;
		n++;
		ch = getchar();
	}

	p2_cmnd[n] = '\0';

	while (ch == ' ') // Get rid of whitespaces
	{
		ch = getchar();

		//printf("*$*\n");
	}

	n = 0;
	
	while ((ch != '\n') && (ch != '|')) // Grab argument only
	{
		p2_arg[n] = ch;
		n++;
		ch = getchar();
	}

	p2_arg[n] = '\0';

	//printf("COMMAND1: +%s+\n", p1_cmnd);
	//printf("COMMAND2: +%s+\n", p2_cmnd);

	// Initialize the commands

	full_command_1[0] = '\0';
	full_command_2[0] = '\0';

	// Concatenate the commands into the full command line

	strcat(full_command_1, "/bin/");
	strcat(full_command_1, p1_cmnd);

	strcat(full_command_2, "/bin/");
	strcat(full_command_2, p2_cmnd);

	// Create pipe

	temp = pipe(fd);

	if (temp < 0)
	{
		Error(1);
	}

	// Create process that will execute code from first Unix command

	B = fork();

	if (B == 0) // only for child process -> process B
	{
		// Change output from screen - redirect output

		temp = dup2(fd[1], 1);

		if (temp < 0)
		{
			Error(8);
		}

		// Close the read end of the pipe

		temp = close(fd[0]);

		if (temp < 0)
		{
			Error(7);
		}

		// Close the write end of the pipe

		temp = close(fd[1]);

		if (temp < 0)
		{
			Error(7);
		}

		// Execute first Unix command

		// execv(full_command_1, arg);

		//printf("Full Command: *%s*\nCmnd: *%s*\nArg: *%s*\n", full_command_1, p1_cmnd, p1_arg);

		if ((p1_arg[0] != '\0') && (p1_arg[0] != ' '))
		{
			execlp(full_command_1, p1_cmnd, p1_arg, NULL);
		}

		else
		{
			execlp(full_command_1, p1_cmnd, NULL);
		}
	}

	// Close the write end of the pipe

	temp = close(fd[1]);

	if (temp < 0)
	{
		Error(7);
	}

	// Create process that will execute code from second Unix command

	C = fork();

	if (C == 0) // only for child process -> process C
	{
		// Change input from keyboard - redirect input

		temp = dup2(fd[0], 0);

		if (temp < 0)
		{
			Error(8);
		}

		// Close the read end of the pipe

		temp = close(fd[0]);

		if (temp < 0)
		{
			Error(7);
		}

		// Execute second Unix command

		// execv(full_command_2, arg);

		//printf("Full Command: *%s*\nCmnd: *%s*\nArg: *%s*\n", full_command_2, p2_cmnd, p2_arg);

		if ((p2_arg[0] != '\0') && (p2_arg[0] != ' '))
		{
			execlp(full_command_2, p2_cmnd, p2_arg, NULL);
		}

		else
		{
			execlp(full_command_2, p2_cmnd, NULL);
		}

	}

	// Close the read end of the pipe

	temp = close(fd[0]);

	if (temp < 0)
	{
		Error(7);
	}

	// Wait for process B and process C to terminate

	X = wait(&return_code);
	X = wait(&return_code);



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

	else if (error_code == 7)
	{
		printf("An error has occurred during the closing of a pipe.");
	}

	else if (error_code == 8)
	{
		printf("An error has occurred while redirecting the output.");
	}

	else
	{
		printf("An error has occurred.");
	}

	printf("\n");

	exit(-1);
}