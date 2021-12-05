#!/usr/bin/swift sh

import Foundation

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let numbers = input.split(separator: "\n").map { number -> [Bool] in
    var bits = [Bool]()
    for bit in number {
        bits.append(bit == "1")
    }
    return bits
}
let bitcount = numbers[0].count
let half = numbers.count / 2
var gamma: Decimal = (1...bitcount).reduce(0) { (previous, bit) in
    gamma = previous * 2
    var ones = 0
    for number in numbers where number[bit - 1] {
        ones = ones + 1
        if ones > half {
            gamma = gamma + 1
            break
        }
    }
    return gamma
}
var epsilon = pow(2, bitcount) - gamma - 1
print("power consumption: \(gamma * epsilon)")
