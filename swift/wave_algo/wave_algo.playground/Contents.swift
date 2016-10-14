//: Playground - noun: a place where people can play

let numberOfRows : Int = 5;
let numberOfColumns : Int = 5;

var brd = Board(height: numberOfRows, width: numberOfColumns)
brd.printArray()
brd.data[1][0].value = 1;
brd.data[1][1].value = 1;
brd.data[1][2].value = 1;
brd.data[1][3].value = 1;
brd.data[3][1].value = 1;
brd.data[3][2].value = 1;
brd.data[3][3].value = 1;
brd.data[3][4].value = 1;

brd.printArray(msg: "gated board")
var path = Array<Cell>()
if brd.findPath(srcRow: 0, srcCol: 0, dstRow: 4, dstCol: 2, path: &path)
{
    print("ok")
}
else
{
    print("failure!")
}


