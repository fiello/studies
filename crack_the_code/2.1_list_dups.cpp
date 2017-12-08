#include <list>
#include <algorithm>
#include <iostream>
#include <unordered_set>

// helper generator
std::list<int> generateList(int size) {
    std::list<int> temp = {1, 2, 3, 4, 5, 6, 6, 6, 7, 7, 7, 5, 5, 9, 0};
    /*for (int i = 0; i < size; ++i) {
     temp.push_back(rand() % 10);
     }*/
    return temp;
}

void printList(std::list<int> input) {
    for (auto& a : input)
        std::cout << a << " ";
    std::cout << std::endl;
}

// remove duplicate
// O(N2) - double pointers
void removeDups(std::list<int>& input) {
    std::list<int>::iterator itA, itB;
    bool moveA = false;
    itA = input.begin();
    while (itA != input.end()) {
        itB = itA;
        ++itB;
        while(itB != input.end()) {
            if (*itA == *itB) {
                itB = input.erase(itB);
            } else {
                ++itB;
            }
        }
        ++itA;
    }
}

// O(N) + hash map
void removeDupsN(std::list<int>& input) {
    std::unordered_set<int> temp;
    std::list<int>::iterator it = input.begin();
    while (it != input.end()) {
        if (temp.count(*it)) {
            it = input.erase(it);
        }
        else {
            temp.insert(*it);
            ++it;
        }
    }
}

// main func
int main(void) {
    std::list<int> ex = generateList(20);
    printList(ex);
    removeDups(ex);
    printList(ex);
}
