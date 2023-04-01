var word = readLine()!.uppercased()
var letterFrequency = [Int](repeating: 0, count: 26)
var maximumValue = -1
var maximumLetter = -1


for letter in word {
    if letter == " " {
        break
    }
    else {
        letterFrequency[Int(letter.asciiValue!) - 65] += 1
    }
}

var temp = 0
for frequency in letterFrequency {
    if frequency > maximumValue {
        maximumValue = letterFrequency[temp]
        maximumLetter = temp
    }
    temp += 1
}

temp = 0
for frequency in letterFrequency {
    if frequency == maximumValue {
        if maximumLetter != temp {
            print("?")
            break
        }
    }
    temp += 1
}

if temp == 26 {
    print(String(UnicodeScalar(maximumLetter + 65)!))
}
