#!/usr/bin/swift sh

import Foundation

enum Direction: String {
    case up
    case down
    case forward
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let commands = input.split(separator: "\n").map { command -> (Direction, Int) in
    let tokens = command.split(separator: " ")
    return (Direction(rawValue: String(tokens[0]))!, Int(tokens[1])!)
}
var horizontal = 0
var depth = 0
var aim = 0
for (direction, units) in commands {
    switch (direction) {
    case .up:
        aim = aim - units
    case .down:
        aim = aim + units
    case .forward:
        horizontal = horizontal + units
        depth = depth + (aim * units)
    }
}

print("horizontal times depth: \(horizontal * depth)")
