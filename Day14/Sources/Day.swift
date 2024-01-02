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

    class Map {
        var rows: Int
        var cols: Int
        var data: [[String]]
        var startHash: Int

        func row(at index: Int) -> [String] {
            data[index]
        }

        func col(at index: Int) -> [String] {
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
            print(String(repeating: "=", count: 21))
        }

        enum Direction {
            case north
            case south
            case east
            case west
        }

        func tilt(_ dir: Direction) {
            switch dir {
            case .north:
                for cidx in 0..<cols {
                    let _data = Array(col(at: cidx).reversed())

                    var stones = 0
                    for (i, s) in _data.enumerated() {
                        let originalDataRow = rows - i - 1
                        switch s {
                        case "#":
                            for o in 0..<stones {
                                data[originalDataRow + 1 + o][cidx] = "O"
                            }
                            stones = 0
                        case "O":
                            data[originalDataRow][cidx] = "."
                            stones += 1
                        default:
                            continue
                        }
                    }
                    for o in 0..<stones {
                        data[rows - data.count + o][cidx] = "O"
                    }
                }
            case .south:
                for cidx in 0..<cols {
                    let _data = Array(col(at: cidx))

                    var stones = 0
                    for (i, s) in _data.enumerated() {
                        let originalDataRow = i
                        switch s {
                        case "#":
                            for o in 0..<stones {
                                data[originalDataRow - 1 - o][cidx] = "O"
                            }
                            stones = 0
                        case "O":
                            data[originalDataRow][cidx] = "."
                            stones += 1
                        default:
                            continue
                        }
                    }
                    for o in 0..<stones {
                        data[data.count - 1 - o][cidx] = "O"
                    }
                }
            case .east:
                for ridx in 0..<rows {
                    let _data = Array(row(at: ridx))

                    var stones = 0
                    for (i, s) in _data.enumerated() {
                        let originalDataCol = i
                        switch s {
                        case "#":
                            for o in 0..<stones {
                                data[ridx][originalDataCol - 1 - o] = "O"
                            }
                            stones = 0
                        case "O":
                            data[ridx][originalDataCol] = "."
                            stones += 1
                        default:
                            continue
                        }
                    }
                    for o in 0..<stones {
                        data[ridx][data.count - 1 - o] = "O"
                    }
                }
            case .west:
                for ridx in 0..<rows {
                    let _data = Array(row(at: ridx).reversed())

                    var stones = 0
                    for (i, s) in _data.enumerated() {
                        let originalDataCol = cols - i - 1
                        switch s {
                        case "#":
                            for o in 0..<stones {
                                data[ridx][originalDataCol + 1 + o] = "O"
                            }
                            stones = 0
                        case "O":
                            data[ridx][originalDataCol] = "."
                            stones += 1
                        default:
                            continue
                        }
                    }
                    for o in 0..<stones {
                        data[ridx][rows - data.count + o] = "O"
                    }
                }
            }
        }

        func load() -> Int {
            var result = 0
            for cidx in 0..<cols {
                let data = Array(col(at: cidx).reversed())
                for (i, s) in data.enumerated() {
                    switch s {
                    case "O":
                        result += i + 1
                    default:
                        continue
                    }
                }
            }
            return result
        }

        init(rows: Int, cols: Int, data: [[String]]) {
            self.rows = rows
            self.cols = cols
            self.data = data
            startHash = data.hashValue
        }

        init<S>(_ str: S) where S: StringProtocol {
            data = str.split(whereSeparator: \.isNewline).map { Array($0).map { String($0) } }
            rows = data.count
            cols = data[0].count
            startHash = data.hashValue
        }
    }

    func runFirst(_ input: String) -> String {
        let map = Map(input)
        map.draw()
        map.tilt(.north)

        return "\(map.load())"
    }

    func runSecond(_ input: String) -> String {
        let map = Map(input)
        var cyclesTracker: [Int: Int] = [:]
        func cycle(_ i: Int) -> Int? {
            map.tilt(.north)
            map.tilt(.west)
            map.tilt(.south)
            map.tilt(.east)

            let curHash = map.data.hashValue
            if let index = cyclesTracker[curHash] {
                print("\(index)")
                return index
            }
            cyclesTracker[curHash] = i
            return nil
        }
        var i = 0
        var foundCycle = false
        while i < 1000000000 {
            if let idx = cycle(i), !foundCycle {
                i = idx + (1000000000 - idx) / (i - idx) * (i - idx)
                foundCycle = true
            }
            i += 1
        }
        map.draw()
        return "\(map.load())"
    }

}
