import Foundation

public class Day9: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    func parseInput(_ input: String) -> [[Int]] {
        let lines = input.split(whereSeparator: \.isNewline)
        return lines.map { $0.split(whereSeparator: \.isWhitespace).map { Int($0)! } }
    }

    func extrapolate(_ history: [Int], right: Bool) -> Int {
        var layers: [[Int]] = [history]
        var cur = history
        while true {
            var result: [Int] = []

            for i in 0..<(cur.count - 1) {
                result.append(cur[i+1] - cur[i])
            }
            if result.reduce(0, +) == 0 { break }
            layers.append(result)
            cur = result
        }

        var result = 0
        for layer in layers.reversed() {
            if right {
                result = result + layer.last!
            } else {
                result = layer.first! - result 
            }
        }
        return result
    }

    func runFirst(_ input: String) -> String {
        let data = parseInput(input)

        var result = 0
        for history in data {
            result += extrapolate(history, right: true)
        }
        return "\(result)"
    }

    func runSecond(_ input: String) -> String {
        let data = parseInput(input)

        var result = 0
        for history in data {
            result += extrapolate(history, right: false)
        }
        return "\(result)"
    }
}
