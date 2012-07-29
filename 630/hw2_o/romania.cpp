// romania.cpp

#include "romania.h"


//////////////////////////////////////////////////////////////////

Romania::Romania()
{
	// Set initial queue settings

	queue_start = 0;
	queue_end = 0;

	// Set initial array values

	int x = 0;

	while (x < MAX_CITIES)
	{
		location_searched[x] = 0;
		x++;
	}

	x = 0;

	while (x < MAX_CITIES)
	{
		number_of_connecting_cities[x] = 0;
		x++;
	}

	//memset (location_searched, 0, MAX_CITIES);
	//memset (number_of_connecting_cities, 0, MAX_CITIES);

	// Define all possible connections between cities

	connecting_cities[CITY_A][0] = CITY_Z;
	city_distances[CITY_A][0] = 75;
	connecting_cities[CITY_A][1] = CITY_S;
	city_distances[CITY_A][1] = 140;
	connecting_cities[CITY_A][2] = CITY_T;
	city_distances[CITY_A][2] = 118;
	number_of_connecting_cities[CITY_A] = 3;

	connecting_cities[CITY_B][0] = CITY_U;
	city_distances[CITY_B][0] = 85;
	connecting_cities[CITY_B][1] = CITY_P;
	city_distances[CITY_B][1] = 101;
	connecting_cities[CITY_B][2] = CITY_G;
	city_distances[CITY_B][2] = 90;
	connecting_cities[CITY_B][3] = CITY_F;
	city_distances[CITY_B][3] = 211;
	number_of_connecting_cities[CITY_B] = 4;

	connecting_cities[CITY_C][0] = CITY_D;
	city_distances[CITY_C][0] = 120;
	connecting_cities[CITY_C][1] = CITY_R;
	city_distances[CITY_C][1] = 146;
	connecting_cities[CITY_C][2] = CITY_P;
	city_distances[CITY_C][2] = 138;
	number_of_connecting_cities[CITY_C] = 3;

	connecting_cities[CITY_D][0] = CITY_C;
	city_distances[CITY_D][0] = 120;
	connecting_cities[CITY_D][1] = CITY_M;
	city_distances[CITY_D][1] = 75;
	number_of_connecting_cities[CITY_D] = 2;

	connecting_cities[CITY_E][0] = CITY_H;
	city_distances[CITY_E][0] = 86;
	number_of_connecting_cities[CITY_E] = 1;

	connecting_cities[CITY_F][0] = CITY_B;
	city_distances[CITY_F][0] = 211;
	connecting_cities[CITY_F][1] = CITY_S;
	city_distances[CITY_F][1] = 99;
	number_of_connecting_cities[CITY_F] = 2;

	connecting_cities[CITY_G][0] = CITY_B;
	city_distances[CITY_G][0] = 90;
	number_of_connecting_cities[CITY_G] = 1;

	connecting_cities[CITY_H][0] = CITY_E;
	city_distances[CITY_H][0] = 86;
	connecting_cities[CITY_H][1] = CITY_U;
	city_distances[CITY_H][1] = 98;
	number_of_connecting_cities[CITY_H] = 2;

	connecting_cities[CITY_I][0] = CITY_V;
	city_distances[CITY_I][0] = 92;
	connecting_cities[CITY_I][1] = CITY_N;
	city_distances[CITY_I][1] = 87;
	number_of_connecting_cities[CITY_I] = 2;

	connecting_cities[CITY_L][0] = CITY_T;
	city_distances[CITY_L][0] = 111;
	connecting_cities[CITY_L][1] = CITY_M;
	city_distances[CITY_L][1] = 70;
	number_of_connecting_cities[CITY_L] = 2;

	connecting_cities[CITY_M][0] = CITY_D;
	city_distances[CITY_M][0] = 75;
	connecting_cities[CITY_M][1] = CITY_L;
	city_distances[CITY_M][1] = 70;
	number_of_connecting_cities[CITY_M] = 2;

	connecting_cities[CITY_N][0] = CITY_I;
	city_distances[CITY_N][0] = 87;
	number_of_connecting_cities[CITY_N] = 1;

	connecting_cities[CITY_O][0] = CITY_Z;
	city_distances[CITY_O][0] = 71;
	connecting_cities[CITY_O][1] = CITY_S;
	city_distances[CITY_O][1] = 151;
	number_of_connecting_cities[CITY_O] = 2;

	connecting_cities[CITY_P][0] = CITY_B;
	city_distances[CITY_P][0] = 101;
	connecting_cities[CITY_P][1] = CITY_C;
	city_distances[CITY_P][1] = 138;
	connecting_cities[CITY_P][2] = CITY_R;
	city_distances[CITY_P][2] = 97;
	number_of_connecting_cities[CITY_P] = 3;

	connecting_cities[CITY_R][0] = CITY_C;
	city_distances[CITY_R][0] = 146;
	connecting_cities[CITY_R][1] = CITY_P;
	city_distances[CITY_R][1] = 97;
	connecting_cities[CITY_R][2] = CITY_S;
	city_distances[CITY_R][2] = 80;
	number_of_connecting_cities[CITY_R] = 3;

	connecting_cities[CITY_S][0] = CITY_A;
	city_distances[CITY_S][0] = 140;
	connecting_cities[CITY_S][1] = CITY_F;
	city_distances[CITY_S][1] = 99;
	connecting_cities[CITY_S][2] = CITY_O;
	city_distances[CITY_S][2] = 151;
	connecting_cities[CITY_S][3] = CITY_R;
	city_distances[CITY_S][3] = 80;
	number_of_connecting_cities[CITY_S] = 4;

	connecting_cities[CITY_T][0] = CITY_A;
	city_distances[CITY_T][0] = 118;
	connecting_cities[CITY_T][1] = CITY_L;
	city_distances[CITY_T][1] = 111;
	number_of_connecting_cities[CITY_T] = 2;

	connecting_cities[CITY_U][0] = CITY_B;
	city_distances[CITY_U][0] = 85;
	connecting_cities[CITY_U][1] = CITY_H;
	city_distances[CITY_U][1] = 98;
	connecting_cities[CITY_U][2] = CITY_V;
	city_distances[CITY_U][2] = 142;
	number_of_connecting_cities[CITY_U] = 3;

	connecting_cities[CITY_V][0] = CITY_I;
	city_distances[CITY_V][0] = 92;
	connecting_cities[CITY_V][1] = CITY_U;
	city_distances[CITY_V][1] = 142;
	number_of_connecting_cities[CITY_V] = 2;

	connecting_cities[CITY_Z][0] = CITY_A;
	city_distances[CITY_Z][0] = 75;
	connecting_cities[CITY_Z][1] = CITY_O;
	city_distances[CITY_Z][1] = 71;
	number_of_connecting_cities[CITY_Z] = 2;

}

//////////////////////////////////////////////////////////////////

void Romania::Get_Connecting_Cities(int current_city, int &city1, int &distance1, int &city2, int &distance2,
						   int &city3, int &distance3, int &city4, int &distance4)
{
	int n = 0;
	int cities[4];
	int distances[4];

	while (n < number_of_connecting_cities[current_city])
	{
		cities[n] = connecting_cities[current_city][n];
		distances[n] = city_distances[current_city][n];

		n++;
	}

	if (number_of_connecting_cities[current_city] == 1)
	{
		city1 = cities[0];
		distance1 = distances[0];
		city2 = 0;
		distance2 = 0;
		city3 = 0;
		distance3 = 0;
		city4 = 0;
		distance4 = 0;
	}

	else if (number_of_connecting_cities[current_city] == 2)
	{
		city1 = cities[0];
		distance1 = distances[0];
		city2 = cities[1];
		distance2 = distances[1];
		city3 = 0;
		distance3 = 0;
		city4 = 0;
		distance4 = 0;
	}

	else if (number_of_connecting_cities[current_city] == 3)
	{
		city1 = cities[0];
		distance1 = distances[0];
		city2 = cities[1];
		distance2 = distances[1];
		city3 = cities[2];
		distance3 = distances[2];
		city4 = 0;
		distance4 = 0;
	}

	else if (number_of_connecting_cities[current_city] == 4)
	{
		city1 = cities[0];
		distance1 = distances[0];
		city2 = cities[1];
		distance2 = distances[1];
		city3 = cities[2];
		distance3 = distances[2];
		city4 = cities[3];
		distance4 = distances[3];
	}

	else
	{
		cout << "\nError: Too many connecting cities\n";
		exit(-1);
	}
}

//////////////////////////////////////////////////////////////////

void Romania::Put_City_In_Queue(int city, int distance, int nodes, char *route)
{
	int x = 0;
	char city_letter;

	city_queue[queue_end][CITY_NUMBER] = city;
	city_queue[queue_end][CITY_DISTANCE] = distance;
	city_queue[queue_end][CITY_NODES] = nodes;

	switch (city) // Figure out which letter to use
	{
		case CITY_A:
			city_letter = 'A';
			break;

		case CITY_B:
			city_letter = 'B';
			break;

		case CITY_C:
			city_letter = 'C';
			break;

		case CITY_D:
			city_letter = 'D';
			break;

		case CITY_E:
			city_letter = 'E';
			break;

		case CITY_F:
			city_letter = 'F';
			break;

		case CITY_G:
			city_letter = 'G';
			break;

		case CITY_H:
			city_letter = 'H';
			break;

		case CITY_I:
			city_letter = 'I';
			break;

		case CITY_L:
			city_letter = 'L';
			break;

		case CITY_M:
			city_letter = 'M';
			break;

		case CITY_N:
			city_letter = 'N';
			break;

		case CITY_O:
			city_letter = 'O';
			break;

		case CITY_P:
			city_letter = 'P';
			break;

		case CITY_R:
			city_letter = 'R';
			break;

		case CITY_S:
			city_letter = 'S';
			break;

		case CITY_T:
			city_letter = 'T';
			break;

		case CITY_U:
			city_letter = 'U';
			break;

		case CITY_V:
			city_letter = 'V';
			break;

		case CITY_Z:
			city_letter = 'Z';
			break;
	}

	x = 0;

	while ((route[x] == 'A') || (route[x] == 'B') || (route[x] == 'C') || (route[x] == 'D') || (route[x] == 'E') ||
		   (route[x] == 'F') || (route[x] == 'G') || (route[x] == 'H') || (route[x] == 'I') || (route[x] == 'L') ||
		   (route[x] == 'M') || (route[x] == 'N') || (route[x] == 'O') || (route[x] == 'P') || (route[x] == 'R') ||
		   (route[x] == 'S') || (route[x] == 'T') || (route[x] == 'U') || (route[x] == 'V') || (route[x] == 'Z'))
	{
		city_route[queue_end][x] = route[x];
		x++;
	}

	city_route[queue_end][x] = city_letter;

	queue_end++;
}


//////////////////////////////////////////////////////////////////

void Romania::Get_City_From_Queue(int &city, int &distance, int &nodes, char **route)
{
	city = city_queue[queue_start][CITY_NUMBER];
	distance = city_queue[queue_start][CITY_DISTANCE];
	nodes = city_queue[queue_start][CITY_NODES];

	*route = city_route[queue_start];

	queue_start++;
}


//////////////////////////////////////////////////////////////////

int Romania::Total_Nodes_Enqueued()
{
	return (queue_end + 1);
}

//////////////////////////////////////////////////////////////////

void Romania::Mark_City_As_Searched(int city)
{
	location_searched[city] = 1;
}

//////////////////////////////////////////////////////////////////

bool Romania::Is_City_Searched(int city)
{
	return location_searched[city];
}

//////////////////////////////////////////////////////////////////

void Romania::Print_City_Name(int city)
{
	if (city == CITY_A)
	{
		cout << "A";
	}

	else if (city == CITY_B)
	{
		cout << "B";
	}

	else if (city == CITY_C)
	{
		cout << "C";
	}

	else if (city == CITY_D)
	{
		cout << "D";
	}

	else if (city == CITY_E)
	{
		cout << "E";
	}

	else if (city == CITY_F)
	{
		cout << "F";
	}

	else if (city == CITY_G)
	{
		cout << "G";
	}

	else if (city == CITY_H)
	{
		cout << "H";
	}

	else if (city == CITY_I)
	{
		cout << "I";
	}

	else if (city == CITY_L)
	{
		cout << "L";
	}

	else if (city == CITY_M)
	{
		cout << "M";
	}

	else if (city == CITY_N)
	{
		cout << "N";
	}

	else if (city == CITY_O)
	{
		cout << "O";
	}

	else if (city == CITY_P)
	{
		cout << "P";
	}

	else if (city == CITY_R)
	{
		cout << "R";
	}

	else if (city == CITY_S)
	{
		cout << "S";
	}

	else if (city == CITY_T)
	{
		cout << "T";
	}

	else if (city == CITY_U)
	{
		cout << "U";
	}

	else if (city == CITY_V)
	{
		cout << "V";
	}

	else if (city == CITY_Z)
	{
		cout << "Z";
	}

	else if (city == 0)
	{
		cout << "-";
	}

	else
	{
		cout << "\nError: City number " << city << " does not exist.\n";
		exit(-1);
	}
}

//////////////////////////////////////////////////////////////////