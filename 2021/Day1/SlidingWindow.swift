#!/usr/bin/swift sh

import Foundation

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let measurements = input.split(separator: "\n").map { Int($0)! }
var sums = [Int]()
for index in 0...measurements.count - 3 {
    sums.append(measurements[index] + measurements[index + 1] + measurements[index + 2])
}
var previous = Int.max
var sumsLargerThanPrevious = 0
for sum in sums {
    if sum > previous {
        sumsLargerThanPrevious += 1
    }
    previous = sum
}

print(sumsLargerThanPrevious)
