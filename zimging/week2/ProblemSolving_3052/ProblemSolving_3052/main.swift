//
//  main.swift
//  ProblemSolving_3052
//
//  Created by YOUJIM on 2023/04/09.
//

import Foundation

var arr = [Int]()

for _ in 0...9 {
    arr.append((Int(readLine()!)! % 42))
}

var input: Set<Int> = Set(arr)

print(input.count)

