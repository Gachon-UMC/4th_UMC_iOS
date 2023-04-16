//
//  main.swift
//  train_optional_guard
//
//  Created by YOUJIM on 2023/04/16.
//

import Foundation

//var city: String? = "Seoul"
////print(city)
//
//city = nil
//print(city)
//
//var num1:Int? = 20
//var num2:Int = 100

//num1 = num2
//num2 = num1
//let sum = num1 + num2

//var food: String? = "Pizza"
////
////print(food)
////print(food!)
//
//food = nil
//print(food!)

//let tmpString : String? = "Hello"
////if let
//if let opt1 = tmpString {
//    print(opt1)
//}else{
//    print("값 없음")
//}
//
////guard let
//func bindingWithGuard() {
//    guard let opt2 = tmpString else{
//        //값 0
//        return
////        //값 x
////    }
////}
//
//
//let x : Int? = 10
//let y : Int? = nil
//
//if let xx = x {
//    print("x = \(xx)")
//}
//else {
//    print("x is Optional")
//}
//
//if let yy = y {
//    print("y = \(yy)")
//}
//
//let name1 : String?
//let name2 : String?
//
//name1 = "Song"
//name2 = "Kim"
//
//if let nameFirst = name1,
//   let nameSecond = name2 {
//    print(nameFirst, nameSecond)
//}

let x : Int? = 10
let y : Int? = nil

func opbinding() {

    guard let xx = x else {
        return print("x is Optional")
    }
    print(xx)

    guard let yy = y else {
        return print("y is Optional")
    }
    print(yy)
}

opbinding()
