#ifndef FUNCTIONS_H_INCLUDE
#define FUNCTIONS_H_INCLUDE

#include <algorithm>
#include <vector>

inline std::string transformStringCase (std::string str, std::string mode = "upper")
{
	if (mode == "upper") std::transform (str.begin(), str.end (), str.begin (),::toupper);
	else std::transform (str.begin(), str.end (), str.begin (),::tolower);
	return str;
}

inline bool valueInVectorString
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
	std::string needle = transformStringCase (value);
	for (auto str : vec)
	{
		std::string	stack = transformStringCase (str);
		if (needle == stack) return true;
	}
	return false;
}

inline std::vector<std::string> cinToVector ()
{
	std::vector<std::string> stdin;
	std::string line;
	while (getline (std::cin,line)) stdin.push_back (line);
	return stdin;
}

#endif