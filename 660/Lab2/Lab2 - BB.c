// BB.c //

#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>  // for LSEEK, OPEN, CREAT
#include <unistd.h>     // for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>   // for OPEN, CREAT
#include <fcntl.h>      // for OPEN, CREAT
#include <sys/wait.h>   // for WAIT
#include <signal.h>     // for KILL


const int OPEN_ERROR		= 1;
const int LSEEK_ERROR		= 2;
const int READ_ERROR		= 3;
const int CREATE_ERROR		= 4;
const int WRITE_ERROR		= 5;
const int KILL_ERROR		= 6;


void Error(int error_type);

///////////////////////////////////////////////////////////

void main()
{
	int file_id1;
	int bytes_written;

	////////////////////
	// *** PART 2 *** //
	////////////////////

	// Creates file "XYZ.txt" with all permissions

	file_id1 = creat("XYZ.txt", 448);

	if (file_id1 < 0) // Error occurred
	{
		Error(CREATE_ERROR);
	}

	// Opens the newly-created file for reading and writing

	file_id1 = open("XYZ.txt", 2);

	if (file_id1 < 0) // Error occurred
	{
		Error(OPEN_ERROR);
	}

	// Writes text into newly-created file

	bytes_written = write(file_id1, "Matthew Wolf, Ohio State University, Columbus, Ohio", 51);

	if (bytes_written < 0) // Error occurred
	{
		Error(WRITE_ERROR);
	}

	cout << "Program BB.c: Created file XYZ.txt and the following text was written in it:\n"
		 << "              Matthew Wolf, Ohio State University, Columbus, Ohio\n\n"
		 << "Program BB.c: Process terminated\n\n";
}

///////////////////////////////////////////////////////////

void Error(int error_type)
{
	if (error_type == OPEN_ERROR)
	{
		cout << "An error occurred during the opening of a file.";
	}

	else if (error_type == LSEEK_ERROR)
	{
		cout << "An error occurred during an lseek command.";
	}

	else if (error_type == READ_ERROR)
	{
		cout << "An error occurred during the reading of a file.";
	}

	else if (error_type == CREATE_ERROR)
	{
		cout << "An error occurred during creation of a file.";
	}

	else if (error_type == WRITE_ERROR)
	{
		cout << "An error occurred during writing of data into a file.";
	}

	else if (error_type = KILL_ERROR)
	{
		cout << "An error occurred while killing a process.";
	}



	cout << "\n\n";
	exit(-1);
}