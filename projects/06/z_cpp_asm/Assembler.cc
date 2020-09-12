#include <fstream>
#include <iostream>
#include <string>
using namespace std;

class Parser {
 public:
  string inputFile;
  Parser(string filePath) { inputFile = filePath; }

  bool hasMoreCommands();
  void advance();
  string commandType();
  string symbol();
  string dest();
  string comp();
  string jump();
};

bool Parser::hasMoreCommands() { return false; }

void Parser::advance() { cout << this->inputFile << endl; }

string Parser::commandType() { return "commandT"; }
string Parser::symbol() { return "sy"; }
string Parser::dest() { return "de"; }
string Parser::comp() { return "co"; }
string Parser::jump() { return "ju"; }

int main() {
  string inputFilePath;
  string outputFilePath;
  cin >> inputFilePath >> outputFilePath;
  ifstream ifs(inputFilePath);
  ofstream ofs(outputFilePath);

  string fileContent;
  if (ifs.fail()) {
    cerr << "Failed to open file." << endl;
    return -1;
  }

  while (getline(ifs, fileContent)) {
    ofs << "#" << fileContent << endl;
  }

  return 0;
}
