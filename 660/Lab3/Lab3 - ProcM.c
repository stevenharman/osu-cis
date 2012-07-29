// Filename: ProcM.c
// Cis 660 Lab 3

#include <stdio.h>
#include "ssem.h"
#include "sshm.h"

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	int bufferFilledSpaces, bufferEmptySpaces, semM, semN;
	char *buffer;
	int temp;
	int shmid;
	char c1, c2;
	int input = 0;
	int counter;

	char *arg[1] = {0};
	int N;

	// Create duplicate process and give it code from ProcN

	N = fork();

	if (N == 0) // process is a child
	{
		execv("ProcN", arg);
	}

	// Create semaphore bufferFilledSpaces

	bufferFilledSpaces = sem_create(155555, 0);
	if (bufferFilledSpaces < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore bufferEmptySpaces

	bufferEmptySpaces = sem_create(255555, 1);
	if (bufferEmptySpaces < 0)
	{
		Error(1); // Error has occurred
	}

	// Creates synchronization semaphores
	semM = sem_create(355555, 0);
	if (semM < 0)
	{
		Error(1); // Error has occurred
	}

	// Creates synchronization semaphores
	semN = sem_create(455555, 0);
	if (semN < 0)
	{
		Error(1); // Error has occurred
	}

	// Opens shared memory between two processes

	shmid = shm_get(123123, (void*) &buffer, 90);

	// Synchronization with Process N

	temp = sem_signal(semN);
	temp = sem_wait(semM);

	// Part 1 - Fill in initial values

	c1 = 'a';
	c2 = '0';
	counter = 1;

	while (counter <= 260)
	{
		temp = sem_wait(bufferEmptySpaces);

		buffer[input] = c1;
		buffer[input+1] = c2;
		buffer[input+2] = c1;

//Debug
//printf("# %c%c%c #", c1, c2, c1);

		if ((counter % 26) == 0) // Increment number if needed
		{
			c2++;
			c1 = 'a';
		}

		else // Otherwise, move to next letter in alphabet
		{
			c1++;
		}

		counter++;

		temp = sem_signal(bufferFilledSpaces);
	}

	// Part 2 - Fill in initial values

	c1 = 'A';
	c2 = '0';
	counter = 1;

	while (counter <= 260)
	{
		temp = sem_wait(bufferEmptySpaces);

		buffer[input] = c1;
		buffer[input+1] = c2;
		buffer[input+2] = c1;

//Debug
//printf("# %c%c%c #", c1, c2, c1);

		if ((counter % 26) == 0) // Increment number if needed
		{
			c2++;
			c1 = 'A';
		}

		else // Otherwise, move to next letter in alphabet
		{
			c1++;
		}

		counter++;

		temp = sem_signal(bufferFilledSpaces);
	}

	// Synchronization with Process N

	temp = sem_signal(semN);
	temp = sem_wait(semM);

	// Remove semaphores
	
	temp = sem_rm(bufferEmptySpaces);
	temp = sem_rm(bufferFilledSpaces);
	temp = sem_rm(semM);
	temp = sem_rm(semN);

	// Remove shared memory

	temp = shm_rm(shmid);

	printf("\n");
	
	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	if (error_code == 1)
	{
		printf("An error has occurred during the creation of a semaphore.");
	}

	else
	{
		printf("An error has occurred.");
	}

	exit(-1);
}