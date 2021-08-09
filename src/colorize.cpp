#include "colorize.h"
#include <iostream>

void colorize_transform (std::string & str, int clrs[], int csize)
{
	std::string clrstr = "\x1b[";
	for (auto index = 0; index < csize; index++)
	{
		if (index > 0) clrstr.push_back (';');
		clrstr.append (std::to_string (clrs[index]));
	}
	clrstr.push_back ('m');
	str = clrstr + str + "\x1b[0m";
}

std::string colorize (std::string str, int clrs[], int csize)
{
	std::string clrstr = "\x1b[";
	for (auto index = 0; index < csize; index++)
	{
		if (index > 0) clrstr.push_back (';');
		clrstr.append (std::to_string (clrs[index]));
	}
	clrstr.push_back ('m');
	return clrstr + str +"\x1b[0m";
}
