#!/usr/bin/swift sh

import Foundation

let positions = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: ",")
    .map { Int($0)! }
    .sorted()
let half = positions.count / 2
var median: Int
if positions.count % 2 == 0 {
    median = (positions[half - 1] + positions[half]) / 2
} else {
    median = positions[half]
}
var fuel = positions.reduce(0) { (fuel, position) in fuel + abs(position - median)}
print("\(fuel) units of fuel required to reach position \(median)")
