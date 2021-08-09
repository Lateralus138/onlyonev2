// OnlyOne Linux version
#include "colorize.h"
#include "functions.h"
#include <stdio.h>
#include <unistd.h>
#include <regex>
#include <filesystem>
#include <fstream>

int main (int argc, char *argv[])
{
  std::vector<std::string> argv_copy, argv_uniq;
  bool case_insensitive = false;
	if (!isatty(fileno(stdin))) argv_copy = cinToVector (true);
  if (argc > 1)
  {
    auto skip = false;
    std::regex helprgx ("^-([hH]|-[hH][eE][lL][pP])$");
    std::regex casergx ("^-([iI]|-[iI][nN][sS][eE][nN][sS][iI][tT][iI][vV][eE])$");
    std::regex filergx ("^-([fF]|-[fF][iI][lL][eE])$");
  	for (auto index = 1; index < argc; index++)
  	{
      if (std::regex_match (argv[index], helprgx))
      {
        std::string usage_clr_str = "USAGE";
        std::string options_clr_str = "OPTIONS";
        std::string arg_clr_str = "ARGUMENT";
        std::string param_clr_str = "PARAMETER";
        std::string err_clr_str = "ERRORS";
        const std::string EMPTY_LINE = "                                                  ";
        int red_clr [] = {1, 91},
            blue_clr [] = {1, 94},
            yellow_clr [] = {1, 93},
            green_clr [] = {1, 92},
            magenta_clr [] = {1, 95};
        colorize_transform (usage_clr_str, yellow_clr, 2);
        colorize_transform (options_clr_str, green_clr, 2);
        colorize_transform (arg_clr_str, blue_clr, 2);
        colorize_transform (param_clr_str, magenta_clr, 2);
        colorize_transform (err_clr_str, red_clr, 2);
        std::cout <<
          EMPTY_LINE << '\n' <<
          " \'OnlyOne\' - Get unique lines from a file, piped  " << '\n' <<
          " stdin, or passed arguments in the command line.  " << '\n' <<
          EMPTY_LINE << '\n' <<
          ' ' << usage_clr_str <<
          ":                                           " << '\n' <<
          "     onlyone <" << options_clr_str <<
          " <" << param_clr_str << ">> <"<<
          arg_clr_str << ">     " << '\n' <<
          EMPTY_LINE << '\n' <<
          ' ' << options_clr_str <<
          ":                                         " << '\n' <<
          "     -h, --help          This help message.       " << '\n' <<
          "     -i, --insensitive   Tests are case           " << '\n' <<
          "                         insensitive.             " << '\n' <<
          "     -f, --file          Add the lines of a       " << '\n' <<
          "                         <FILE> to the queue.     " << '\n' <<
          EMPTY_LINE << '\n' <<
          ' ' << param_clr_str <<
          ":                                       " << '\n' <<
          "     FILE:   Path to a file to read line by line. " << '\n' <<
          EMPTY_LINE << '\n' <<
          ' ' << arg_clr_str <<
          ":                                       " << '\n' <<
          "     LINES:  Additional strings passed directly   " << '\n' <<
          "             to the program delimited by a space. " << '\n' <<
          "             Wrap the strings in quotes for proper" << '\n' <<
          "             formatting.                          " << '\n' <<
          EMPTY_LINE << '\n' <<
          ' ' << err_clr_str <<
          ":                                          " << '\n' <<
          "     1   Not enough parameters passed to FILE." << '\n' <<
          "     2   FILE does not exist.                 " << '\n' <<
          "     3   FILE is not a regular file.          " << '\n' <<
          "     4   Could not open FILE.                 " << '\n' <<
          EMPTY_LINE << std::endl;
        return 0;
      }
      if (std::regex_match (argv[index], casergx))
      {
        case_insensitive = true;
        continue;
      }
      if (std::regex_match (argv[index], filergx))
      {
        if (index + 1 > argc - 1) return 1;
        const std::string FILEPATH = argv[index + 1];
        if (!std::filesystem::exists (FILEPATH)) return 2;
        if (!std::filesystem::is_regular_file (FILEPATH)) return 3;
        std::ifstream file_stream (FILEPATH);
        if (!file_stream) return 4;
        skip = true;
        std::string this_line;
        while (std::getline (file_stream, this_line))
        {
          argv_copy.push_back (this_line);
        }
        file_stream.close ();
        continue;
      }
      if (!skip) argv_copy.push_back (argv[index]);
      else skip = false;
  	}
  }
    if (!argv_copy.empty ())
    {
      for (auto index = 0; index < (int) argv_copy.size (); index++)
      {
        if (!valueInVectorString (argv_uniq, case_insensitive, argv_copy[index]))
          argv_uniq.push_back (argv_copy[index]);
      }
    }
    if (!argv_uniq.empty ())
    {
      for (auto index = 0; index < (int) argv_uniq.size (); index++)
      {
        std::cout << argv_uniq[index] << std::endl;
      }
    }
}
