let input = readLine()!.split(separator: " ").map{Int($0)}
let A = input[0]!
let B = input[1]!

for i in ["+", "-", "*", "/", "%"] {
    switch i {
    case "+":
        print(A+B)
    case "-":
        print(A-B)
    case "*":
        print(A*B)
    case "/":
        print(A/B)
    case "%":
        print(A%B)
    default:
        print("none")
    }
}

//https://www.acmicpc.net/problem/10869
//사실 조건은 따로 안붙여줘도 되나봅니다
