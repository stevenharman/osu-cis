#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>	// for LSEEK, OPEN, CREAT
#include <unistd.h>     // for READ, WRITE, UNLINK, LSEEK, CLOSE
#include <sys/stat.h>	// for OPEN, CREAT
#include <fcntl.h>	// for OPEN, CREAT

const int ERR_OPEN = 0;
const int ERR_CREATE = 1;
const int ERR_READ = 2;
const int ERR_WRITE = 3;
const int ERR_CLOSE = 4;
const int ERR_LSEEK = 5;
const int ERR_UNLINK = 6;

// Error handling function

void Error(int err_type, int err_id);

void main()
{
    int abc_id, abc1_id, abc2_id, abc3_id;
    int bytes_read, bytes_written, current_pos, end_pos, char_num, close_err, unlink_err;
    bool read_done;
    char buff[100];

    //****** Part 1 - Open ABC.cpp, create ABC.cpp1, ABC.cpp2 and copy
    //ABC.cpp into ABC.cpp1 and ABC.cpp2 appropriatly

    abc_id = open("ABC.cpp", 0); //opens ABC.cpp for reading
    if(abc_id < 0) //error
    {
	Error(ERR_OPEN, abc_id);
    }

    //Create ABC.cpp1 & ABC.cpp2 w/ wrx rights for user
    abc1_id = creat("ABC.cpp1", 448);
    if(abc1_id < 0) //error
    {
	Error(ERR_CREATE, abc1_id);
    }
    abc2_id = creat("ABC.cpp2", 448);
    if(abc2_id < 0) //error
    {
	Error(ERR_CREATE, abc2_id);
    }

    //Open ABC.cpp1 & 2 for wr rights.
    abc1_id = open("ABC.cpp1", 2);
    if(abc1_id < 0)
    {
	Error(ERR_OPEN, abc1_id);
    }
    abc2_id = open("ABC.cpp2", 2);
    if(abc2_id < 0)
    {
	Error(ERR_OPEN, abc2_id);
    }

    //Read chars from ABC.cpp into ABC.cpp1 & 2 in particular order
    read_done = false;

    while(read_done == false)
    {
	memset(buff, 0 ,100); //clear the buffer
	//Read 10 char at a time from ABC.cpp into ABC.cpp1
	bytes_read = read(abc_id, &buff, 10);
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}else if(bytes_read < 10) //End of file
	{
	    read_done = true;
	}

	bytes_written = write(abc1_id, &buff, bytes_read);
	if(bytes_written < 0) //Error
	{
	    Error(ERR_WRITE, bytes_written);
	}

	//Read 20 char at a time from ABC.cpp into ABC.cpp2
	if(read_done == false) //make sure we're not already at EOF
	{
	    memset(buff, 0, 100); //clear the buffer

	    bytes_read = read(abc_id, &buff, 20);
	    if(bytes_read < 0) //Error
	    {
		Error(ERR_READ, bytes_read);
	    }else if(bytes_read < 20)
	    {
		read_done = true;  //reached EOF
	    }

	    bytes_written = write(abc2_id, &buff, bytes_read);
	    if(bytes_written < 0) //Error
	    {
		Error(ERR_WRITE, bytes_written);
	    }
	}//if(read_done == true)
    } //while(read_done == false)

    close_err = close(abc_id); //close file ABC.cpp
    if(close_err < 0) //Error
    {
	Error(ERR_CLOSE, abc_id);
    }

    //****** Part 2 - write "Columbus, Ohio" into ABC.cpp starting at pos 200 (overwrite)

    current_pos = lseek(abc1_id, 200, 0);
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }
    cout << "Part #2 - lseek value: " << current_pos << endl;
    
    bytes_written = write(abc1_id, "Columbus, Ohio", 14);
    if(bytes_written < 0) //Error
    {
	Error(ERR_WRITE, bytes_written);
    }
    cout << "Part #2 - write value: " << bytes_written << endl;
    
    //****** Part 3 - write "Computer Systems" at end of ABC.cpp (overwrite)

    current_pos = lseek(abc2_id, -16, 2); //moves 16 positions left
					 //from end of file
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }
    cout << "Part #3 - lseek value: " << current_pos << endl;
    
    bytes_written = write(abc2_id, "Computer Systems", 16);
    if(bytes_written < 0) //Error
    {
	Error(ERR_WRITE, bytes_written);
    }
    cout << "Part #3 - write value: " << bytes_written << endl;

    //****** Part 4 - write "Department of Computer and Information
    //Science" @ the beginning of ABC.cpp1 (overwrite)

    current_pos = lseek(abc1_id, 0, 0); //move to beginning of file
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }
    cout << "Part #4 - lseek value: " << current_pos << endl;
    
    bytes_written = write(abc1_id, "Department Of Computer and Information Science", 46);
    if(bytes_written < 0) //Error
    {
	Error(ERR_WRITE, bytes_written);
    }
    cout << "Part #4 - write value: " << bytes_written << endl;

    //****** Part5 - appends "submuloCoihO" to ABC.cpp1

    current_pos = lseek(abc1_id, 0, 2); //move to end of file
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }
    cout << "Part #5 - lseek value: " << current_pos << endl;
    
    bytes_written = write(abc1_id, "submuloCoihO", 12);
    if(bytes_written < 0) //Error
    {
	Error(ERR_WRITE, bytes_written);
    }
    cout << "Part #5 - write value: " << bytes_written << endl;

    //****** Part 6 - Insert "Steve Harman" into ABC.cpp2 & pos 100

    current_pos = lseek(abc2_id, 0, 2); //move to EOF
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }

    //Need to move chars 12 spaces forward until we reach pos 100
    while(current_pos > 100)
    {
	memset(buff, 0, 100); //clear buffer
	current_pos = lseek(abc2_id, -1, 1); //move left 1 pos
	if(current_pos < 0) //Error
	{
	    Error(ERR_LSEEK, current_pos);
	}

	bytes_read = read(abc2_id, &buff, 1); //Read 1 char to be moved
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}

	current_pos = lseek(abc2_id, 11, 1); //move forward 11 positions (for writing the 12th pos)
	if(current_pos < 0) //Error
	{
	    Error(ERR_LSEEK, current_pos);
	}

	bytes_written = write(abc2_id, &buff, 1); //write (move) 1 char
	if(bytes_written < 0) //Error
	{
	    Error(ERR_WRITE, bytes_written);
	}

	current_pos = lseek(abc2_id, -13, 1);  //move back 13 pos
	if(current_pos < 0) //Error
	{
	    Error(ERR_LSEEK, current_pos);
	}	
	
    }//while(current_pos > 100)

    //write (insert) "Steve Harman"
    bytes_written = write(abc2_id, "Steve Harman", 12);
    if(bytes_written < 0) //Error
    {
	Error(ERR_WRITE, bytes_written);
    }

    //****** Part 7 - create file ABC.cpp3, copy ABC.cpp1 into
    //ABC.cpp3 in reverse order, then append ABC.cpp2 to ABC.cpp3

    abc3_id = creat("ABC.cpp3", 448);
    if(abc3_id < 0) //Error
    {
	Error(ERR_CREATE, abc3_id);
    }

    abc3_id = open("ABC.cpp3", 2);
    if(abc3_id < 0) //Error
    {
	Error(ERR_OPEN, abc3_id);
    }

    current_pos = lseek(abc3_id, 0, 0); //move to beginning of ABC.cpp3
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }

    current_pos = lseek(abc1_id, 0, 2); //move to EOF ABC.cpp1
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }

    //Read chars from ABC.cpp1 backwards into ABC.cpp3
    while(current_pos > 0)
    {
	memset(buff, 0, 100); //clear the buffer
	current_pos = lseek(abc1_id, -1, 1); //move left 1 char
	if(current_pos < 0) //Error
	{
	    Error(ERR_LSEEK, current_pos);
	}

	bytes_read = read(abc1_id, &buff, 1); //read 1 char to copy
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}

	current_pos = lseek(abc1_id, -1, 1); //move left 1 pos
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}

	bytes_written = write(abc3_id, &buff, 1); //write (copy) 1 char
	if(bytes_written < 0) //Error
	{
	    Error(ERR_WRITE, bytes_written);
	}
	
    }//while(current_pos > 0)

    //Append ABC.cpp2 onto ABC.cpp3
    current_pos = lseek(abc3_id, 0, 2); //move to EOF of ABC.cpp3
    if(bytes_read < 0) //Error
    {
	Error(ERR_READ, bytes_read);
    }

    current_pos = lseek(abc2_id, 0, 0); //move to begining of ABC.cpp2
    if(bytes_read < 0) //Error
    {
	Error(ERR_READ, bytes_read);
    }

    read_done = false;
    while(read_done == false)
    {
	memset (buff, 0, 100);
	bytes_read = read(abc2_id, &buff, 100); //read 100 char from ABC.cpp2
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}
	if(bytes_read < 100) //done reading file
	{
	    read_done = true;
	}

	bytes_written = write(abc3_id, &buff, bytes_read);
	if(bytes_written < 0) //Error
	{
	    Error(ERR_WRITE, bytes_written);
	}
	
    }//while(read_done == false)

    //****** Part 8 - Prints ABC.cpp3 out in defined way
   
    end_pos = lseek(abc3_id, 0, 2); //gives last pos in ABC.cpp3
    if(end_pos < 0) //Error
    {
	Error(ERR_LSEEK, end_pos);
    }

    current_pos = lseek(abc3_id, 0, 0); //moves to first pos of file
    if(current_pos < 0) //Error
    {
	Error(ERR_LSEEK, current_pos);
    }
    
    char_num = 0; //set 80 char counter = 0

    while(current_pos < end_pos)
    {
	//since each line is only 80 chars (incl. CR) if we have the
	//79th char, print a CR and reset the counter.
	if(char_num == 79) 
	{
	    cout << endl;
	    char_num = 0;
	}
	memset(buff, 0, 100); //clear the buffer
	bytes_read = read(abc3_id, &buff, 1); //read 1 char
	if(bytes_read < 0) //Error
	{
	    Error(ERR_READ, bytes_read);
	}

	//check for special chars: '\r' - carriage return w/ '!'
	//  & '\n' - linefeed w/ '!' w/ '@'
	if(buff[0] == '\r')
	{
	    buff[0] = '!';
	}
	if(buff[0] == '\n')
	{
	    buff[0] = '@';
	}

	current_pos = lseek(abc3_id, 0, 1); //get current pos in file
	if(current_pos < 0) //Error
	{
	    Error(ERR_LSEEK, current_pos);
	}

	cout << buff[0];  //print char to stdout
	char_num++; //increment counter
	
    }//while(current_pos < end_pos)
    cout << endl;
    
    //close and delete ABC.cpp1, 2, & 3
    close_err = close(abc1_id);
    if(close_err < 0) //Error
    {
	Error(ERR_CLOSE, close_err);
    }

    close_err = close(abc2_id);
    if(close_err < 0) //Error
    {
	Error(ERR_CLOSE, close_err);
    }

    close_err = close(abc3_id);
    if(close_err < 0) //Error
    {
	Error(ERR_CLOSE, close_err);
    }

    unlink_err = unlink("ABC.cpp1");
    if(unlink_err < 0) //Error
    {
	Error(ERR_UNLINK, unlink_err);
    }

    unlink_err = unlink("ABC.cpp2");
    if(unlink_err < 0) //Error
    {
	Error(ERR_UNLINK, unlink_err);
    }

    unlink_err = unlink("ABC.cpp3");
    if(unlink_err < 0) //Error
    {
	Error(ERR_UNLINK, unlink_err);
    }
    
}

//****** Error fxn ******

void Error(int err_type, int err_id)
{
    if(err_type == ERR_OPEN)
    {
	cout << "Error opening file.";
    }else if(err_type == ERR_CREATE)
    {
	cout << "Error creating file.";
    }else if(err_type == ERR_READ)
    {
	cout << "Error reading file.";
    }else if(err_type == ERR_WRITE)
    {
	cout << "Error writing file.";
    }else if(err_type == ERR_CLOSE)
    {
	cout << "Error closing file.";
    }else if(err_type == ERR_LSEEK)
    {
	cout << "Error using LSEEK.";
    }else if(err_type == ERR_UNLINK)
    {
	cout << "Error unlinking file.";
    }
    cout << endl;
    exit(-1);
}
