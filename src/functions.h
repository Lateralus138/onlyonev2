#pragma once
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <algorithm>
#include <vector>

std::string transformStringCase (std::string str, std::string mode);

bool valueInVectorString
(
	std::vector<std::string> vec,
	bool insensitive,
	std::string value
);

std::vector<std::string> cinToVector (bool skip_empty);

#endif
