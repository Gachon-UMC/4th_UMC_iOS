//
//  main.swift
//  ProblemSolving_11650
//
//  Created by YOUJIM on 2023/04/09.
//

import Foundation

let N = Int(readLine()!)!
var coordinate = [(Int, Int)] ()

for _ in 0..<N {
    let value = readLine()!.components(separatedBy: " ").map {Int($0)!}
    coordinate.append((value[0], value[1]))
}

coordinate.sort { (a, b) in
    if a.0 == b.0 {
        return a.1 < b.1
    }
    return a.0 < b.0
}

for i in coordinate {
    print(i.0, i.1)
}
