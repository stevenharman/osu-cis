// Filename: ProcZ.c
// Cis 660 Lab 3

#include <stdio.h>
#include "ssem.h"
#include "sshm.h"

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	int *BufferA;
	int *BufferB;
	char c1, c2, c3;
	int bufAFilled, bufAEmpty, bufBFilled, bufBEmpty;
	int semX, semY, semZ, CSX, CSY, CSZ;
	int pX, pY;
	char *arg[1] = {0};
	int shmid1, shmid2;
	int temp, loop_finished, counter, input;

	// Create semaphore bufAFilled

	bufAFilled = sem_create(500001, 0);
	if (bufAFilled < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore bufAEmpty

	bufAEmpty = sem_create(500002, 11);
	if (bufAEmpty < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore bufBFilled

	bufBFilled = sem_create(500003, 0);
	if (bufBFilled < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore bufBEmpty

	bufBEmpty = sem_create(500004, 23);
	if (bufBEmpty < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore semX

	semX = sem_create(500005, 0);
	if (semX < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore semY

	semY = sem_create(500006, 0);
	if (semY < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore semZ

	semZ = sem_create(500007, 0);
	if (semZ < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore CSX

	CSX = sem_create(500008, 0);
	if (CSX < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore CSY

	CSY = sem_create(500009, 0);
	if (CSY < 0)
	{
		Error(1); // Error has occurred
	}

	// Create semaphore CSZ

	CSZ = sem_create(500010, 0);
	if (CSZ < 0)
	{
		Error(1); // Error has occurred
	}

	// Opens shared memory between two processes

	shmid1 = shm_get(900001, (void*) &BufferA, 22);

	// Opens shared memory between two processes

	shmid2 = shm_get(900002, (void*) &BufferB, 69);


	// Create duplicate processes and give them code for processes X and Y

	pX = fork();

	if (pX == 0) // process is a child
	{
		execv("ProcX", arg);
	}

	pY = fork();

	if (pY == 0) // process is a child
	{
		execv("ProcY", arg);
	}


	// Synchronize with ProcX and ProcY

	temp = sem_signal(semX);
	temp = sem_signal(semY);
	temp = sem_wait(semZ);
	temp = sem_wait(semZ);


	// Take out items from buffers when elements exist

	counter = 1;
	input = 0;

	while (counter <= 260)
	{
		// Wait until both of the buffers have been filled

		temp = sem_wait(CSZ);
		temp = sem_wait(CSZ);

		// Remove one item from BufferA when one exists

		temp = sem_wait(bufAFilled);

		c1 = BufferA[input*2];
		c2 = BufferA[input*2+1];

		printf("+ %c%c +", c1, c2);

		temp = sem_signal(bufAEmpty);

		// Remove one item from BufferB when one exists

		temp = sem_wait(bufBFilled);

		c1 = BufferB[input*3];
		c2 = BufferB[input*3+1];
		c3 = BufferB[input*3+2];

		printf("+ %c%c%c +", c1, c2, c3);

		temp = sem_signal(bufBEmpty);

		if ((counter % 160) == 0) // Sleep after taking every 160 items
		{
//			printf("-!Sleeping 3 seconds!-");
//			sleep(3);
		}

		counter++;

		// Signal the commencement of the filling both the buffers

		temp = sem_signal(CSX);
		temp = sem_signal(CSY);
	}

	// Synchronize with ProcX and ProcY

	temp = sem_signal(semX);
	temp = sem_signal(semY);
	temp = sem_wait(semZ);
	temp = sem_wait(semZ);

//	sleep(7);

	printf("\n");

	// Remove semaphores
	
	temp = sem_rm(bufAEmpty);
	temp = sem_rm(bufAFilled);
	temp = sem_rm(bufBEmpty);
	temp = sem_rm(bufBFilled);
	temp = sem_rm(semX);
	temp = sem_rm(semY);
	temp = sem_rm(semZ);
	temp = sem_rm(CSX);
	temp = sem_rm(CSY);
	temp = sem_rm(CSZ);

	// Remove shared memory

	temp = shm_rm(shmid1);
	temp = shm_rm(shmid2);

	printf("\nProcZ: Exiting...\n");

	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	printf("\nProcZ: An error has occurred.\n");
	printf("Error Code: %d\n", error_code);

	exit(-1);
}