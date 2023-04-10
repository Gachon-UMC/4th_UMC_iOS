let input = readLine()!
//ex) "one4seveneight" ->   1478

enum Nums: Int, CaseIterable,CustomStringConvertible{
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    
    var description: String {
        return "\(self)"
    }
}

var startIndex = input.startIndex
var result = ""

while startIndex < input.endIndex {
    for num in Nums.allCases {
        let numStr = String(describing: num) //Nums case의 case이름 가져오기
        for char in input {
            if input.hasPrefix(numStr) {
                result += String(num.rawValue)
                break
        }
        }
    }
}

// while문에 rangeof와 enum을 써서 해당하는 내용을 전부 바꿔주게 구현해보자잉
//https://school.programmers.co.kr/learn/courses/30/lessons/81301?language=swift
