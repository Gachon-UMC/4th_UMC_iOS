//https://www.acmicpc.net/status?from_problem=1&problem_id=2588
let input1 = Int(readLine()!)!
let input2 = readLine()!

for i in input2.reversed() {
    print(input1 * Int(String(i))!)
}
print(input1*Int(input2)!)
