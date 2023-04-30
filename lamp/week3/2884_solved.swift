let input = readLine()!
let in_arr = input.split(separator: " ")

var H = Int(in_arr[0])!
var M = Int(in_arr[1])!


if M-45 < 0 {
    if H-1 < 0{
        H += 23
    } else {
        H -= 1
    }
    M += 15
} else {
    M -= 45
}

print(H,M)

//https://www.acmicpc.net/problem/2884
