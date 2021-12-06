#!/usr/bin/swift sh

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    init?(_ token: Substring) {
        guard token != "->" else {
            return nil
        }

        let point = token.split(separator: ",").map {
            Int($0)!
        }

        self.init(point[0], point[1])
    }
}

struct Line {
    let start: Point
    let end: Point

    var horizontal: Bool {
        get {
            start.y == end.y
        }
    }

    var vertical: Bool {
        get {
            start.x == end.x
        }
    }

    var points: [Point] {
        let length = max(abs(end.x - start.x), abs(end.y - start.y))
        let incrementX = vertical ? 0 : start.x < end.x ? 1 : -1
        let incrementY = horizontal ? 0 : start.y < end.y ? 1 : -1
        return (0...length).map { point in
            Point(start.x + (point * incrementX), start.y + (point * incrementY))
        }
    }

    init(_ start: Point, _ end: Point) {
        self.start = start
        self.end = end
    }

    init(_ token: Substring) {
        let line = token.split(separator: " ").compactMap {
            Point($0)
        }

        self.init(line[0], line[1])
    }
}

class Sea {
    var sea = [Point: Int]()
    var danger = 0

    func mark(_ line: Line) {
        for point in line.points {
            mark(point)
        }
    }

    private func mark(_ point: Point) {
        if let previous = sea[point] {
            sea[point] = previous + 1
            if previous == 1 {
                danger = danger + 1
            }
        } else {
            sea[point] = 1
        }
    }
}

let sea = Sea()
let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
let lines = input.split(separator: "\n").map { Line($0) }
for line in lines {
    sea.mark(line)
}

print("danger points: \(sea.danger)")
