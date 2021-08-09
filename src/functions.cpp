#include "functions.h"
#include <iostream>

std::string transformStringCase (std::string str, std::string mode)
{
	if (mode == "upper") std::transform (str.begin(), str.end (), str.begin (),::toupper);
	else std::transform (str.begin(), str.end (), str.begin (),::tolower);
	return str;
}

bool valueInVectorString
(
	std::vector<std::string> vec,
	bool insensitive,
	std::string value
)
{
	if (!insensitive)
	{
		return (std::find(vec.begin(), vec.end(), value) != vec.end());
	}
	std::string needle = transformStringCase (value, "upper");
	for (auto str : vec)
	{
		std::string	stack = transformStringCase (str, "upper");
		if (needle == stack) return true;
	}
	return false;
}

std::vector<std::string> cinToVector (bool skip_empty)
{
	std::vector<std::string> stdin;
	std::string line;
	while (getline (std::cin,line))
	{
		if (skip_empty && line.length () > 0 && line != "\0")
		{
			stdin.push_back (line);
		}
		else
		{
			stdin.push_back (line);
		}
	}
	return stdin;
}
