#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>	// for LSEEK, OPEN, CREAT
#include <unistd.h>		// for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>	// for OPEN, CREAT
#include <fcntl.h>		// for OPEN, CREAT


const int ERROR_OPEN		= 0;
const int ERROR_CREATE		= 1;
const int ERROR_READ		= 2;
const int ERROR_WRITE		= 3;
const int ERROR_CLOSE		= 4;
const int ERROR_LSEEK		= 5;
const int ERROR_UNLINK		= 6;




// Error-handling function
void Error(int error_type, int error_id);

///////////////////////////////////////////////////

void main()
{
	int abc_id, abc1_id, abc2_id, abc3_id;
	int bytes_read, bytes_written;
	int current_pos, end_pos;
	int close_error, unlink_error;
	bool read_finished;
	char buffer[100];

	//******** PART 1 ********//

	// Open the source file named "ABC.c"

	abc_id = open("ABC.c", 0); // Open "ABC.c" for reading

	if (abc_id < 0) // Error occurred
	{
		Error(ERROR_OPEN, abc_id);
	}

	// Creates two new files named "ABC.c1" and "ABC.c2" with user priviledges to read, write, and execute

	abc1_id = creat("ABC.c1", 448);

	if (abc1_id < 0) // Error occurred
	{
		Error(ERROR_CREATE, abc1_id);
	}

	abc2_id = creat("ABC.c2", 448);

	if (abc2_id < 0) // Error occurred
	{
		Error(ERROR_CREATE, abc2_id);
	}

	abc1_id = open("ABC.c1", 2); // Open "ABC.c1" for reading and writing

	if (abc1_id < 0) // Error occurred
	{
		Error(ERROR_OPEN, abc1_id);
	}

	abc2_id = open("ABC.c2", 2); // Open "ABC.c2" for reading and writing

	if (abc2_id < 0) // Error occurred
	{
		Error(ERROR_OPEN, abc2_id);
	}

	// Reads characters from "ABC.c" into "ABC.c1" and "ABC.c2" in designated manner

	read_finished = false;

	while (read_finished == false)
	{
		memset (buffer, 0, 100); // Clear buffer

		bytes_read = read(abc_id, &buffer, 10);

		if (bytes_read < 0) // Error occurred
		{
			Error(ERROR_READ, bytes_read);
		}

		else if (bytes_read < 10)
		{
			read_finished = true;
		}

		bytes_written = write(abc1_id, &buffer, 10);

		if (bytes_written < 0) // Error occurred
		{
			Error(ERROR_WRITE, bytes_written);
		}

		if (read_finished == false) // Check to make sure the read file isn't at the end already
		{
			memset (buffer, 0, 100); // Clear buffer

			bytes_read = read(abc_id, &buffer, 20);

			if (bytes_read < 0) // Error occurred
			{
				Error(ERROR_READ, bytes_read);
			}

			else if (bytes_read < 20)
			{
				read_finished = true;
			}

			bytes_written = write(abc2_id, &buffer, 20);

			if (bytes_written < 0) // Error occurred
			{
				Error(ERROR_WRITE, bytes_written);
			}
		}
	}

	close_error = close(abc_id); // Close "ABC.c"

	if (close_error < 0) // Error occurred
	{
		Error(ERROR_CLOSE, close_error);
	}


	//******** PART 2 ********//

	// Writes "Columbus, OH" into "ABC.c1" starting at position 300

	current_pos = lseek(abc1_id, 300, 0);

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	cout << "Part #2 offset value: " << current_pos << endl;

	bytes_written = write(abc1_id, "Columbus, OH", 12);

	if (bytes_written < 0) // Error occurred
	{
		Error(ERROR_WRITE, bytes_written);
	}

	cout << "Part #2 bytes written value: " << bytes_written << endl;


	//******** PART 3 ********//

	// Writes "Computer Science" into "ABC.c2" at end of file

	current_pos = lseek(abc2_id, 0, 2); // Places pointer at end of file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	cout << "Part #3 offset value: " << current_pos << endl;

	bytes_written = write(abc2_id, "Computer Science", 16);

	if (bytes_written < 0) // Error occurred
	{
		Error(ERROR_WRITE, bytes_written);
	}

	cout << "Part #3 bytes written value: " << bytes_written << endl;


	//******** PART 4 ********//

	// Inserts "Matthew Wolf" into "ABC.c2" at location 160

	current_pos = lseek(abc2_id, 0, 2); // Places pointer at end of file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	// Moves characters 12 spaces forward until pointer is at location 160

	while (current_pos > 160)
	{
		memset (buffer, 0, 100); // Clear buffer

		current_pos = lseek(abc2_id, -1, 1); // Moves back 1 space

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}

		bytes_read = read(abc2_id, &buffer, 1); // Read 1 character that will move

		if (bytes_read < 0) // Error occurred
		{
			Error(ERROR_READ, bytes_read);
		}

		current_pos = lseek(abc2_id, 11, 1); // Moves forward 11 spaces

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}

		bytes_written = write(abc2_id, &buffer, 1); // Write 1 character (move)

		if (bytes_written < 0) // Error occurred
		{
			Error(ERROR_WRITE, bytes_written);
		}

		current_pos = lseek(abc2_id, -13, 1); // Moves back 13 spaces

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}
	}

	// Write "Matthew Wolf" at location 160

	bytes_written = write(abc2_id, "MATTHEW WOLF", 12);

	if (bytes_written < 0) // Error occurred
	{
		Error(ERROR_WRITE, bytes_written);
	}

	//******** PART 5 ********//

	// Creates a new file named "ABC.c3" with user priviledges to read, write, and execute

	abc3_id = creat("ABC.c3", 448);

	if (abc3_id < 0) // Error occurred
	{
		Error(ERROR_CREATE, abc3_id);
	}

	abc3_id = open("ABC.c3", 2); // Open "ABC.c3" for reading and writing

	if (abc3_id < 0) // Error occurred
	{
		Error(ERROR_OPEN, abc3_id);
	}

	current_pos = lseek(abc3_id, 0, 0); // Places pointer at beginning of "ABC.c3" file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	current_pos = lseek(abc2_id, 0, 2); // Places pointer at end of "ABC.c2" file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	// Reads characters from "ABC.c2" backwards into "ABC.c3"

	while (current_pos > 0)
	{
		memset (buffer, 0, 100); // Clear buffer

		current_pos = lseek(abc2_id, -1, 1); // Moves back 1 space

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}

		bytes_read = read(abc2_id, &buffer, 1); // Read 1 character that will move

		if (bytes_read < 0) // Error occurred
		{
			Error(ERROR_READ, bytes_read);
		}

		current_pos = lseek(abc2_id, -1, 1); // Moves back 1 space

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}

		bytes_written = write(abc3_id, &buffer, 1); // Write 1 character into "ABC.c3"

		if (bytes_written < 0) // Error occurred
		{
			Error(ERROR_WRITE, bytes_written);
		}
	}

	// Append "ABC.c3" with "ABC.c1" 100 characters at a time

	current_pos = lseek(abc3_id, 0, 2); // Places pointer at end of "ABC.c3" file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	current_pos = lseek(abc1_id, 0, 0); // Places pointer at beginning of "ABC.c1" file

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}


	read_finished = false;

	while (read_finished == false)
	{
		memset (buffer, 0, 100); // Clear buffer

		bytes_read = read(abc1_id, &buffer, 100); // Read 100 characters from "ABC.c1"

		if (bytes_read < 0) // Error occurred
		{
			Error(ERROR_READ, bytes_read);
		}

		if (bytes_read < 100) // Finished reading from "ABC.c1"
		{
			read_finished = true;
		}

		bytes_written = write(abc3_id, &buffer, 100); // Write 100 characters into "ABC.c3"

		if (bytes_written < 0) // Error occurred
		{
			Error(ERROR_WRITE, bytes_written);
		}
	}


	//******** PART 6 ********//

	end_pos = lseek(abc3_id, 0, 2); // Returns last position of file "ABC.c3"

	if (end_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, end_pos);
	}

	current_pos = lseek(abc3_id, 0, 0); // Returns initial position of file "ABC.c3"

	if (current_pos < 0) // Error occurred
	{
		Error(ERROR_LSEEK, current_pos);
	}

	while (current_pos < end_pos)
	{
		memset (buffer, 0, 100); // Clear buffer

		bytes_read = read(abc3_id, &buffer, 1); // Read 1 character from "ABC.c3"

		if (bytes_read < 0) // Error occurred
		{
			Error(ERROR_READ, bytes_read);
		}

		// Check for non-printable characters and replace them with the '@' character
		// Non-printable characters include: \r(carriage return), \n(newline),\f(form feed), and \t(tab)

		if ((buffer[0] == '\r') || (buffer[0] == '\n') || (buffer[0] == '\f') || (buffer[0] == '\t'))
		{
			buffer[0] = '@';
		}

		current_pos = lseek(abc3_id, 0, 1); // Returns current position of file "ABC.c3"

		if (current_pos < 0) // Error occurred
		{
			Error(ERROR_LSEEK, current_pos);
		}

		cout << buffer[0]; // Prints character out to screen
	}

	cout << endl;

	// Close all open files

	close_error = close(abc1_id);

	if (close_error < 0) // Error occurred
	{
		Error(ERROR_CLOSE, close_error);
	}

	close_error = close(abc2_id);

	if (close_error < 0) // Error occurred
	{
		Error(ERROR_CLOSE, close_error);
	}

	close_error = close(abc3_id);

	if (close_error < 0) // Error occurred
	{
		Error(ERROR_CLOSE, close_error);
	}

	// Delete "ABC.c1", "ABC.c2", and "ABC.c3" files

	unlink_error = unlink("ABC.c1");

	if (unlink_error < 0) // Error occurred
	{
		Error(ERROR_UNLINK, unlink_error);
	}

	unlink_error = unlink("ABC.c2");

	if (unlink_error < 0) // Error occurred
	{
		Error(ERROR_UNLINK, unlink_error);
	}

	unlink_error = unlink("ABC.c3");

	if (unlink_error < 0) // Error occurred
	{
		Error(ERROR_UNLINK, unlink_error);
	}
}

///////////////////////////////////////////////////

void Error(int error_type, int error_id)
{
	if (error_type == ERROR_OPEN)
	{
		cout << "Error encountered while opening file";
	}

	else if (error_type == ERROR_CREATE)
	{
		cout << "Error encountered while creating file";
	}

	else if (error_type == ERROR_READ)
	{
		cout << "Error encountered while reading file";
	}

	else if (error_type == ERROR_WRITE)
	{
		cout << "Error encountered while writing file";
	}

	else if (error_type == ERROR_CLOSE)
	{
		cout << "Error encountered while closing file";
	}

	else if (error_type == ERROR_LSEEK)
	{
		cout << "Error encountered while using lseek";
	}

	else if (error_type == ERROR_UNLINK)
	{
		cout << "Error encountered while unlinking file";
	}

	cout << endl;

	exit(-1);
}