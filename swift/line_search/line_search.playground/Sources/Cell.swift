
public class Cell
{
    public typealias CellValidator = (Cell?) -> Bool
    
    public private(set) var row: Int
    public private(set) var col: Int
    public var value: Int
    public var wave: Int// for Board class to be able to iterate/change/wave
    var parent: Waveable

    public init(row: Int, col: Int, parent: Waveable)
    {
        self.row = row
        self.col = col
        self.value = 0
        self.parent = parent
        
        self.wave = 0
    }
    
    public func getNeighbours(validator : CellValidator? = nil) -> Array<Cell>
    {
        var neighbours = Array<Cell>()
        typealias CellGetter = () -> (Cell?)
        let captureCell = {
            (getCell: CellGetter, validator : CellValidator?, inout cells: Array<Cell>) -> Void in
            if let nc = getCell()
            {
                if let vl = validator where !vl(nc)
                {
                    return;
                }
                cells.append(nc)
            }
        }
        
        captureCell(left, validator, &neighbours)
        captureCell(right, validator, &neighbours)
        captureCell(up, validator, &neighbours)
        captureCell(down, validator, &neighbours)
        return neighbours
    }
    
    public func isBusy() -> Bool
    {
        return value != 0
    }
    
    public func left() -> Cell?
    {
        return parent.getCell(row, col: col - 1)
    }
    
    public func right() -> Cell?
    {
        return parent.getCell(row, col: col + 1)
    }
    
    public func up() -> Cell?
    {
        return parent.getCell(row - 1, col: col)
    }
    
    public func down() -> Cell?
    {
        return parent.getCell(row + 1, col: col)
    }
    
    public func isEqualPosition(cell: Cell?) -> Bool
    {
        if cell == nil
        {
            return false
        }
        return cell!.col == self.col && cell!.row == self.row;
    }
}
