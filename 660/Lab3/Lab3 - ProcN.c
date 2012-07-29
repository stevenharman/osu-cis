// Filename: ProcN.c
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
	char c1, c2, c3;
	int output = 0;
	int loop_done;

	// Open semaphore bufferFilledSpaces

	bufferFilledSpaces = sem_open(155555);
	if (bufferFilledSpaces < 0)
	{
		Error(1); // Error has occurred
	}

	// Open semaphore bufferEmptySpaces

	bufferEmptySpaces = sem_open(255555);
	if (bufferEmptySpaces < 0)
	{
		Error(1); // Error has occurred
	}

	// Creates synchronization semaphores
	semM = sem_open(355555);
	if (semM < 0)
	{
		Error(1); // Error has occurred
	}

	// Creates synchronization semaphores
	semN = sem_open(455555);
	if (semN < 0)
	{
		Error(1); // Error has occurred
	}

	// Synchronization with Process M

	temp = sem_signal(semM);
	temp = sem_wait(semN);

	// Opens shared memory between two processes

	shmid = shm_get(123123, (void*) &buffer, 90);

	loop_done = 0;

	while (loop_done == 0)
	{
		temp = sem_wait(bufferFilledSpaces);

		c1 = buffer[output];
		c2 = buffer[output+1];
		c3 = buffer[output+2];

		if ((c1 == 'Z') && (c2 == '9') && (c3 == 'Z')) // Last item to take out
		{
			loop_done = 1;
		}

		printf(" %c%c%c ", c1, c2, c3);

		temp = sem_signal(bufferEmptySpaces);
	}

	// Synchronization with Process M

	temp = sem_signal(semM);
	temp = sem_wait(semN);	
	
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