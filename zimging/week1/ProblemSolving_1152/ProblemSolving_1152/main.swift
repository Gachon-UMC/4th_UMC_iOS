//import Foundation
//
//let sentence = readLine()!
//let lengthOfSentence = sentence.count
//var count = 1
//
//for i in 0...lengthOfSentence {
//    if i == 0 {
//        continue
//    }
//    else if i == lengthOfSentence - 1 {
//        break
//    }
//    else if sentence[sentence.index(sentence.startIndex, offsetBy: i)] == " " {
//        count += 1
//    }
//}
//print(count)

import Foundation

let sentence = readLine()!
var toArr = sentence.components(separatedBy: " ")
let lastIndex = toArr.index(before: toArr.endIndex)

for i in (0...lastIndex).reversed() {
    if toArr[i] == "" {
        toArr.remove(at: i)
    }
}

print(toArr.count)

//let toArr = readLine()!.split(separator: " ")
//print(toArr.count)
