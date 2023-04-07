let input_Arr = readLine()!.split(separator: " ").map{Int($0)!}

let a = input_Arr[0]
let b = input_Arr[1]
let c = input_Arr[2]

let input_set = Set(input_Arr)

if input_set.count == 1{
    print(input_set.first! * 1000 + 10000)
} else if input_set.count == 2{
    if a == b {
        print(a * 100 + 1000)
    } else if b == c {
        print(b * 100 + 1000)
    } else {
        print(c * 100 + 1000)
    }
} else {
    print(input_Arr.max()! * 100)
}
