//
//  main.swift
//  ProblemSolving_2563
//
//  Created by YOUJIM on 2023/04/07.
//

import Foundation

let numOfPaper = Int(readLine()!)!
var totalArea = 100 * numOfPaper

//2차원 배열 선언
var coordinate = [[Int]](repeating: Array(repeating: 0, count: 2), count: numOfPaper)

//입력 값 저장
for i in 0..<numOfPaper {
    let input = readLine()!.components(separatedBy: " ").map {Int($0)!}
    coordinate[i][0] = input[0]
    coordinate[i][1] = input[1]
}

//x좌표 오름차순으로 정렬
coordinate.sort(by: {$0[0] < $1[0]})

print(coordinate)

for i in 0..<(numOfPaper - 1) {
    for j in (i + 1)...(numOfPaper - 1) {
        print("\(i) \(j)")
        let xrange = coordinate[j][0] - coordinate[i][0]
        let yrange = coordinate[j][1] - coordinate[i][1]
        if xrange < 10 && xrange > 0 { //x좌표 기준으로 두 색종이가 겹치면
            if yrange > 0 && yrange < 10 { //y좌표 기준으로 두 색종이가 겹치면
                print((10 - xrange) * (10 - yrange))
                totalArea = totalArea - ((10 - xrange) * (10 - yrange))
            }
            else if yrange < 0 && yrange > -10 {
                print((10 - xrange) * (10 - yrange))
                totalArea = totalArea - ((10 - xrange) * (10 + yrange))
            }
        }
    }
}

print(totalArea)
