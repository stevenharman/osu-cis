// ReflexRover.cpp

// Matthew Wolf
// CIS 630
// 10/05/03

#include <iostream.h>
#include <stdio.h>
#include <fstream.h>
#include <stdlib.h>
#include <string.h>


const int INCORRECT_NUMBER_ARG		= 1;
const int ARG_ERROR					= 2;

const int GRAB						= 1;
const int NOOP						= 0;

////////////////////////////////////////////////////////


int SimpleReflexAgent(int soilcomp);

void Error(int type);

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

int main(int argc, char **argv)
{
	ifstream ifs;
	char buffer[5];
	double numd;
	int numi, action;

//	cout << "Number of Arguments: " << argc << "\n";
//	cout << "Argument 1: *" << argv[0] << "*\n";
//	cout << "Argument 2: *" << argv[1] << "*\n";
//	cout << "Argument 3: *" << argv[2] << "*\n";

	cout << "\n";

	if (argc != 3)
	{
		Error(INCORRECT_NUMBER_ARG);
	}

	if (!(strcmp(argv[1], "-file") == 0))
	{
		Error(ARG_ERROR);
	}

	ifs.open(argv[2], ios::in);

	while (!ifs.eof())
	{
		ifs.getline(buffer, 3);

		numd = strtod(buffer, 0);

		numi = (int) numd;

		action = SimpleReflexAgent(numi); // Get the desired action

		if (action == GRAB)
		{
			cout << "Perceived: " << numi << " Action: GRAB";
		}

		else if (action == NOOP)
		{
			cout << "Perceived: " << numi << " Action: NOOP";
		}

		cout << "\n";
	}


	cout << "\n";

	return 1;
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

int SimpleReflexAgent(int soilcomp)
{
	if ((soilcomp % 2) == 0) // Even number
	{
		return GRAB;
	}

	else // Odd number
	{
		return NOOP;
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

	exit(-1);
}

////////////////////////////////////////////////////////