#include <stdlib.h>
#include <iostream.h>
#include <fstream.h>
#include <string.h>
#include <math.h> //can get rid of this if change Is_In_Range() in Pass_One()
#include "Table.h"
#include "Pass_One.h"
#include "Pass_Two.h"

void main(int argc, char *argv[], char *envp[] )
{
  if (argc < 5)
  {
    cerr << "\nUsage: Compiler <source_file> <intermediate_file> <object_file> <listing_file>\n";
    exit(1);
  }

  //declare and open file streams

  ifstream source;
  ofstream intermediate;
  ofstream obj;
  ofstream listing;

  source.open(argv[1]);
  intermediate.open(argv[2]);
  obj.open(argv[3]);
  listing.open(argv[4]);

  //create tables

  Table literal_table(50);
  Table symbol_table(100);
  ENT_Table ent_table(50);
  Table ext_table(50);
  int location_counter = 0;

  Pass_One(source, intermediate, listing, location_counter, symbol_table, literal_table, ent_table, ext_table);
  source.close();
  source.open(argv[1]);
  intermediate.close();
  ifstream middlein;
  middlein.open(argv[2]);
  Pass_Two(source, middlein, obj, listing, symbol_table, literal_table, ent_table, ext_table);
  cout << "Object file created successfully.\n";
  exit(1);
}
