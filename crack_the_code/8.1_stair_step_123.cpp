
#include <string>
#include <iostream>
#include <vector>
#include <map>

std::map<int, std::vector<std::vector<long>>> stepMemory;

void appendArrays(std::vector<std::vector<long>>& target, std::vector<std::vector<long>>& source, long n, long step) {
    for (long i = 0; i < source.size(); ++i)
    {
        if (n != 0)
            source[i].push_back(step);
        target.push_back(source[i]);
    }
}

void decompose(long n, long step, const std::vector<long>& allowedSteps, std::vector<std::vector<long>>& decomposition) {
    if (n < 0) {
        return;
    } else if (n == 0) {
        std::vector<long> simple = {step};
        decomposition.push_back(simple);
    } else if (stepMemory.count(n) != 0) {
        decomposition = stepMemory[n];
    } else {
        std::vector<std::vector<long>> splits;
        for (long i = 0; i < allowedSteps.size(); ++i) {
            splits.clear();
            decompose(n - allowedSteps[i], allowedSteps[i], allowedSteps, splits);
            appendArrays(decomposition, splits, n - allowedSteps[i], allowedSteps[i]);
        }
        stepMemory[n] = decomposition;
    }
}

void decompose(long n, const std::vector<long>& allowedSteps, std::vector<std::vector<long>>& decomposition) {
    decompose(n, 0, allowedSteps, decomposition);
}

void print(const std::vector<std::vector<long>>& decomposition) {
    for (auto& a : decomposition) {
        for (auto& b : a) {
            std::cout << b << " ";
        }
        std::cout << std::endl;
    }
}

long countSteps(long n) {
    if (n < 0) {
        return 0;
    } else if (n == 0) {
        return 1;
    } else {
        return countSteps(n-1) + countSteps(n-2) + countSteps(n-3);
    }
    
}

int main(void) {
    const long n = 5;
    std::vector<long> allowedSteps = {1, 2, 3};
    std::vector<std::vector<long>> decomposition;
    decompose(n, allowedSteps, decomposition);
    print(decomposition);
    const int result = countSteps(n);
    std::cout << "Simple: " << countSteps(n) << ", complex: " << decomposition.size() << std::endl;
    return 0;
}
