/*
 * sshm.h
 *
 * Header file for "Simple Shared Memory Operations"
 * Version 1.0.0.
 * Date : 10 Jan 2002
 *
 */

/* Functions available to the user */

int shm_get(int key, void **start_ptr, int size);
int shm_rm(int shmid);


