#include <fstream>
#include <iostream>
#include <string>

int main() {
  std::ofstream ofs("./seq.fa");

  ofs << "ACAGTGTGACTTAGCTGTAC" << std::endl;

  ofs << "CCCGGCTTTTATGAG" << std::endl;

  return 0;
}
