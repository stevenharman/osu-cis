// romania.h

#ifndef ROMANIA_H
#define ROMANIA_H 1

#include <iostream.h>
#include <stdlib.h>
#include <string.h>

#include "constants.h"


class Romania
{
	public:

Romania();

void Get_Connecting_Cities(int current_city, int &city1, int &distance1, int &city2, int &distance2,
						   int &city3, int &distance3, int &city4, int &distance4);

void Put_City_In_Queue(int city, int distance, int nodes, char *route);

void Get_City_From_Queue(int &city, int &distance, int &nodes, char **route);

int Total_Nodes_Enqueued();

void Mark_City_As_Searched(int city);

bool Is_City_Searched(int city);

void Print_City_Name(int city);


	private:

int connecting_cities[MAX_CITIES][MAX_CONNECTIONS]; // Contains the map of Romania
int city_distances[MAX_CITIES][MAX_CONNECTIONS];
int number_of_connecting_cities[MAX_CITIES];

int location_searched[MAX_CITIES]; // Indicates if the location has already been searched

int queue_start;
int queue_end;
int city_queue[MAX_QUEUE_LENGTH][3]; // Queue for searching for cities
char city_route[MAX_QUEUE_LENGTH][MAX_ROUTE_LENGTH]; // Queue for city route


};



#endif