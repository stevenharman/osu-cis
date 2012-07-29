// StateRover.cpp

// Matthew Wolf
// CIS 630
// 10/05/03

#include <iostream.h>
#include <stdio.h>
#include <fstream.h>
#include <stdlib.h>
#include <string.h>


// List of Valid Actions
const int GONORTH					= 1;
const int GOEAST					= 2;
const int GOWEST					= 3;
const int LOOKNORTH					= 4;
const int LOOKWEST					= 5;
const int LOOKEAST					= 6;
const int GRAB						= 7;
const int NOOP						= 8;

// Status of each Position in Grid
const int CLEAR						= 0;
const int BOULDER					= 1;
const int OUT_OF_BOUNDS				= 2;

const int NORTH						= 1;
const int EAST						= 2;
const int SOUTH						= 3;
const int WEST						= 4;

// Error constants
const int INCORRECT_NUMBER_ARG		= 1;
const int ARG_ERROR					= 2;
const int COMMA_MISSING				= 3;

// Grid Representation
int grid_state[4][7];
int grid_soil[4][7];
bool grid_complete[4][7];
int h_position, v_position;
int direction_facing; // NORTH, EAST, SOUTH, or WEST
int total_moves;
int compounds_collected;

////////////////////////////////////////////////////////

void Parser(ifstream &ifs);

void PrintStatus();

int ReflexAgentWithState();

void Error(int type);

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

int main(int argc, char **argv)
{
	ifstream ifs;
	int action;

	cout << "\n";

	// Check for correct number of arguments

	if (argc != 3)
	{
		Error(INCORRECT_NUMBER_ARG);
	}

	// Check for existance of "-file"

	if (!(strcmp(argv[1], "-file") == 0))
	{
		Error(ARG_ERROR);
	}

	// Open input file

	ifs.open(argv[2], ios::in);

	// Parse input file and fill in state information

	Parser(ifs);

	// Set initial starting positions (and overall settings) for rover

	h_position = 1;
	v_position = 1;
	direction_facing = WEST;
	total_moves = 0;
	compounds_collected = 0;

	// Get first action

	PrintStatus();
	action = ReflexAgentWithState();

	// Complete all other actions

	while (action != NOOP)
	{
		PrintStatus();
		action = ReflexAgentWithState();
	}

	cout << "\n\n";
	cout << "Total Compounds Collected: " << compounds_collected << "\n";
	cout << "Total Moves: " << total_moves << "\n\n";

	return 1;
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

void Parser(ifstream &ifs)
{
	char buffer[100];
	int row_number;
	int index, pos;
	double numd;

	char field1[10];
	char field2[10];
	char field3[10];
	char field4[10];
	char field5[10];

	// Initialize grid according to input file

	while (!ifs.eof())
	{
		memset (buffer, 0, 100);

		ifs.getline(buffer, 100);

		memset (field1, 0, 10);
		memset (field2, 0, 10);
		memset (field3, 0, 10);
		memset (field4, 0, 10);
		memset (field5, 0, 10);
		index = 0;
		pos = 0;

		// Begin parsing of individual line

		while (buffer[index] != ',')
		{
			field1[pos] = buffer[index];
			index++;
			pos++;
		}

		index++; // Skip Comma

		pos = 0;

		while (buffer[index] != ',')
		{
			field2[pos] = buffer[index];
			index++;
			pos++;
		}

		index++; // Skip Comma

		pos = 0;

		while (buffer[index] != ',')
		{
			field3[pos] = buffer[index];
			index++;
			pos++;
		}

		index++; // Skip Comma

		pos = 0;

		while (buffer[index] != ',')
		{
			field4[pos] = buffer[index];
			index++;
			pos++;
		}

		index++; // Skip Comma

		pos = 0;

		while ((buffer[index] == '0') || (buffer[index] == '1') || (buffer[index] == '2') || (buffer[index] == '3') ||
			   (buffer[index] == '4') || (buffer[index] == '5') || (buffer[index] == '6') || (buffer[index] == '7') ||
			   (buffer[index] == '8') || (buffer[index] == '9'))
		{
			field5[pos] = buffer[index];
			index++;
			pos++;
		}

		// Store information in appropriate locations

		// Field1

		numd = strtod(field1, NULL);
		row_number = (int) numd;

		// Field2

		if (strcmp(field2, "CLEAR") == 0)
		{
			grid_state[1][row_number] = CLEAR;
		}

		else if (strcmp(field2, "BOULDER") == 0)
		{
			grid_state[1][row_number] = BOULDER;
		}

		// Field3 (causing segmentation fault)

		numd = strtod(field3, NULL);
		grid_soil[1][row_number] = (int) numd;

		// Field4

		if (strcmp(field4, "CLEAR") == 0)
		{
			grid_state[2][row_number] = CLEAR;
		}

		else if (strcmp(field4, "BOULDER") == 0)
		{
			grid_state[2][row_number] = BOULDER;
		}

		// Field5

		numd = strtod(field5, NULL);
		grid_soil[2][row_number] = (int) numd;
	}


	// Define Out-Of-Bounds

	grid_state[0][0] = OUT_OF_BOUNDS;
	grid_state[1][0] = OUT_OF_BOUNDS;
	grid_state[2][0] = OUT_OF_BOUNDS;
	grid_state[3][0] = OUT_OF_BOUNDS;
	grid_state[0][1] = OUT_OF_BOUNDS;
	grid_state[3][1] = OUT_OF_BOUNDS;
	grid_state[0][2] = OUT_OF_BOUNDS;
	grid_state[3][2] = OUT_OF_BOUNDS;
	grid_state[0][3] = OUT_OF_BOUNDS;
	grid_state[3][3] = OUT_OF_BOUNDS;
	grid_state[0][4] = OUT_OF_BOUNDS;
	grid_state[3][4] = OUT_OF_BOUNDS;
	grid_state[0][5] = OUT_OF_BOUNDS;
	grid_state[3][5] = OUT_OF_BOUNDS;
	grid_state[0][6] = OUT_OF_BOUNDS;
	grid_state[1][6] = OUT_OF_BOUNDS;
	grid_state[2][6] = OUT_OF_BOUNDS;
	grid_state[3][6] = OUT_OF_BOUNDS;


	// DEBUGING PURPOSES
/*
	cout << "\n" << "State";
	cout << "\n" << grid_state[1][5] << " " << grid_state[2][5];
	cout << "\n" << grid_state[1][4] << " " << grid_state[2][4];
	cout << "\n" << grid_state[1][3] << " " << grid_state[2][3];
	cout << "\n" << grid_state[1][2] << " " << grid_state[2][2];
	cout << "\n" << grid_state[1][1] << " " << grid_state[2][1] << "\n";

	cout << "\n" << "Soil";
	cout << "\n" << grid_soil[1][5] << " " << grid_soil[2][5];
	cout << "\n" << grid_soil[1][4] << " " << grid_soil[2][4];
	cout << "\n" << grid_soil[1][3] << " " << grid_soil[2][3];
	cout << "\n" << grid_soil[1][2] << " " << grid_soil[2][2];
	cout << "\n" << grid_soil[1][1] << " " << grid_soil[2][1];
*/

}

////////////////////////////////////////////////////////

void PrintStatus()
{
	int status;

	cout << "Position: <" << h_position << "," << v_position << "> "
         << "Perceived: <" << grid_soil[h_position][v_position] << ",";

	// Determine status of direction facing

	if (direction_facing == NORTH)
	{
		status = grid_state[h_position][v_position+1];
	}

	else if (direction_facing == EAST)
	{
		status = grid_state[h_position+1][v_position];
	}

	else if (direction_facing == SOUTH)
	{
		status = grid_state[h_position][v_position-1];

	}

	else if (direction_facing == WEST)
	{
		status = grid_state[h_position-1][v_position];
	}

	// Print out status of direction facing

	if (status == CLEAR)
	{
		cout << "CLEAR";
	}

	else if (status == BOULDER)
	{
		cout << "BOULDER";
	}

	else if (status == OUT_OF_BOUNDS)
	{
		cout << "OUT OF BOUNDS";
	}

	cout << "> Action: ";
}

////////////////////////////////////////////////////////

int ReflexAgentWithState()
{
	// Finished with entire grid

	if ((v_position == 5) && (grid_complete[1][v_position] == true) && (grid_complete[2][v_position] == true))
	{
		cout << "NOOP\n";
		return NOOP;
	}

	// Grab rock sample if grid section not complete and soil sample is even

	else if ((grid_complete[h_position][v_position] == false) && ((grid_soil[h_position][v_position] % 2) == 0))
	{
		compounds_collected++;
		grid_complete[h_position][v_position] = true;
		cout << "GRAB\n";
		return GRAB;
	}

	// Set grid section to complete

	grid_complete[h_position][v_position] = true;

	// If looking NORTH at a CLEAR section and both horizontal sections are complete, move NORTH

	if ((h_position == 1) && (direction_facing == NORTH) && (grid_state[h_position][v_position+1] == CLEAR) &&
			(grid_complete[h_position][v_position] == true) && (grid_complete[h_position+1][v_position] == true))
	{
		v_position++;
		total_moves++;
		cout << "GONORTH\n";
		return GONORTH;
	}

	else if ((h_position == 2) && (direction_facing == NORTH) && (grid_state[h_position][v_position+1] == CLEAR) &&
			(grid_complete[h_position][v_position] == true) && (grid_complete[h_position-1][v_position] == true))
	{
		v_position++;
		total_moves++;
		cout << "GONORTH\n";
		return GONORTH;
	}

	// If looking NORTH at a BOULDER and both horizontal sections are complete, move to the other side

	else if ((h_position == 1) && (direction_facing == NORTH) && (grid_state[h_position][v_position+1] == BOULDER) &&
			(grid_complete[h_position][v_position] == true) && (grid_complete[h_position+1][v_position] == true))
	{
		h_position++;
		total_moves++;
		direction_facing = EAST;
		cout << "GOEAST\n";
		return GOEAST;
	}

	else if ((h_position == 2) && (direction_facing == NORTH) && (grid_state[h_position][v_position+1] == BOULDER) &&
			(grid_complete[h_position][v_position] == true) && (grid_complete[h_position-1][v_position] == true))
	{
		h_position--;
		total_moves++;
		direction_facing = WEST;
		cout << "GOWEST\n";
		return GOWEST;
	}

	// If not looking NORTH and both sections are complete, look NORTH

	else if ((h_position == 1) && (direction_facing != NORTH) && (grid_complete[h_position][v_position] == true) &&
			(grid_complete[h_position+1][v_position] == true))
	{
		direction_facing = NORTH;
		cout << "LOOKNORTH\n";
		return LOOKNORTH;
	}

	else if ((h_position == 2) && (direction_facing != NORTH) && (grid_complete[h_position][v_position] == true) &&
			(grid_complete[h_position-1][v_position] == true))
	{
		direction_facing = NORTH;
		cout << "LOOKNORTH\n";
		return LOOKNORTH;
	}

	// If adjacent horizontal section is not complete, look at the other section

	else if ((h_position == 1) && (grid_complete[h_position+1][v_position] == false) && (direction_facing != EAST))
	{
		direction_facing = EAST;
		cout << "LOOKEAST\n";
		return LOOKEAST;
	}

	else if ((h_position == 2) && (grid_complete[h_position-1][v_position] == false) && (direction_facing != WEST))
	{
		direction_facing = WEST;
		cout << "LOOKWEST\n";
		return LOOKWEST;
	}

	// If adjacent horizontal section is not complete and there is a BOULDER, make section complete and look NORTH

	else if ((h_position == 1) && (grid_complete[h_position+1][v_position] == false) && (direction_facing == EAST) &&
			(grid_state[h_position+1][v_position] == BOULDER))
	{
		grid_complete[h_position+1][v_position] = true;
		direction_facing = NORTH;
		cout << "LOOKNORTH\n";
		return LOOKNORTH;
	}

	else if ((h_position == 2) && (grid_complete[h_position-1][v_position] == false) && (direction_facing == WEST) &&
			(grid_state[h_position-1][v_position] == BOULDER))
	{
		grid_complete[h_position-1][v_position] = true;
		direction_facing = NORTH;
		cout << "LOOKNORTH\n";
		return LOOKNORTH;
	}

	// If adjacent horizontal section is not complete and section is CLEAR, move into section

	else if ((h_position == 1) && (grid_complete[h_position+1][v_position] == false) && (direction_facing == EAST) &&
			(grid_state[h_position+1][v_position] == CLEAR))
	{
		grid_complete[h_position+1][v_position] = true;
		h_position++;
		total_moves++;
		cout << "GOEAST\n";
		return GOEAST;
	}

	else if ((h_position == 2) && (grid_complete[h_position-1][v_position] == false) && (direction_facing == WEST) &&
			(grid_state[h_position-1][v_position] == CLEAR))
	{
		grid_complete[h_position-1][v_position] = true;
		h_position--;
		total_moves++;
		cout << "GOWEST\n";
		return GOWEST;
	}

	else
	{
		cout << "Error: No valid path";
	}
}

////////////////////////////////////////////////////////

void Error(int type)
{
	if (type == INCORRECT_NUMBER_ARG)
	{
		cout << "\nError: Incorrect number of arguments.\n";
	}

	else if (type == ARG_ERROR)
	{
		cout << "\nError: Incorrect argument.\n";
	}

	else if (type == COMMA_MISSING)
	{
		cout << "\nError: Comma missing in input file.\n";
	}

	exit(-1);
}

////////////////////////////////////////////////////////