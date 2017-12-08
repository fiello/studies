#include <string>
#include <iostream>
#include <algorithm>
#include <unordered_set>

// O(N^2)
bool isUniqueN2(const std::string& input) {
    if (input.empty())
        return false;
    
    for (int i = 0; i < input.size(); ++i)
        for (int j = i+1; j < input.size(); ++j)
            if (input[i] == input[j])
                return false;
    
    return true;
}

// O(N), using hash map
bool isUniqueN(const std::string& input) {
    std::unordered_set<char> alphabet;
    for (int i = 0; i < input.size(); ++i) {
        if (alphabet.count(input[i]))
            return false;
        alphabet.insert(input[i]);
    }
    return true;
}

// O(NlogN + N), using sort + linear search
bool isUnique(const std::string& input) {
    std::string temp = input;
    std::sort(temp.begin(), temp.end());
    for (int i = 0; i < temp.size(); ++i) {
        if ( ((i + 1) < temp.size())  && (temp[i + 1] == temp[i]) )
            return false;
    }
    return true;
}

// main execution
int main(void) {
    const std::string ex("whatifIelyousr");
    std::cout << "Word '" << ex << "' is unique: " << isUnique(ex) << std::endl;
    return 0;
}

