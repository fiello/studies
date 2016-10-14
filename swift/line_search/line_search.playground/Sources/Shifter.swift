

public class Shifter
{
    var rules : Array<ShiftRule>
    var parent : Waveable
    
    public init(parent: Waveable)
    {
        self.parent = parent;
        self.rules = [ShiftRule]()
        rules.append(HorizontalRule())
        rules.append(VerticalRule())
        rules.append(DiagonalRule())
    }

    //protocol Shiftable
    public func enumeratePaths(fromCell: Cell) -> [[Cell]]
    {
        print("Buldig paths crossing the following cell \(fromCell.row):\(fromCell.col)...")

        
        var paths = [[Cell]]()
        for rule in rules
        {
            var newPath = [Cell]()
            var currCell : Cell? = fromCell;
            let pathNavigator = {
                (parent: Waveable, direction: ShiftDirection, currCell: inout Cell?) -> Void in
                let shiftedPosition = rule.step(direction: direction, fromRow: currCell!.row, fromCol: currCell!.col)
                if let nc = parent.getCell(row: shiftedPosition.0, col: shiftedPosition.1), nc.value == fromCell.value
                {
                    currCell = nc
                }
                else
                {
                    currCell = nil
                }
            }
            
            
            // iterate back
            while currCell != nil && currCell!.value == fromCell.value
            {
                newPath.append(currCell!)
                pathNavigator(parent, ShiftDirection.Back, &currCell)
            }
            
            //iterate forward
            currCell = fromCell
            while currCell != nil && currCell!.value == fromCell.value
            {
                if !fromCell.isEqualPosition(cell: currCell!)
                { // to skip first iteration
                    newPath.append(currCell!)
                }
                pathNavigator(parent, ShiftDirection.Forward, &currCell)
            }
            
            if newPath.count > 1 // we need only paths with more than 1 element, because single element would be start cell
            {
                paths.append(newPath)
            }
        }

        return paths
    }
}


// enumerate() method?
// pass Waveable inside, and enumerate will be returning Array<Array<Cell>> of the given shit we need. Aka array of paths...
// Shifter inside will know all of its rules and dimension of upper Array will be at max the number of rules?
