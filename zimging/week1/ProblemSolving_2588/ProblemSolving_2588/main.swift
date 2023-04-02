import Foundation

let inputVal1 = Int(readLine()!)!
let inputVal2 = Int(readLine()!)!

let hundredsOfVal2 = inputVal2 / 100 //백의 자리 계산
let tensOfVal2 = inputVal2 / 10 - hundredsOfVal2 * 10 //십의 자리 계산
let unitsOfVal2 = inputVal2 - hundredsOfVal2 * 100 - tensOfVal2 * 10 //일의 자리 계산

print(inputVal1 * unitsOfVal2)
print(inputVal1 * tensOfVal2)
print(inputVal1 * hundredsOfVal2)
print(inputVal1 * inputVal2)
