
public class HorizontalRule : ShiftRule
{
    // ShiftRule protocol
    public func step(direction: ShiftDirection, fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        switch direction
        {
        case .Back:
            return stepBack(fromRow: fromRow, fromCol: fromCol)
        case .Forward:
            return stepForward(fromRow: fromRow, fromCol: fromCol)
            
        }
    }
    
    private func stepBack(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow, fromCol - 1)
    }
    
    private func stepForward(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow, fromCol + 1)
    }
}

public class VerticalRule : ShiftRule
{
    // ShiftRule protocol
    public func step(direction: ShiftDirection, fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        switch direction
        {
        case .Back:
            return stepUp(fromRow: fromRow, fromCol: fromCol)
        case .Forward:
            return stepDown(fromRow: fromRow, fromCol: fromCol)
            
        }
    }
    
    private func stepUp(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow - 1, fromCol)
    }
    
    private func stepDown(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow + 1, fromCol)
    }
}

public class DiagonalRule : ShiftRule
{
    // ShiftRule protocol
    public func step(direction: ShiftDirection, fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        switch direction
        {
        case .Back:
            return stepBackUp(fromRow: fromRow, fromCol: fromCol)
        case .Forward:
            return stepForwardDown(fromRow: fromRow, fromCol: fromCol)
            
        }
    }
    
    private func stepBackUp(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow - 1, fromCol - 1)
    }
    
    private func stepForwardDown(fromRow: Int, fromCol: Int) -> (Int, Int)
    {
        return (fromRow + 1, fromCol + 1)
    }
}

