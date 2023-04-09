//
//  main.swift
//  ProblemSolving_10813
//
//  Created by YOUJIM on 2023/04/06.
//

import Foundation

//N과 M을 받아옴
var input = readLine()!.split(separator: " ").map{Int($0)!}
let N = input[0]
let M : Int = input[1]

//바구니 배열 선언, 번호는 index와 같다고 생각
//공을 배열 속 요소처럼 생각
var basket = [Int]()


//exchangeBall에 1부터 N까지 넣어주는 과정
for i in 0 ..< N {
    basket.append(i + 1)
}

//한 줄씩 바꾸고 싶은 인덱스 두 개를 읽어오고, 값을 swapAt()을 이용해 바꿔준다
//공 번호는 1부터 시작하고 배열 인덱스는 0부터 시작하므로 1씩 빼준다
for _ in 1...M {
    input = readLine()!.split(separator: " ").map{Int($0)!}
    basket.swapAt(input[0] - 1, input[1] - 1)
}

//출력 형식에 맞춰 출력한다
basket[0...].forEach { print($0, terminator: " ") }
