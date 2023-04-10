
let input = readLine()!
let input_U = input.uppercased()

var Counts: [[Int]] = []

var countDict = [Character: Int]()

for i in input_U {
    if countDict.keys.contains(i) {
        countDict[i]! += 1
    } else {
        countDict[i] = 1
    }
}

var pri_key: Character
var pri_val: Int = 0
var result: Character = "!"

for (key,val) in countDict {
    if val > pri_val {
        result = key
        pri_val = val
    } else if val == pri_val {
        result = "?"
    } else { }
}

print(result)
