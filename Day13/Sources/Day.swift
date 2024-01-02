import Foundation
import AOCCommon

final class Day: DayType {
    public init() {}
    
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case ._1:
            return runFirst(input)
        case ._2:
            return runSecond(input)
        }
    }

    struct Map {
        var rows: Int
        var cols: Int
        var data: [[String]]

        func transposed() -> Map {
            var result: [[String]] = []
            for col in 0..<cols {
                result.append(getCol(at: col))
            }
            return Map(rows: cols, cols: rows, data: result)
        }

        func score(part2: Bool) -> Int? {
            var result: Int?
            var justFound = false
            var vres: [Int] = []
            for col in 0..<(cols - 1) {
                if justFound { continue }
                let min = min(col + 1, cols - col - 1)
                let range = (col - min + 1)..<((col + min + 1))
                var found = true
                var matches = 0
                var total = 0

                let smudges = part2 ? 1 : 0

                for rcol in range.lowerBound..<(range.lowerBound + range.count / 2) {
                    let pairs = Array(zip(
                        getCol(at: rcol),
                        getCol(at: range.upperBound - 1 - rcol + range.lowerBound)
                    ))
                    let _matches = pairs.reduce(0, { $0 + ($1.0 == $1.1 ? 1 : 0) })
                    matches += _matches
                    total += pairs.count
                    if total - matches > smudges {
                        found = false
                    }
                }
                if found && (total - matches == smudges) {
                    vres.append(col + 1)
                    justFound = true
                }
            }
            result = (result ?? 0) + vres.reduce(0, +)
            return result
        }

        func getRow(at index: Int) -> [String] {
            data[index]
        }

        func getCol(at index: Int) -> [String] {
            data.reduce([]) { $0 + [$1[index]] }
        }

        func draw() {
            for row in 0..<rows {
                var result = ""
                for col in 0..<cols {
                    result += data[row][col]
                }
                print(result)
            }
        }

        init(rows: Int, cols: Int, data: [[String]]) {
            self.rows = rows
            self.cols = cols
            self.data = data
        }

        init<S>(_ strs: [S]) where S: StringProtocol {
            rows = strs.count
            cols = strs[0].count
            data = strs.map { Array($0).map { String($0) } }
        }
    }

    func parseInput(_ input: String) -> [Map] {
        let lines = input.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)

        var maps: [Map] = []
        var buf: [String] = []
        for line in lines {
            if line.isEmpty {
                maps.append(Map(buf))
                buf = []
                continue
            }
            buf.append(String(line))
        }
        maps.append(Map(buf))
        return maps
    }

    func runFirst(_ input: String) -> String {
        let maps = parseInput(input)
        var sum = 0
        for map in maps {
            let score1 = map.score(part2: false) ?? 0
            let tmap = map.transposed()
            let score2 = tmap.score(part2: false) ?? 0
            sum += score1 + score2 * 100
        }
        return "\(sum)"
    }

    func runSecond(_ input: String) -> String {
        let maps = parseInput(input)
        var sum = 0
        for map in maps {
            let score1 = map.score(part2: true) ?? 0
            let tmap = map.transposed()
            let score2 = tmap.score(part2: true) ?? 0
            sum += score1 + score2 * 100
        }
        return "\(sum)"
    }
}
