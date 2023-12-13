import Foundation

public class Day11: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    struct Point: Equatable, Hashable {
        var row: Int
        var col: Int

        static let zero = Point(0, 0)

        init(_ row: Int, _ col: Int) {
            self.row = row
            self.col = col
        }
    }

    class Map {
        var points: Set<Point> = Set()
        var minRow: Int
        var maxRow: Int
        var minCol: Int
        var maxCol: Int
        var expansion: Int

        init<S>(_ str: S, expansion: Int) where S: StringProtocol {
            self.expansion = expansion
            let lines = str.split(whereSeparator: \.isNewline)
            let rows = lines.count
            let cols = lines[0].count

            var hset = IndexSet()
            var vset = IndexSet()

            for row in 0..<rows {
                let rowData = Array(lines[row])
                for col in 0..<cols {
                    let p = Point(row, col)
                    let c = rowData[col]

                    if c == "#" {
                        points.insert(p)
                        hset.insert(col)
                        vset.insert(row)
                    }
                }
            }

            var hoffset: [Int] = []
            var curHOffset = 0
            for c in 0..<cols {
                if !hset.contains(c) {
                    curHOffset += expansion
                }
                hoffset.append(curHOffset)
            }

            var voffset: [Int] = []
            var curVOffset = 0
            for c in 0..<cols {
                if !vset.contains(c) {
                    curVOffset += expansion
                }
                voffset.append(curVOffset)
            }

            var expandedPoints: Set<Point> = Set()

            for row in 0..<rows {
                for col in 0..<cols {
                    let p = Point(row, col)
                    if points.contains(p) {
                        expandedPoints.insert(Point(p.row + voffset[row], p.col + hoffset[col]))
                    }
                }
            }
            points = expandedPoints

            minRow = points.map { $0.row }.min()!
            maxRow = points.map { $0.row }.max()!
            minCol = points.map { $0.col }.min()!
            maxCol = points.map { $0.col }.max()!
        }

        func draw() {
            for row in minRow...maxRow {
                var rowStr = ""
                for col in minCol...maxCol {
                    rowStr += points.contains(Point(row, col)) ? "#" : "."
                }
                print(rowStr)
            }
        }
    }

    func common(_ input: String, expansion: Int) -> String {
        let map = Map(input, expansion: expansion)
        
        struct Pair: Hashable, Equatable {
            var p1: Point
            var p2: Point

            var dist: Int {
                abs(p1.row - p2.row) + abs(p1.col - p2.col)
            }
        }

        var pairs: Set<Pair> = Set()

        for point1 in map.points {
            for point2 in map.points {
                guard
                    point1 != point2,
                    !pairs.contains(Pair(p1: point1, p2: point2)),
                    !pairs.contains(Pair(p1: point2, p2: point1))
                else { continue }
                pairs.insert(Pair(p1: point1, p2: point2))
            }
        }

        let sum = pairs.reduce(0) { $0 + $1.dist }

        return "\(sum)"
    }

    func runFirst(_ input: String) -> String {
        common(input, expansion: 1)
    }

    func runSecond(_ input: String) -> String {
        common(input, expansion: 1000000 - 1)
    }
}
