
public enum ShiftDirection
{
    case Back
    case Forward
}

public protocol ShiftRule
{
    func step(direction: ShiftDirection, fromRow: Int, fromCol: Int) -> (Int, Int)
}

