import Foundation

func isVPS(_ str: String) -> Bool {
    var stack = [Character]()
    
    for char in str {
        if char == "(" {
            stack.append(char)
        } else {
            if stack.isEmpty {
                return false
            } else { //when char is ")"
                stack.removeLast()
            }
        }
    }
    
    return stack.isEmpty
}

let t = Int(readLine()!)!

for _ in 0..<t {
    let str = readLine()!
    if isVPS(str) {
        print("YES")
    } else {
        print("NO")
    }
}
