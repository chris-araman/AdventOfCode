#!/usr/bin/swift sh

import Foundation

func common(_ numbers: [[Bool]], _ comparison: (Int, Int) -> Bool) -> Int {
    let bitcount = numbers[0].count
    var bits = (1...bitcount).reduce(numbers) { (numbers, bit) in
        if numbers.count == 1 {
            return numbers
        }

        var ones = [[Bool]]()
        var zeroes = [[Bool]]()
        for number in numbers {
            if number[bit - 1] {
                ones.append(number)
            } else {
                zeroes.append(number)
            }
        }

        // let half = numbers.count / 2
        return comparison(ones.count, zeroes.count) ? ones : zeroes
    }[0]

    var value = 0
    for bit in bits {
        value = value * 2
        if bit {
            value = value + 1
        }
    }

    return value
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let numbers = input.split(separator: "\n").map { number -> [Bool] in
    var bits = [Bool]()
    for bit in number {
        bits.append(bit == "1")
    }
    return bits
}
var oxygen = common(numbers, >=)
var co2 = common(numbers, <)
print("life support rating: \(oxygen * co2)")
