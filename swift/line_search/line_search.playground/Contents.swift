//: Playground - noun: a place where people can play

var brd = Board(height: 10, width: 10)

brd.data[0][0].value = 2
brd.data[0][1].value = 2
brd.data[0][2].value = 2
brd.data[0][3].value = 2
brd.data[0][4].value = 1

brd.data[0][2].value = 2
brd.data[1][2].value = 2
brd.data[2][2].value = 2
brd.data[3][2].value = 2
brd.data[4][2].value = 2

brd.data[1][1].value = 2


brd.printArray(msg: "gated board")
var shifter = Shifter(parent: brd)
let paths = shifter.enumeratePaths(fromCell: brd.data[2][2])

for path in paths
{
    brd.printPath(path: path)
}
