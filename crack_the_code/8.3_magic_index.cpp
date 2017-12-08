#include <string>
#include <iostream>
#include <vector>
#include <algorithm>

bool findIndex(const std::vector<int>& digits, int startIndex, int endIndex, int& index) {
    const int middle = (startIndex + endIndex) / 2;
    if (startIndex < 0 || endIndex >= digits.size() || middle >= digits.size() || endIndex < startIndex)
        return false;

    if (digits[middle] == middle) {
        // we are in a sweet spot
        index = middle;
        return true;
    }

    // below is optimization for when digits are not actually distinct
    const int leftMost = std::min(middle - 1, digits[middle]);
    if (findIndex(digits, startIndex, leftMost, index)) {
        return true;
    }

    const int rightMost = std::max(middle + 1, digits[middle]);
    if (findIndex(digits, rightMost, endIndex, index)) {
        return true;
    }

    return false;
}

bool findIndex(const std::vector<int>& digits, int& index) {
    /*
    index = 20, value = 40 -> given sorted and distinct integers, right value will only increase linearly and index is not going to catch up with it; need to look left, same func as above but on smaller scope (binary search)
    */
    return findIndex(digits, 0, digits.size() - 1, index);
}


int main(void) {
    std::vector<int> digitList = { -5, -2, 0, 2, 4, 7, 9, 11 };

    int index = -1;
    if (findIndex(digitList, index)) {
        std::cout << "found index: " << index << std::endl;
    }
    else {
        std::cout << "no magic index" << std::endl;
    }

    return 0;
}

