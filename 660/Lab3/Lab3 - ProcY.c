// Filename: ProcY.c
// Cis 660 Lab 3

#include <stdio.h>
#include "ssem.h"
#include "sshm.h"

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	char *BufferB;
	char c1, c2;
	int bufBFilled, bufBEmpty;
	int semX, semY, semZ, CSX, CSY, CSZ;
	int shmid2;
	int temp;
	int counter, output;

	// Open semaphore bufBFilled

	bufBFilled = sem_open(500003);
	if (bufBFilled < 0)
	{
		Error(1); // Error has occurred
	}

	// Open semaphore bufBEmpty

	bufBEmpty = sem_open(500004);
	if (bufBEmpty < 0)
	{
		Error(2); // Error has occurred
	}

	// Open semaphore semX

	semX = sem_open(500005);
	if (semX < 0)
	{
		Error(3); // Error has occurred
	}

	// Open semaphore semY

	semY = sem_open(500006);
	if (semY < 0)
	{
		Error(4); // Error has occurred
	}

	// Open semaphore semZ

	semZ = sem_open(500007);
	if (semZ < 0)
	{
		Error(5); // Error has occurred
	}

	// Open semaphore CSX

	CSX = sem_open(500008);
	if (CSX < 0)
	{
		Error(1); // Error has occurred
	}

	// Open semaphore CSY

	CSY = sem_open(500009);
	if (CSY < 0)
	{
		Error(1); // Error has occurred
	}

	// Open semaphore CSZ

	CSZ = sem_open(500010);
	if (CSZ < 0)
	{
		Error(1); // Error has occurred
	}

	// Opens shared memory between two processes

	shmid2 = shm_get(900002, (void*) &BufferB, 69);

	// Initialize characters for insertion into shared memory buffer

	c1 = 'A';
	c2 = '0';

	counter = 1;
	output = 0;

	// Synchronize with ProcX and ProcZ

	temp = sem_signal(semX);
	temp = sem_signal(semZ);
	temp = sem_wait(semY);
	temp = sem_wait(semY);

	// Insert items into buffer when there is room

	while (counter <= 260)
	{
		temp = sem_wait(bufBEmpty);

		BufferB[output*3] = c1;
		BufferB[output*3+1] = c1;
		BufferB[output*3+2] = c2;

		printf(" %c%c%c ", BufferB[output*3], BufferB[output*3+1], BufferB[output*3+2]);

		temp = sem_signal(bufBFilled);

		if ((counter % 26) == 0) // Increment number if needed
		{
			c2++;
			c1 = 'A';
		}

		else // Otherwise, move to next letter in alphabet
		{
			c1++;
		}


		if ((counter % 100) == 0) // Sleep after every 100 items
		{
//			printf("-!Sleeping 2 seconds!-");
//			sleep(2);
		}


		counter++;

		// Signal the consumer to take an element

		temp = sem_signal(CSZ);
		temp = sem_wait(CSY);
	}

	// Synchronize with ProcX and ProcZ

	temp = sem_signal(semX);
	temp = sem_signal(semZ);
	temp = sem_wait(semY);
	temp = sem_wait(semY);

	printf("\nProcY: Exiting...\n");

	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	printf("\nProcY: An error has occurred.\n");
	printf("Error Code: %d\n", error_code);

	exit(-1);
}