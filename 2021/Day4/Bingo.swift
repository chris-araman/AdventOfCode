#!/usr/bin/swift sh

import Foundation

class Board {
    var rows: [[Int]]
    private let marked = -1

    init(_ rows: [[Int]]) {
        self.rows = rows
    }

    func mark(_ call: Int) {
        for row in 0...rows.count-1 {
            for column in 0...rows.count-1 where rows[row][column] == call {
                rows[row][column] = marked
            }
        }
    }

    var winner : Bool {
        get {
            for row in rows where (row.allSatisfy { $0 == marked }) {
                return true
            }
            for column in 1...rows[0].count where (rows.allSatisfy { $0[column - 1] == marked }) {
                return true
            }
            return false
        }
    }

    var sumOfUnmarkedSquares : Int {
        get {
            var sum = 0
            for row in rows {
                for square in row where square != marked {
                    sum += square
                }
            }
            return sum
        }
    }
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
var lines = input.split(separator: "\n")
var calls = lines[0].split(separator: ",").map { Int($0)! }

func play() {
    var boards = [Board]()
    var line = 1
    while line < lines.count {
        var rows = [[Int]]()
        for line in line...line+4 {
            rows.append(lines[line].split(separator: " ").map { Int($0)! })
        }

        boards.append(Board(rows))
        line = line + 5
    }

    for call in calls {
        for board in boards {
            board.mark(call)
            if board.winner {
                print("winner! score: \(board.sumOfUnmarkedSquares * call)")
                return
            }
        }
    }

    print("no winner")
}

play()

