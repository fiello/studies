public class Board : Waveable
{
    var height: Int
    var width: Int
    public var data: Array<Array<Cell>>
    
    public init(height: Int, width: Int)
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
    
    public func findPath(srcRow: Int, srcCol: Int, dstRow: Int, dstCol: Int, inout path: Array<Cell>) -> Bool
    {
        if (!isValidRow(srcRow) || !isValidRow(dstRow) ||
            !isValidCol(srcCol) || !isValidCol(dstCol))
        {
            print("invalid input parameters")
            return false
        }
        
        let srcCell = data[srcRow][srcCol]
        let dstCell = data[dstRow][dstCol]
        if (srcCell.isBusy() || dstCell.isBusy())
        {
            print("there cannot be a path between two cell where one of them is taken already")
            return false
        }
        
        path.removeAll()
        if canSendWaveToDestination(srcCell, dstCell: dstCell)
        {
            path = buildReversePath(srcCell, dstCell: dstCell)
            path = path.reverse()
        }
        calmArray() // comment here if want to see "waved" array
        return !path.isEmpty
    }
    
    func canSendWaveToDestination(srcCell: Cell, dstCell: Cell) -> Bool
    {
        var currentWave = Array<Cell>();
        currentWave.append(srcCell)
        srcCell.wave = 1; // mark initial cell as 1, all the rest are yet untouched and carry 0 - "calm"
        return !sendNextWave(dstCell, currentWave: currentWave).isEmpty
    }
    
    // set of recursive functioins that will return only when we reach dst or dead end
    func sendNextWave(dstCell: Cell, currentWave: Array<Cell>) -> Array<Cell>
    {
        var nextWave = Array<Cell>()
        
        for cell in currentWave
        {
            if dstCell.isEqualPosition(cell)
            {
                // we are at destination point, throw current wave array back to top
                nextWave.append(cell)
                return nextWave;
            }
            
            appendToWaveIfValid(&nextWave, sourceCell: cell)
        }
        
        if nextWave.isEmpty
        {
            // if we are unable to compile new wave we are at the dead end, throw empty array back
            return Array<Cell>()
        }
        
        return sendNextWave(dstCell, currentWave: nextWave)
    }
    
    // inspect all neighbours of given cell, and if valid (non-busy and "calm") - add to given wave
    func appendToWaveIfValid(inout wave:Array<Cell>, sourceCell: Cell)
    {
        let validator : Cell.CellValidator = {(cell: Cell?) -> Bool in
            if let nc = cell where !nc.isBusy() && !nc.isWaved() // we are interested in fresh cells only - free and "unwaved"
            {
                return true;
            }
            return false
        }
        let newCells = sourceCell.getNeighbours(validator)
        for newCell in newCells
        {
            newCell.wave = sourceCell.wave + 1
            wave.append(newCell)
        }
    }
    
    // starts with destination cell and moves back to source using wave numbers
    // returns shortest path from dst back to source based on the contents of "waved" array
    func buildReversePath(srcCell : Cell, dstCell: Cell) -> Array<Cell>
    {
        var path = Array<Cell>()
        path.append(dstCell)
        var nextCell: Cell?
        nextCell = dstCell
        let wavedEmptyCell : Cell.CellValidator = {(cell: Cell?) -> Bool in
            if let nc = cell where !nc.isBusy() && nc.isWaved()
            {
                return true;
            }
            return false
        }
        
        while !srcCell.isEqualPosition(nextCell)
        {
            let smallWaveNeighbours = nextCell!.getNeighbours(wavedEmptyCell);
            if smallWaveNeighbours.isEmpty
            {
                // should never end up here, worth an assert?
                path.removeAll()
                break;
            }
            else
            {
                // amongst all "waved" cell surrounding us pick the one with smalles wave number
                for cell in smallWaveNeighbours
                {
                    if cell.wave < nextCell!.wave
                    {
                        nextCell = cell
                    }
                }
                // once found append it to final array as it's our way back to src cell
                path.append(nextCell!)
            }
        }
        return path
    }
    
    // wipes all "wave" values for array to be ready for new search
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
    
    // see if row is in constraints of current board and does not jump out of borders
    func isValidRow(rowNum: Int) -> Bool
    {
        return rowNum >= 0 && rowNum < self.height
    }
    
    // same as isValidRow but for columns
    func isValidCol(colNum: Int) -> Bool
    {
        return colNum >= 0 && colNum < self.width
    }
    
    // prints current array with "wave" contents
    public func printArray(msg: String = "")
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
    
    // prints path of cells using row:cell pair - basically, coordinates
    public func printPath(path: Array<Cell>, msg: String = "")
    {
        if (!msg.isEmpty)
        {
            print("\(msg)")
        }
        
        print("Path:", terminator: " ")
        for cell in path
        {
            print("\(cell.row):\(cell.col)", terminator: " ")
        }
        print("")
    }
    
    // Waveable protocol implementation
    public func getCell(row: Int, col: Int) -> Cell?
    {
        if isValidRow(row) && isValidCol(col)
        {
            return data[row][col]
        }
        return nil
    }
}
