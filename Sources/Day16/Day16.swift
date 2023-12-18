import Foundation

public class Day16: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    enum Direction {
        case up, down, left, right
    }

    class Beam: Equatable {
        static func == (lhs: Day16.Beam, rhs: Day16.Beam) -> Bool {
            lhs.id == rhs.id
        }

        var id: UUID = UUID()
        var p: Point
        var d: Direction

        init(p: Point, d: Direction) {
            self.p = p
            self.d = d
        }

        func advance() {
            p.advance(d)
        }
    }

    struct Point: Hashable, Equatable {
        var row: Int
        var col: Int

        mutating func advance(_ dir: Direction) {
            switch dir {
            case .up: row -= 1
            case .down: row += 1
            case .left: col -= 1
            case .right: col += 1
            }
        }

        init(_ row: Int, _ col: Int) {
            self.row = row
            self.col = col
        }
    }

    class Map {
        var points: [Point: String]
        var rows: Int
        var cols: Int

        var beams: [Beam] = []
        var energized: [Point: Set<Direction>] = [:]

        init(points: [Point : String], rows: Int, cols: Int) {
            self.points = points
            self.rows = rows
            self.cols = cols
        }

        func reset() {
            beams = []
            energized = [:]
        }

        func step() {
            var newBeams: [Beam] = []
            var toRemove: [Beam] = []
            for beam in beams {
                if (energized[beam.p] ?? Set()).contains(beam.d) {
                    toRemove.append(beam)
                    continue
                }
                energized[beam.p] = (energized[beam.p] ?? Set()).union([beam.d])
                guard let c = points[beam.p] else { fatalError("Shouldn't reach this point.") }
                switch c {
                case ".":
                    break
                case "\\":
                    switch beam.d {
                    case .down: beam.d = .right
                    case .up: beam.d = .left
                    case .left: beam.d = .up
                    case .right: beam.d = .down
                    }
                case "/":
                    switch beam.d {
                    case .down: beam.d = .left
                    case .up: beam.d = .right
                    case .left: beam.d = .down
                    case .right: beam.d = .up
                    }
                case "-":
                    switch beam.d {
                    case .down, .up:
                        toRemove.append(beam)
                        newBeams.append(contentsOf: [.init(p: beam.p, d: .left), .init(p: beam.p, d: .right)])
                    case .left, .right: break
                    }
                case "|":
                    switch beam.d {
                    case .down, .up: break
                    case .left, .right:
                        toRemove.append(beam)
                        newBeams.append(contentsOf: [.init(p: beam.p, d: .up), .init(p: beam.p, d: .down)])
                    }
                default:
                    fatalError("Shouldn't reach this point.")
                }
                beam.advance()
                if !insideMap(beam.p) {
                    toRemove.append(beam)
                }
            }
            beams.removeAll(where: { toRemove.contains($0) })
            beams.append(contentsOf: newBeams)
        }

        func insideMap(_ p: Point) -> Bool {
            p.row >= 0 && p.row < rows && p.col >= 0 && p.col < cols
        }

        func draw() {
            for r in 0..<rows {
                var s = ""
                for c in 0..<cols {
                    let p = Point(r,c)
                    s += energized[p] != nil ? "#" : points[p]!
                }
                print(s)
            }
            print(String(repeating: "=", count: 21))
        }
    }




    func parseInput(_ input: String) -> Map {
        let lines = input.split(whereSeparator: \.isNewline)
        var points: [Point: String] = [:]
        for (row, line) in lines.enumerated() {
            for (col, c) in Array(line).enumerated() {
                let p = Point(row, col)
                points[p] = String(c)
            }
        }
        return Map(points: points, rows: lines.count, cols: lines[0].count)
    }

    func solveMap(_ map: Map) -> Int {
        var lastEnergizedCount: Int?
        var sameForSteps = 0
        while map.beams.count > 0 && sameForSteps < 2 * max(map.rows, map.cols) {
            lastEnergizedCount = map.energized.count
            map.step()
            //map.draw()
            if lastEnergizedCount == map.energized.count {
                sameForSteps += 1
            } else {                
                sameForSteps = 0
            }
        }
        return map.energized.count
    }

    func runFirst(_ input: String) -> String {
        let map = parseInput(input)
        map.beams.append(.init(p: .init(0, 0), d: .right))
        return "\(solveMap(map))"
    }

    func runSecond(_ input: String) -> String {
        let map = parseInput(input)

        let beams: [Beam] = [
            (0..<map.cols).map { Beam(p: .init(0, $0), d: .down) },
            (0..<map.cols).map { Beam(p: .init(map.rows - 1, $0), d: .up) },
            (0..<map.rows).map { Beam(p: .init($0, 0), d: .right) },
            (0..<map.rows).map { Beam(p: .init($0, map.cols - 1), d: .left) },
        ].flatMap {$0}

        var maxTiles = 0
        for beam in beams {
            map.reset()
            map.beams = [beam]
            maxTiles = max(solveMap(map), maxTiles)
        }
        return "\(maxTiles)"
    }
}
