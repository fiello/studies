#include <string>
#include <iostream>
#include <vector>

typedef std::vector<std::vector<int>> Matrix;

inline bool isStartOfPath(int row, int column) {
    return row == 0 && column == 0;
}

bool findPath(Matrix& matrix, int row, int column, std::vector<std::pair<int, int>>& path) {
    if (row < 0 || column < 0 || matrix[row][column] == -1)
        return false;
    
    if (isStartOfPath(row, column) || findPath(matrix, row -1, column, path) || findPath(matrix, row, column - 1, path)) {
        const std::pair <int, int> newPoint(row, column);
        path.push_back(newPoint);
        return true;
    }
    
    return false;
}

void expandMatrix(Matrix& array, std::size_t rows, std::size_t cols) {
    std::vector<int> row;
    for (int i = 0; i < rows; ++i) {
        row.clear();
        for (int j = 0; j < cols; ++j) {
            row.push_back(0);
        }
        array.push_back(row);
    }
}

void printArray(const Matrix& matrix) {
    std::cout << std::endl;
    for (auto& row : matrix) {
        for (auto& cell : row)
            std::cout << cell << "   ";
        std::cout << std::endl;
    }
    std::cout << std::endl;
}


int main(void) {
    const std::size_t col = 5;
    const std::size_t row = 4;
    Matrix matrix;
    expandMatrix(matrix, row, col);
    printArray(matrix);
    
    matrix[1][1] = -1;
    matrix[2][3] = -1;
    matrix[3][1] = -1;
    matrix[0][4] = -1;
    matrix[0][1] = -1;
   // matrix[3][3] = -1; // cause of "no path"
    printArray(matrix);
    
    std::vector<std::pair<int, int>> path;
    if (findPath(matrix, row-1, col-1, path)) {
        std::cout << "Result: " << path.size();
        for (auto& point : path)
            std::cout << ", path: " << point.first << ":" << point.second << " ";
    } else {
        std::cout << "No path";
    }
    std::cout << std::endl;
    return 0;
}

