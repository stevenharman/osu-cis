#include <stdlib.h>
#include <iostream.h>
#include <fstream.h>
#include <stdio.h>
#include "Machine.h"

void main(int argc, char *argv[], char *envp[])
{
  if (argc < 5)
  {
    cerr << "\nUsage: Simulator <executable_input> <program_input> <program_output> <trace_output>\n";
    exit(1);
  }
  Machine m;

  fstream main_input;
  main_input.open(argv[1], ios::in);
  fstream aux_input;
  aux_input.open(argv[2], ios::in);
  fstream outs;
  outs.open(argv[3], ios::out);
  fstream t_outs;
  t_outs.open(argv[4], ios::out);

  //     ifstream main_input(argv[1]);
  //     ifstream aux_input(argv[2]);
  //     ofstream outs(argv[3]);
  //     ofstream t_outs(argv[4]);

  m.Load_This(main_input, outs, t_outs);
  outs << "\nBegin Program Output:\n";
  m.Simulate_This(aux_input, outs, t_outs);
  outs << "\n:End Program Output\n";

  t_outs << "\nFinal Register, PC, and Memory Values:\n";
  p.Dump_Regs(t_outs);
  t_outs << '\n';
  mem.Dump_Mem(t_outs);
  t_outs << "\nProgram ended normally.\n";

  main_input.close();
  aux_input.close();
  outs.close();
  t_outs.close();

  exit(1);
}
