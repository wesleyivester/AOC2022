#include <fstream>
#include <string>
#include <deque>
#include <vector>
#include <algorithm>

int main()
{
	std::fstream file("C:/Users/Wesley/Desktop/AOC 2022/1/input");
	std::vector<std::string> lines;
	std::string line;
	while (!file.eof())
	{
		std::getline(file, line);
		lines.push_back(line);
	}

	std::deque<int> maxes;
	maxes.push_back(0);
	int curr = 0;
	for (int i(0); i < lines.size(); ++i)
	{
		if (lines[i].size() == 0)
		{
			if (curr >= maxes.front())
			{
				maxes.push_back(curr);
				if (maxes.size() > 3)
					maxes.pop_front();
				std::sort(maxes.begin(), maxes.end());
			}
			curr = 0;
		}
		else
		{
			curr += std::stoul(lines[i]);
		}
	}
	int sum = 0;
	for (int i(0); i < 3; ++i)
		sum += maxes[i];

	return 0;
}