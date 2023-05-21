let NMArr = readLine()!.split(separator: " ").map{Int($0)!}
let N = NMArr[0]
let M = NMArr[1]

var neverHeard = Set<String>()
var neverSeen = Set<String>()

for _ in 0..<N {
    neverHeard.insert(readLine()!)
}
for _ in 0..<M {
    neverSeen.insert(readLine()!)
}

let neverHS = neverHeard.intersection(neverSeen).map{$0}

print(neverHS.count)
for element in neverHS.sorted() {
    print(element)
}
