//
//  main.swift
//  ProblemSolving_2447
//
//  Created by YOUJIM on 2023/04/15.
//

import Foundation

func drawStar(x: Int, y: Int, input: Int) -> Void {
    if input == 1 {
        coordinate[y][x] = "*"
        return
    }
    
    let div = input / 3
    for i in 0 ..< 3 {
        for j in 0 ..< 3 {
            if i == 1 && j == 1 {}
            else {
                drawStar(x: x + (j * div), y: y + (i * div), input: div)
            }
        }
    }
}

func printStar() {
    for i in 0 ..< Int(input) {
        for j in 0 ..< Int(input) {
            print(coordinate[i][j], terminator: "")
        }
        print("")
    }
}

let input = Float(readLine()!)!
var k : Int = 0

for i in 1...7 {
    if input == powf(3.0, Float(i)) {
        k = i
        break
    }
}

var coordinate : [[String]] = Array(repeating: Array(repeating: " ", count: Int(powf(3.0, Float(k)))), count: Int(powf(3.0, Float(k))))

drawStar(x: 0, y: 0, input: Int(input))
printStar()

