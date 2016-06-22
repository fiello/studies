
public enum ShiftDirection
{
    case Back
    case Forward
}

public protocol ShiftRule
{
    func step(direction: ShiftDirection, fromX: Int, fromY: Int) -> (Int, Int)
}

public class HorizontalRule : ShiftRule
{
    // ShiftRule protocol
    public func step(direction: ShiftDirection, fromX: Int, fromY: Int) -> (Int, Int)
    {
        switch direction
        {
        case .Back:
            return stepBack(fromX, fromY: fromY)
        case .Forward:
            return stepForward(fromX, fromY: fromY)
            
        }
    }
    
    private func stepBack(fromX: Int, fromY: Int) -> (Int, Int)
    {
        return (fromX - 1, fromY)
    }
    
    private func stepForward(fromX: Int, fromY: Int) -> (Int, Int)
    {
        return (fromX + 1, fromY)
    }
}
