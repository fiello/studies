//: Playground - noun: a place where people can play

class Cell
{
    var row: Int
    var col: Int
    var value: Int
    var wave: Int
    
    init(row: Int, col: Int)
    {
        self.row = row
        self.col = col
        self.value = 0
        self.wave = 0
    }
}

class Board
{
    var height: Int
    var width: Int
    var data: Array<Array<Cell>>
    
    init(height: Int, width: Int)
    {
        self.height = height
        self.width = width
        self.data = Array<Array<Cell>>()
        populateArray(height, columns: width)
        calmArray()
    }

    func populateArray(rows: Int, columns: Int)
    {
        data.removeAll();
        for row in 0..<rows
        {
            var rowToAppend = Array<Cell>()
            for col in 0..<columns
            {
                rowToAppend.append(Cell(row: row, col: col))
            }
            data.append(rowToAppend)
        }
    }
    
    func calmArray()
    {
        for row in data
        {
            for cell in row
            {
                cell.wave = 0;
            }
        }
    }
    
    func printArray(msg: String = "")
    {
        if (!msg.isEmpty)
        {
            print("\(msg)")
        }
    
        for row in data
        {
            for cell in row
            {
                print("\(cell.value)(\(cell.wave))", terminator: " ")
            }
            print("")
        }
        print("")
    }
}

let numberOfRows : Int = 5;
let numberOfColumns : Int = 5;

var brd = Board(height: numberOfRows, width: numberOfColumns)
brd.printArray()
brd.data[1][3].value = 1;
brd.data[2][2].value = 1;
brd.data[3][1].value = 1;
brd.printArray("gated board")


