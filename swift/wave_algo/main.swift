
func printArray<T>(array: [[T]])
{
    for row in array
    {
        for cell in row
        {
            print("\(cell)", terminator: " ")
        }
        print("")
    }
    
}


let numberOfRows : Int = 5;
let numberOfColumns : Int = 5;

var board = Array<Array<Int>>();
for row in 0..<numberOfRows
{
    board.append(Array(count: numberOfColumns, repeatedValue: Int()));
}

printArray(board)