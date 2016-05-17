//: Playground - noun: a place where people can play

protocol Waveable
{
    func getCell(row: Int, col: Int) -> Cell?
}


class Cell
{
    var row: Int
    var col: Int
    var value: Int
    var wave: Int
    var parent: Waveable
    
    init(row: Int, col: Int, parent: Waveable)
    {
        self.row = row
        self.col = col
        self.value = 0
        self.wave = 0
        self.parent = parent
    }
    
    func left() -> Cell?
    {
        return parent.getCell(row, col: col - 1)
    }
    
    func right() -> Cell?
    {
        return parent.getCell(row, col: col + 1)
    }
    
    func up() -> Cell?
    {
        return parent.getCell(row - 1, col: col)
    }
    
    func down() -> Cell?
    {
        return parent.getCell(row + 1, col: col)
    }
    
    func isEqualPosition(cell: Cell?) -> Bool
    {
        if cell == nil
        {
            return false
        }
        return cell!.col == self.col && cell!.row == self.row;
    }
}

class Board : Waveable
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
                rowToAppend.append(Cell(row: row, col: col, parent: self))
            }
            data.append(rowToAppend)
        }
    }
    
    func findPath(srcRow: Int, srcCol: Int, dstRow: Int, dstCol: Int) -> Bool
    {
        if (!isValidRow(srcRow) || !isValidRow(dstRow) ||
            !isValidCol(srcCol) || !isValidCol(dstCol))
        {
            print("invalid input parameters")
            return false
        }
        
        let srcCell = data[srcRow][srcCol]
        let dstCell = data[dstRow][dstCol]
        if (srcCell.value != 0 || dstCell.value != 0)
        {
            print("there cannot be a path between two cell where one of them is taken already")
            return false
        }
        
        let path = startWave(srcCell, dstCell: dstCell)
        //calmArray()
        return !path.isEmpty
    }
    
    func startWave(srcCell: Cell, dstCell: Cell) -> Array<Cell>
    {
        var currentWave = Array<Cell>();
        currentWave.append(srcCell)
        srcCell.wave = 1;
        return sendNextWave(dstCell, currentWave: currentWave)
    }
    
    func sendNextWave(dstCell: Cell, currentWave: Array<Cell>) -> Array<Cell>
    {
        var nextWave = Array<Cell>()
       
        for cell in currentWave
        {
            if dstCell.isEqualPosition(cell)
            {
                nextWave.append(cell)
                return nextWave;
            }
            
            let left = cell.left()
            let right = cell.right()
            let up = cell.up()
            let down = cell.down()
            
            appendToWaveIfValid(&nextWave, sourceCell: cell, newCell: left)
            appendToWaveIfValid(&nextWave, sourceCell: cell, newCell: right)
            appendToWaveIfValid(&nextWave, sourceCell: cell, newCell: up)
            appendToWaveIfValid(&nextWave, sourceCell: cell, newCell: down)
        }
        
        if nextWave.isEmpty
        {
            return Array<Cell>()
        }
            
        return sendNextWave(dstCell, currentWave: nextWave)
    }
    
    func appendToWaveIfValid(inout wave:Array<Cell>, sourceCell: Cell, newCell: Cell?)
    {
        if let nc = newCell where nc.value == 0 && nc.wave == 0
        {
            newCell!.wave = sourceCell.wave + 1
            wave.append(newCell!)
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
    
    func isValidRow(rowNum: Int) -> Bool
    {
        return rowNum >= 0 && rowNum < self.height
    }
    
    func isValidCol(colNum: Int) -> Bool
    {
        return colNum >= 0 && colNum < self.width
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
    
    // Waveable protocol implementation
    func getCell(row: Int, col: Int) -> Cell?
    {
        if isValidRow(row) && isValidCol(col)
        {
            return data[row][col]
        }
        return nil
    }
}

let numberOfRows : Int = 5;
let numberOfColumns : Int = 5;

var brd = Board(height: numberOfRows, width: numberOfColumns)
brd.printArray()
brd.data[0][4].value = 1;
brd.data[1][3].value = 1;
brd.data[2][2].value = 1;
brd.data[3][1].value = 1;
brd.data[4][0].value = 1;

brd.printArray("gated board")
if brd.findPath(0, srcCol: 0, dstRow: 1	, dstCol: 4)
{
    print("ok")
}
else
{
    print("failure!")
}

brd.printArray("waved")
