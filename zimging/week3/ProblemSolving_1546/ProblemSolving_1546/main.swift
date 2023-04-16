//
//  main.swift
//  ProblemSolving_1546
//
//  Created by YOUJIM on 2023/04/14.
//

import Foundation

let n = Int(readLine()!)!
var input = readLine()!.components(separatedBy: " ").map {Float($0)!}
var largestNum: Float = -1.0

for i in 0..<n {
    if input[i] > largestNum {
        largestNum = input[i]
    }
}

var total: Float = 0

for i in 0..<n {
    input[i] = (input[i] / largestNum * 100)
    total = total + input[i]
}

print(total/Float(n))
