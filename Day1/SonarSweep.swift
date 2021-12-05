#!/usr/bin/swift sh

import Foundation

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let measurements = input.split(separator: "\n").map { Int($0)! }
var previous = Int.max
var measurementsLargerThanPrevious = 0
for measurement in measurements {
    if measurement > previous {
        measurementsLargerThanPrevious += 1
    }
    previous = measurement
}

print(measurementsLargerThanPrevious)
