// Filename: ProcX.c
// Cis 660 Lab 3

#include <stdio.h>
#include "ssem.h"
#include "sshm.h"

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	char *BufferA;
	char c1, c2;
	int bufAFilled, bufAEmpty;
	int semX, semY, semZ, CSX, CSY, CSZ;
	int shmid1;
	int temp;
	int counter, output;

	// Open semaphore bufAFilled

	bufAFilled = sem_open(500001);
	if (bufAFilled < 0)
	{
		Error(1); // Error has occurred
	}

	// Open semaphore bufAEmpty

	bufAEmpty = sem_open(500002);
	if (bufAEmpty < 0)
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

	shmid1 = shm_get(900001, (void*) &BufferA, 22);

	// Initialize characters for insertion into shared memory buffer

	c1 = 'a';
	c2 = '0';

	counter = 1;
	output = 0;

	// Synchronize with ProcY and ProcZ

	temp = sem_signal(semY);
	temp = sem_signal(semZ);
	temp = sem_wait(semX);
	temp = sem_wait(semX);

	// Insert items into buffer when there is room

	while (counter <= 260)
	{
		temp = sem_wait(bufAEmpty);

		BufferA[output*2] = c1;
		BufferA[output*2+1] = c2;

		printf(" %c%c ", BufferA[output*2], BufferA[output*2+1]);

		temp = sem_signal(bufAFilled);

		if ((counter % 26) == 0) // Increment number if needed
		{
			c2++;
			c1 = 'a';
		}

		else // Otherwise, move to next letter in alphabet
		{
			c1++;
		}


		if ((counter % 50) == 0) // Sleep after every 50 items
		{
//			printf("-!Sleeping 1 second!-");
//			sleep(1);
		}

		counter++;

		// Signal the consumer to take an element

		temp = sem_signal(CSZ);
		temp = sem_wait(CSX);
	}

	// Synchronize with ProcY and ProcZ

	temp = sem_signal(semY);
	temp = sem_signal(semZ);
	temp = sem_wait(semX);
	temp = sem_wait(semX);

	printf("\nProcX: Exiting...\n");

	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	printf("\nProcX: An error has occurred.\n");
	printf("Error Code: %d\n", error_code);


	exit(-1);
}