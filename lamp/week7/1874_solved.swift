class Stack {
    var myStack:[Int] = [] //풀이에 쓰이는 스택
    var result_arr:[Int] = [] // 결과용 임시 배열
    var pushpopOrder:[Character] = [] //push, pop 결과 순서 배열
    var insert_num: Int = 1
    var NoFlag: Bool = false
    
    
    func push() {
        if self.myStack.count < n {
            self.myStack.append(insert_num)
            pushpopOrder.append("+")
            insert_num += 1
        }else {
            self.NoFlag = true
        }
    }
    
    func pop() {
        if self.myStack.count > 0 {
            result_arr.append(self.myStack.removeLast())
            pushpopOrder.append("-")
        }else {
            self.NoFlag = true
        }
    }
    
}

var myStack = Stack()


let n = Int(readLine()!)!
var input_arr:[Int] = []

for _ in 1...n {
    input_arr.append(Int(readLine()!)!)
}

for current_num in input_arr {
    
    if myStack.insert_num == current_num { // 일치함
        myStack.push()
        myStack.pop()
    }else if myStack.insert_num > current_num { //스택에 이미 있음
        myStack.pop()
        if current_num != myStack.result_arr.last {
            myStack.NoFlag = true
        }
    }else if myStack.insert_num < current_num { //스택에 없어서 더 올려야함
        while myStack.insert_num < current_num {
            myStack.push()
        }
        myStack.push()
        myStack.pop()
    }
    
    if myStack.NoFlag == true {
        break
    }
}

if myStack.NoFlag {
    print("NO") 
} else{
    for i in myStack.pushpopOrder{
        print(i)
    }
}
//print("input: ", input_arr)
//print("result: ", myStack.result_arr)
//print("pushpop: ", myStack.pushpopOrder)

//insert_num이 for문으로 1부터 n까지 순차적 진행될때도 나중에 해보자
