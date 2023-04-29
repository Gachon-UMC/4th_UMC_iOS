struct member {
    var age: Int
    var name: String
}

func quickSort(_ array: [member]) -> [member] {
    if array.count <= 1 {
        return array
    }
    
    let pivot = array[array.count / 2]
    let left = array.filter { $0.age < pivot.age}
    let middle = array.filter { $0.age == pivot.age }
    let right = array.filter { $0.age > pivot.age }
    
    return quickSort(left) + middle + quickSort(right)
}

let T = Int(readLine()!)!
var arr: [member] = Array(repeating: member(age: 0, name: ""), count: T)

for i in 0..<T {
    let input = readLine()!.split(separator: " ")
    arr[i].age = Int(input[0])!
    arr[i].name = String(input[1])
}


let res_arr = quickSort(arr)
for i in res_arr {
    print(String(i.age),i.name)
}
