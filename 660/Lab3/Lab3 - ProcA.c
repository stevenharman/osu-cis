// Filename: ProcA.c
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
	int semA, semB, semX;

	char *arg[1] = {0};
	int B;

	// Create duplicate process and give it code from ProcB

	B = fork();

	if (B == 0) // process is a child
	{
		execv("ProcB", arg);
	}

	// Create and initialize semaphores

	semA = sem_create(111111, 0);
	if (semA < 0)
	{
		Error(1); // Error has occurred
	}

	semB = sem_create(222222, 0);
	if (semB < 0)
	{
		Error(1); // Error has occurred
	}

	semX = sem_create(333333, 1);
	if (semX < 0)
	{
		Error(1); // Error has occurred
	}

	// Opens shared memory between two processes

	shmid = shm_get(123456, (void*) &Account, 2);

	// Fill in initial account balances (shared memory)

	Account[0] = 1000;
	Account[1] = 1000;

	// Synchronize with ProcB

	temp = sem_signal(semB);
	temp = sem_wait(semA);

	// Critical Section - Begin

	for (i = 0; i < 1000; i++)
	{
		temp = sem_wait(semX);

		internal_reg = Account[0];
		internal_reg = internal_reg - 100;
		Account[0] = internal_reg;

		internal_reg = Account[1];
		internal_reg = internal_reg + 100;
		Account[1] = internal_reg;

		temp = sem_signal(semX);
	}

	// Critical Section - End

	// Synchronize with ProcB

	temp = sem_signal(semB);
	temp = sem_wait(semA);

	printf("\nProcA: Sum of balances= %d $\n", Account[0]+Account[1]);

	// Remove semaphores

	temp = sem_rm(semA);
	temp = sem_rm(semB);

	// Remove shared memory

	temp = shm_rm(shmid);

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