let N = Int(readLine()!)!

for i in 1...N {
    for j in 0..<N-i {
        print(" ", terminator: "")
    }
    for k in 0..<i {
        print("*", terminator: "")
    }
    print("")
}
