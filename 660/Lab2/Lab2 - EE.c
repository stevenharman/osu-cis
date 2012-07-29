// EE.c //

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
	////////////////////
	// *** PART 6 *** //
	////////////////////

	cout << "Program EE.c: Printing file XYZ.txt backwards onto screen.\n\n";

	int xyz_id;
	int current_pos, bytes_read;
	char buffer[10];
	bool done_reading;

	// Opens file XYZ.txt for reading and writing

	xyz_id = open("XYZ.txt", 2);

	if (xyz_id < 0) // Error occurred
	{
		Error(OPEN_ERROR);
	}







	// Move to end of file XYZ.txt

	current_pos = lseek(xyz_id, 0, 2);

	if (current_pos < 0) // Error occurred
	{
		Error(LSEEK_ERROR);
	}

	// Print out characters in XYZ.txt backwards

	done_reading = false;

	while (done_reading == false)
	{
		// Move position in XYZ.txt one character back

		current_pos = lseek(xyz_id, -1, 1);

		if (current_pos < 0) // Error occurred
		{
			Error(LSEEK_ERROR);
		}

		if (current_pos != 0)
		{
			memset (buffer, 0, 10); // Clear buffer

			// Read one character

			bytes_read = read(xyz_id, &buffer, 1);

			if (bytes_read < 0) // Error occurred
			{
				Error(READ_ERROR);
			}

			cout << buffer; // Prints character out to screen

			// Move position in XYZ.txt one character back

			current_pos = lseek(xyz_id, -1, 1);

			if (current_pos < 0) // Error occurred
			{
				Error(LSEEK_ERROR);
			}
		}

		else
		{
			done_reading = true;
		}
	}

	memset (buffer, 0, 10); // Clear buffer

	// Read last character

	bytes_read = read(xyz_id, &buffer, 1);

	if (bytes_read < 0) // Error occurred
	{
		Error(READ_ERROR);
	}

	cout << buffer << "\n\n"; // Prints character out to screen







	cout << "Program EE.c: Process terminated\n\n";
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