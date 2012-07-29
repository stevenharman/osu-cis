// Filename: ProcB.c
// Cis 660 Lab 3

#include <stdio.h>
#include "ssem.h"
#include "sshm.h"

void Error(int error_code);

//////////////////////////////////////////////////
int main()
{
	int *Account;
	int i, internal_reg;
	int shmid;
	int temp;

	// Open existing semaphores

	int semA, semB, semX;

	semA = sem_open(111111);
	if (semA < 0)
	{
		Error(1); // Error has occurred
	}

	semB = sem_open(222222);
	if (semB < 0)
	{
		Error(1); // Error has occurred
	}

	semX = sem_open(333333);
	if (semX < 0)
	{
		Error(1); // Error has occurred
	}

	// Synchronize with ProcA

	temp = sem_signal(semA);
	temp = sem_wait(semB);

	// Opens shared memory between two processes

	shmid = shm_get(123456, (void *) &Account, 2);

	// Critical Section - Begin

	for (i = 0; i < 1000; i++)
	{
		temp = sem_wait(semX);

		internal_reg = Account[1];
		internal_reg = internal_reg - 100;
		Account[1] = internal_reg;

		internal_reg = Account[0];
		internal_reg = internal_reg + 100;
		Account[0] = internal_reg;

		temp = sem_signal(semX);
	}

	// Critical Section - End

	// Synchronize with ProcA

	temp = sem_signal(semA);
	temp = sem_wait(semB);

	printf("\nProcB: Sum of balances= %d $\n", Account[0]+Account[1]);

	return 1;
}
//////////////////////////////////////////////////

void Error(int error_code)
{
	if (error_code == 1)
	{
		printf("An error has occurred during the opening of a semaphore.");
	}

	else
	{
		printf("An error has occurred.");
	}

	exit(-1);
}