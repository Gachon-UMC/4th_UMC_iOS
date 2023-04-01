//import Foundation

let T = Int(readLine()!)!

for i in 1...T {
    let input = readLine()!.split(separator: " ").map {
        Int(String($0))!
    }
    print("Case #\(i): \(input[0] + input[1])")
}

