//
//  main.swift
//  ProblemSolving_1874
//
//  Created by YOUJIM on 2023/05/16.
//

import Foundation

var numOfCase = Int(readLine()!)!
var inputSequence = [Int]()
var sequence = [Int]()
var arrayToPrint = [String]()
var i = 1
var isBreak = 0

for _ in 1...numOfCase {
    
    let element = Int(readLine()!)!
    inputSequence.append(element)
    
    while i <= element {
        sequence.append(i)
        i += 1
        arrayToPrint.append("+")
    }
    if sequence[sequence.endIndex - 1] == element {
        _ = sequence.popLast()
        arrayToPrint.append("-")
    }
    else {
        isBreak = 1
    }
}

if isBreak == 0 {
    for value in arrayToPrint { print(value) }
}
else {
    print("NO")
}
