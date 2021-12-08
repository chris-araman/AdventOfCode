#!/usr/bin/swift sh

import Foundation

func fuelRequired(at position: Int) -> Int {
    positions.reduce(0) { (total, otherPosition) in
        let distance = abs(otherPosition - position)
        let fuel = distance + (distance * (distance - 1) / 2)
        return total + fuel
    }
}

let positions = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: ",")
    .map { Int($0)! }
var min = positions.min()!
var max = positions.max()!
var position = (min + max) / 2
var fuel = fuelRequired(at: position)
while (min < position || position < max) {
    if min < position {
        let leftPosition = (min + position) / 2
        let leftFuel = fuelRequired(at: leftPosition)
        if leftFuel < fuel {
            max = position - 1
            position = leftPosition
            fuel = leftFuel
            continue
        }

        min = leftPosition + 1
    }

    if position < max {
        let rightPosition = (position + max + 1) / 2
        let rightFuel = fuelRequired(at: rightPosition)
        if rightFuel < fuel {
            min = position + 1
            position = rightPosition
            fuel = rightFuel
            continue
        }

        max = rightPosition - 1
    }
}

print("\(fuel) units of fuel required to reach position \(position)")
