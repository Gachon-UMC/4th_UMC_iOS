var flag = true
var A:Int = 0
var B:Int = 0

while flag == true {
    //print("-10000~10000에 해당하는 두 수 입력")
    let input = readLine()!
    let input_a = input.split(separator: " ")

    A = Int(input_a[0])!
    B = Int(input_a[1])!

    if A >= -10000 && A <= 10000 && B >= -10000 && B <= 10000 {
        flag = false
    }
}

if A > B { print(">") }
else if A < B { print("<") }
else { print("==") }

