#!/usr/bin/swift sh

import Foundation

let segments: [[[Substring]]] = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
    .split(separator: "\n")
    .map { line in
        line.split(separator: "|")
            .map { digits in
                digits.split(separator: " ")
            }
    }

var sum = 0
for line in segments {
    let digits = line[0]
    let output = line[1]
    let one = digits.first { $0.count == 2 }!
    let four = digits.first { $0.count == 4 }!

    func segmentsInCommon(_ firstDigit: Substring, _ secondDigit: Substring) -> Int {
        firstDigit.reduce(0) { count, segment in
            if secondDigit.contains(segment) {
                return count + 1
            }

            return count
        }
    }

    func decode(_ digit: Substring) -> Int {
        switch digit.count {
        case 2:
            return 1
        case 3:
            return 7
        case 4:
            return 4
        case 7:
            return 8
        case 5:
            if segmentsInCommon(digit, one) == 2 {
                return 3
            }
            switch segmentsInCommon(digit, four) {
            case 2:
                return 2
            case 3:
                return 5
            default:
                preconditionFailure("Unknown digit: \(digit)")
            }
        case 6:
            if segmentsInCommon(digit, one) == 1 {
                return 6
            }
            switch segmentsInCommon(digit, four) {
            case 3:
                return 0
            case 4:
                return 9
            default:
                preconditionFailure("Unknown digit: \(digit)")
            }
        default:
            preconditionFailure("Unknown digit: \(digit)")
        }
    }

    var value = 0
    for digit in output {
        value = value * 10
        value = value + decode(digit)
    }

    sum += value
}

print("sum of outputs: \(sum)")
