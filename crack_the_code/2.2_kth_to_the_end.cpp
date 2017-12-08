#include <string>
#include <iostream>
#include <list>

std::list<int> generateList(int size) {
    std::list<int> temp = {1, 2, 3, 4};
    /*for (int i = 0; i < size; ++i) {
     temp.push_back(rand() % 10);
     }*/
    return temp;
}

void printList(const std::list<int> input) {
    for (const auto& a : input)
        std::cout << a << " ";
    std::cout << std::endl;
}

std::list<int>::const_iterator shiftBy(const std::list<int>& input, int k) {
    std::list<int>::const_iterator shifted = input.begin();
    for (int i = 0; i < k; ++i)
    {
        ++shifted;
        if (shifted == input.end())
            break;
    }
    return shifted;
}

// O(n), using ahead-of-K iterator
int getKthElement(const std::list<int>& input, int k) {
    if (k < 0)
        return -1;
    std::list<int>::const_iterator shifted = shiftBy(input, k);
    if (shifted == input.end())
        return -1;
    
    std::list<int>::const_iterator itA = input.begin();
    while (shifted != input.end()) {
        if (++shifted != input.end())
            ++itA;
    }
    return *itA;
}

// main execution
int main(void) {
    std::list<int> ex = generateList(20);
    printList(ex);
    const int k = 2;
    std::cout << k << "th element from end is " << getKthElement(ex, k) << std::endl;
}

