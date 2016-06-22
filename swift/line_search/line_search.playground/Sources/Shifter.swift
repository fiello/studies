

public class Shifter
{
    var rules : Array<ShiftRule>
    
    public init(rules: Array<ShiftRule>)
    {
        self.rules = rules
    }
    
    
    
}


// enumerate() method?
// pass Waveable inside, and enumerate will be returning Array<Array<Cell>> of the given shit we need. Aka array of paths...
// Shifter inside will know all of its rules and dimension of upper Array will be at max the number of rules?