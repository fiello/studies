
func printArray<T>(array: [[T]], _ msg: String = "")
{
    if (!msg.isEmpty)
    {
        print("\(msg)")
    }
    
    for row in array
    {
        for cell in row
        {
            print("\(cell)", terminator: " ")
        }
        print("")
    }
    print("")
}


let numberOfRows : Int = 5;
let numberOfColumns : Int = 5;

var board = Array<Array<Int>>();
for row in 0..<numberOfRows
{
    board.append(Array(count: numberOfColumns, repeatedValue: Int()));
}

printArray(board)
board[1][3] = 1;
board[2][2] = 1;
board[3][1] = 1;
printArray(board, "gated board")

