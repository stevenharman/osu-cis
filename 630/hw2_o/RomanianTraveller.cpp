// RomanianTraveller.cpp

// Matthew Wolf
// CIS 630 : Homework #2
// 10/12/03

#include <iostream.h>
#include <stdlib.h>
#include <string.h>

#include "constants.h"
#include "romania.h"


// Global Variables

int search_finished = false;

////////////////////////////////////////////////////////

void Breadth_First_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route);

void Depth_First_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route);

void A_Star_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route);

void Swap(int &city1, int &distance1, int &city2, int &distance2);

void Error(int type);

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

int main(int argc, char **argv)
{
	int start_city, end_city;
	char *junk_route;

	cout << "\n";

	// Check for correct number of arguments

	if (argc != 5)
	{
		Error(INCORRECT_NUMBER_ARG);
	}

	// Check for existance of "-s"

	if (!(strcmp(argv[1], "-s") == 0))
	{
		Error(ARG_ERROR);
	}

	// Check for existance of "-e"

	if (!(strcmp(argv[3], "-e") == 0))
	{
		Error(ARG_ERROR);
	}

	// Get actual values of starting and ending cities

	if (strcmp(argv[2], "A") == 0)
	{
		start_city = CITY_A;
	}

	else if (strcmp(argv[2], "B") == 0)
	{
		start_city = CITY_B;
	}

	else if (strcmp(argv[2], "C") == 0)
	{
		start_city = CITY_C;
	}

	else if (strcmp(argv[2], "D") == 0)
	{
		start_city = CITY_D;
	}

	else if (strcmp(argv[2], "E") == 0)
	{
		start_city = CITY_E;
	}

	else if (strcmp(argv[2], "F") == 0)
	{
		start_city = CITY_F;
	}

	else if (strcmp(argv[2], "G") == 0)
	{
		start_city = CITY_G;
	}

	else if (strcmp(argv[2], "H") == 0)
	{
		start_city = CITY_H;
	}

	else if (strcmp(argv[2], "I") == 0)
	{
		start_city = CITY_I;
	}

	else if (strcmp(argv[2], "L") == 0)
	{
		start_city = CITY_L;
	}

	else if (strcmp(argv[2], "M") == 0)
	{
		start_city = CITY_M;
	}

	else if (strcmp(argv[2], "N") == 0)
	{
		start_city = CITY_N;
	}

	else if (strcmp(argv[2], "O") == 0)
	{
		start_city = CITY_O;
	}

	else if (strcmp(argv[2], "P") == 0)
	{
		start_city = CITY_P;
	}

	else if (strcmp(argv[2], "R") == 0)
	{
		start_city = CITY_R;
	}

	else if (strcmp(argv[2], "S") == 0)
	{
		start_city = CITY_S;
	}

	else if (strcmp(argv[2], "T") == 0)
	{
		start_city = CITY_T;
	}

	else if (strcmp(argv[2], "U") == 0)
	{
		start_city = CITY_U;
	}

	else if (strcmp(argv[2], "V") == 0)
	{
		start_city = CITY_V;
	}

	else if (strcmp(argv[2], "Z") == 0)
	{
		start_city = CITY_Z;
	}

	if (strcmp(argv[4], "A") == 0)
	{
		end_city = CITY_A;
	}

	else if (strcmp(argv[4], "B") == 0)
	{
		end_city = CITY_B;
	}

	else if (strcmp(argv[4], "C") == 0)
	{
		end_city = CITY_C;
	}

	else if (strcmp(argv[4], "D") == 0)
	{
		end_city = CITY_D;
	}

	else if (strcmp(argv[4], "E") == 0)
	{
		end_city = CITY_E;
	}

	else if (strcmp(argv[4], "F") == 0)
	{
		end_city = CITY_F;
	}

	else if (strcmp(argv[4], "G") == 0)
	{
		end_city = CITY_G;
	}

	else if (strcmp(argv[4], "H") == 0)
	{
		end_city = CITY_H;
	}

	else if (strcmp(argv[4], "I") == 0)
	{
		end_city = CITY_I;
	}

	else if (strcmp(argv[4], "L") == 0)
	{
		end_city = CITY_L;
	}

	else if (strcmp(argv[4], "M") == 0)
	{
		end_city = CITY_M;
	}

	else if (strcmp(argv[4], "N") == 0)
	{
		end_city = CITY_N;
	}

	else if (strcmp(argv[4], "O") == 0)
	{
		end_city = CITY_O;
	}

	else if (strcmp(argv[4], "P") == 0)
	{
		end_city = CITY_P;
	}

	else if (strcmp(argv[4], "R") == 0)
	{
		end_city = CITY_R;
	}

	else if (strcmp(argv[4], "S") == 0)
	{
		end_city = CITY_S;
	}

	else if (strcmp(argv[4], "T") == 0)
	{
		end_city = CITY_T;
	}

	else if (strcmp(argv[4], "U") == 0)
	{
		end_city = CITY_U;
	}

	else if (strcmp(argv[4], "V") == 0)
	{
		end_city = CITY_V;
	}

	else if (strcmp(argv[4], "Z") == 0)
	{
		end_city = CITY_Z;
	}

	// Breadth-First Search Algorithm

	Romania romania_bfs;

	search_finished = false;

	cout << "\n--------------------\nBREADTH-FIRST SEARCH\n--------------------\n\n";

	Breadth_First_Search(romania_bfs, start_city, end_city, 0, 0, junk_route);


	// Depth-First Search Algorithm

	Romania romania_dfs;

	search_finished = false;

	cout << "\n------------------\nDEPTH-FIRST SEARCH\n------------------\n\n";

	Depth_First_Search(romania_dfs, start_city, end_city, 0, 0, junk_route);


	// A* Search Algorithm

	Romania romania_astar;

	search_finished = false;

	cout << "\n---------\nA* SEARCH\n---------\n\n";

	A_Star_Search(romania_astar, start_city, end_city, 0, 0, junk_route);




	cout << "\n\n* Program Complete *\n\n";

	return 1;
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

void Breadth_First_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route)
{
	int city1, city2, city3, city4;
	int distance1, distance2, distance3, distance4;
	int new_city, new_distance, new_nodes;
	int city_num = 0;
	char *new_route;


	// DEBUG //
	cout << "<";
	r.Print_City_Name(start_city);
	cout << "> -> ";
	// DEBUG //


	if ((start_city != end_city) && !(r.Is_City_Searched(start_city)) && (!search_finished))
	{
		r.Mark_City_As_Searched(start_city);

		r.Get_Connecting_Cities(start_city, city1, distance1, city2, distance2, city3, distance3, city4, distance4);


		// DEBUG //
		cout << "( ";
		r.Print_City_Name(city1);
		cout << " ";
		r.Print_City_Name(city2);
		cout << " ";
		r.Print_City_Name(city3);
		cout << " ";
		r.Print_City_Name(city4);
		cout << " )\n";
		// DEBUG //


		// Put existing cities in searching queue

		if (city1 != 0)
		{
			r.Put_City_In_Queue(city1, total_distance + distance1, total_nodes + 1, full_route);
			city_num++;
		}

		if (city2 != 0)
		{
			r.Put_City_In_Queue(city2, total_distance + distance2, total_nodes + 1, full_route);
			city_num++;
		}

		if (city3 != 0)
		{
			r.Put_City_In_Queue(city3, total_distance + distance3, total_nodes + 1, full_route);
			city_num++;
		}

		if (city4 != 0)
		{
			r.Put_City_In_Queue(city4, total_distance + distance4, total_nodes + 1, full_route);
			city_num++;
		}

		// Pull cities out of searching queue

		while (city_num > 0)
		{
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);

			Breadth_First_Search(r, new_city, end_city, new_distance, new_nodes, new_route);

			city_num--;
		}
	}

	else if ((start_city == end_city) && (!search_finished)) // Destination city is found
	{
		cout << "Destination City Found!\n\n";

		cout << "Sequence of Cities: ";

		int x = 0;
		while (full_route[x] != 0)
		{
			cout << full_route[x] << " ";
			x++;
		}
		cout << "\n";
		
		cout << "Total Distance Traveled: " << total_distance << "\n";
		cout << "Total Nodes Traveled: " << total_nodes << "\n";
		cout << "Total Number of Nodes Enqueued: " << r.Total_Nodes_Enqueued() << "\n\n";

		search_finished = true; // Set global variable
	}

	else if (search_finished) // Search is Finished
	{
		cout << "Search Finished\n";
	}

	else if (r.Is_City_Searched(start_city)) // City previously searched
	{
		cout << "City Previously Searched\n";
	}

	else
	{
		Error(SEARCH_ERROR);
	}
}

////////////////////////////////////////////////////////

void Depth_First_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route)
{
	int city1, city2, city3, city4;
	int distance1, distance2, distance3, distance4;
	int new_city, new_distance, new_nodes;
	int city_num = 0;
	char *new_route;


	// DEBUG //
	cout << "<";
	r.Print_City_Name(start_city);
	cout << "> -> ";
	// DEBUG //


	if ((start_city != end_city) && !(r.Is_City_Searched(start_city)) && (!search_finished))
	{
		r.Mark_City_As_Searched(start_city);

		r.Get_Connecting_Cities(start_city, city1, distance1, city2, distance2, city3, distance3, city4, distance4);


		// DEBUG //
		cout << "( ";
		r.Print_City_Name(city1);
		cout << " ";
		r.Print_City_Name(city2);
		cout << " ";
		r.Print_City_Name(city3);
		cout << " ";
		r.Print_City_Name(city4);
		cout << " )\n";
		// DEBUG //


		// Put existing cities in searching queue

		if ((city1 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city1, total_distance + distance1, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			Depth_First_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city2 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city2, total_distance + distance2, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			Depth_First_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city3 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city3, total_distance + distance3, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			Depth_First_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city4 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city4, total_distance + distance4, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			Depth_First_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}
	}

	else if ((start_city == end_city) && (!search_finished)) // Destination city is found
	{
		cout << "Destination City Found!\n\n";

		cout << "Sequence of Cities: ";

		int x = 0;
		while (full_route[x] != 0)
		{
			cout << full_route[x] << " ";
			x++;
		}
		cout << "\n";

		cout << "Total Distance Traveled: " << total_distance << "\n";
		cout << "Total Nodes Traveled: " << total_nodes << "\n";
		cout << "Total Number of Nodes Enqueued: " << r.Total_Nodes_Enqueued() << "\n\n";

		search_finished = true; // Set global variable
	}

	else if (search_finished) // Search is Finished
	{
		cout << "Search Finished\n";
	}

	else if (r.Is_City_Searched(start_city)) // City previously searched
	{
		cout << "City Previously Searched\n";
	}

	else
	{
		Error(SEARCH_ERROR);
	}
}

////////////////////////////////////////////////////////

void A_Star_Search(Romania &r, int start_city, int end_city, int total_distance, int total_nodes, char *full_route)
{
	int city1, city2, city3, city4;
	int distance1, distance2, distance3, distance4;
	int new_city, new_distance, new_nodes;
	int city_num = 0;
	char *new_route;


	// DEBUG //
	cout << "<";
	r.Print_City_Name(start_city);
	cout << "> -> ";
	// DEBUG //


	if ((start_city != end_city) && !(r.Is_City_Searched(start_city)) && (!search_finished))
	{
		r.Mark_City_As_Searched(start_city);

		r.Get_Connecting_Cities(start_city, city1, distance1, city2, distance2, city3, distance3, city4, distance4);


		// DEBUG //
		cout << "( ";
		r.Print_City_Name(city1);
		cout << " ";
		r.Print_City_Name(city2);
		cout << " ";
		r.Print_City_Name(city3);
		cout << " ";
		r.Print_City_Name(city4);
		cout << " )\n";
		// DEBUG //


		// Set NULL VALUE high - patchwork

		if (city1 == 0)
			distance1 = NULL_VALUE;
		if (city2 == 0)
			distance2 = NULL_VALUE;
		if (city3 == 0)
			distance3 = NULL_VALUE;
		if (city4 == 0)
			distance4 = NULL_VALUE;

		// Check to see if any of the cities are the end city

		if (city1 == end_city)
		{
			// City1 is already in position
		}

		else if (city2 == end_city)
		{
			Swap(city1, distance1, city2, distance2);
		}

		else if (city3 == end_city)
		{
			Swap(city1, distance1, city3, distance3);
		}

		else if (city4 == end_city)
		{
			Swap(city1, distance1, city4, distance4);
		}

		// Adjust so that the cities are ordered from closest city to farthest city away

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 < distance3)
				&& (distance2 < distance4) && (distance3 < distance4)) // 1 2 3 4
		{
			// Cities are already ordered
		}

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 < distance3)
				&& (distance2 < distance4) && (distance3 > distance4)) // 1 2 4 3
		{
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 > distance3)
				&& (distance2 < distance4) && (distance3 < distance4)) // 1 3 2 4
		{
			Swap(city2, distance2, city3, distance3);
		}

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 > distance3)
				&& (distance2 > distance4) && (distance3 < distance4)) // 1 3 4 2
		{
			Swap(city2, distance2, city4, distance4);
			Swap(city2, distance2, city3, distance3);
		}

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 < distance3)
				&& (distance2 > distance4) && (distance3 > distance4)) // 1 4 2 3
		{
			Swap(city2, distance2, city4, distance4);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance1 < distance2) && (distance1 < distance3) && (distance1 < distance4) && (distance2 > distance3)
				&& (distance2 > distance4) && (distance3 > distance4)) // 1 4 3 2
		{
			Swap(city2, distance2, city4, distance4);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 < distance3)
				&& (distance1 < distance4) && (distance3 < distance4)) // 2 1 3 4
		{
			Swap(city1, distance1, city2, distance2);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 < distance3)
				&& (distance1 < distance4) && (distance3 > distance4)) // 2 1 4 3
		{
			Swap(city1, distance1, city2, distance2);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 > distance3)
				&& (distance1 < distance4) && (distance3 < distance4)) // 2 3 1 4
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city1, distance1, city2, distance2);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 > distance3)
				&& (distance1 > distance4) && (distance3 < distance4)) // 2 3 4 1
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city1, distance1, city3, distance3);
			Swap(city1, distance1, city2, distance2);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 < distance3)
				&& (distance1 > distance4) && (distance3 > distance4)) // 2 4 1 3
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city1, distance1, city2, distance2);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance2 < distance1) && (distance2 < distance3) && (distance2 < distance4) && (distance1 > distance3)
				&& (distance1 > distance4) && (distance3 > distance4)) // 2 4 3 1
		{
			Swap(city2, distance2, city4, distance4);
			Swap(city1, distance1, city4, distance4);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 < distance2)
				&& (distance1 < distance4) && (distance2 < distance4)) // 3 1 2 4
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city2, distance2, city3, distance3);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 < distance2)
				&& (distance1 < distance4) && (distance2 > distance4)) // 3 1 4 2
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city2, distance2, city4, distance4);
			Swap(city2, distance2, city3, distance3);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 > distance2)
				&& (distance1 < distance4) && (distance2 < distance4)) // 3 2 1 4
		{
			Swap(city1, distance1, city3, distance3);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 > distance2)
				&& (distance1 > distance4) && (distance2 < distance4)) // 3 2 4 1
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 < distance2)
				&& (distance1 > distance4) && (distance2 > distance4)) // 3 4 1 2
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city2, distance2, city4, distance4);
		}

		else if ((distance3 < distance1) && (distance3 < distance2) && (distance3 < distance4) && (distance1 > distance2)
				&& (distance1 > distance4) && (distance2 > distance4)) // 3 4 2 1
		{
			Swap(city1, distance1, city3, distance3);
			Swap(city2, distance2, city4, distance4);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 < distance2)
				&& (distance1 < distance3) && (distance2 < distance3)) // 4 1 2 3
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city2, distance2, city4, distance4);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 < distance2)
				&& (distance1 < distance3) && (distance2 > distance3)) // 4 1 3 2
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city2, distance2, city4, distance4);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 > distance2)
				&& (distance1 < distance3) && (distance2 < distance3)) // 4 2 1 3
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city3, distance3, city4, distance4);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 > distance2)
				&& (distance1 > distance3) && (distance2 < distance3)) // 4 2 3 1
		{
			Swap(city1, distance1, city4, distance4);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 < distance2)
				&& (distance1 > distance3) && (distance2 > distance3)) // 4 3 1 2
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city2, distance2, city4, distance4);
			Swap(city2, distance2, city3, distance3);
		}

		else if ((distance4 < distance1) && (distance4 < distance2) && (distance4 < distance3) && (distance1 > distance2)
				&& (distance1 > distance3) && (distance2 > distance3)) // 4 3 2 1
		{
			Swap(city1, distance1, city4, distance4);
			Swap(city2, distance2, city3, distance3);
		}

		// Set NULL VALUE low - patchwork

		if (city1 == 0)
			distance1 = 0;
		if (city2 == 0)
			distance2 = 0;
		if (city3 == 0)
			distance3 = 0;
		if (city4 == 0)
			distance4 = 0;

		// Put existing cities in searching queue

		if ((city1 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city1, total_distance + distance1, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			A_Star_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city2 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city2, total_distance + distance2, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			A_Star_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city3 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city3, total_distance + distance3, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			A_Star_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}

		if ((city4 != 0) && (!search_finished))
		{
			r.Put_City_In_Queue(city4, total_distance + distance4, total_nodes + 1, full_route);
			r.Get_City_From_Queue(new_city, new_distance, new_nodes, &new_route);
			A_Star_Search(r, new_city, end_city, new_distance, new_nodes, new_route);
		}
	}

	else if ((start_city == end_city) && (!search_finished)) // Destination city is found
	{
		cout << "Destination City Found!\n\n";

		cout << "Sequence of Cities: ";

		int x = 0;
		while (full_route[x] != 0)
		{
			cout << full_route[x] << " ";
			x++;
		}
		cout << "\n";

		cout << "Total Distance Traveled: " << total_distance << "\n";
		cout << "Total Nodes Traveled: " << total_nodes << "\n";
		cout << "Total Number of Nodes Enqueued: " << r.Total_Nodes_Enqueued() << "\n\n";

		search_finished = true; // Set global variable
	}

	else if (search_finished) // Search is Finished
	{
		cout << "Search Finished\n";
	}

	else if (r.Is_City_Searched(start_city)) // City previously searched
	{
		cout << "City Previously Searched\n";
	}

	else
	{
		Error(SEARCH_ERROR);
	}
}

////////////////////////////////////////////////////////

void Swap(int &city1, int &distance1, int &city2, int &distance2)
{
	int swap_city, swap_distance;

	swap_city = city1;
	swap_distance = distance1;

	city1 = city2;
	distance1 = distance2;

	city2 = swap_city;
	distance2 = swap_distance;
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

	else if (type == SEARCH_ERROR)
	{
		cout << "\nError: Search statement not found.\n";
	}

	exit(-1);
}

////////////////////////////////////////////////////////