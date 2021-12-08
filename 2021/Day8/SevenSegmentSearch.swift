#!/usr/bin/swift sh

import Foundation

let segmentCounts: [[Int]] = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
    .split(separator: "\n")
    .map { line in
        line.split(separator: "|")[1]
            .split(separator: " ")
            .map { $0.count }
    }
var ones = 0
var fours = 0
var sevens = 0
var eights = 0
for line in segmentCounts {
    for count in line {
        switch count {
        case 2:
            ones = ones + 1
        case 3:
            sevens = sevens + 1
        case 4:
            fours = fours + 1
        case 7:
            eights = eights + 1
        default:
            break
        }
    }
}

print("\(ones + fours + sevens + eights) ones, fours, sevens and eights")
