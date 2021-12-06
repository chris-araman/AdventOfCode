#!/usr/bin/swift sh

import Foundation

// fishes[daysLeft]: fishCount
var fishes = [Int](repeating: 0, count: 9)
let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: ",")
    .map { Int($0)! }
for daysLeft in input {
    fishes[daysLeft] = fishes[daysLeft] + 1
}

let days = 256
for day in 1...days {
    var babies = fishes.removeFirst()
    fishes[6] = fishes[6] + babies
    fishes.append(babies)
}

var count = fishes.reduce(0) { (sum, count) in sum + count }
print("fishes after \(days) days: \(count)")
