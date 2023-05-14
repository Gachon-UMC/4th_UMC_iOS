import Foundation

while let line = readLine() {
    if line == "." {
        break
    }
    
    var stack = [Character]()
    var isBalanced = true
    
    for c in line {
        if c == "(" || c == "[" {
            stack.append(c)
        } else if c == ")" {
            if let top = stack.last, top == "(" {
                stack.removeLast()
            } else {
                isBalanced = false
                break
            }
        } else if c == "]" {
            if let top = stack.last, top == "[" {
                stack.removeLast()
            } else {
                isBalanced = false
                break
            }
        }
    }
    
    if !stack.isEmpty {
        isBalanced = false
    }
    
    print(isBalanced ? "yes" : "no")
}
