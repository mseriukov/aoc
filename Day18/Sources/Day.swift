import AOCCommon
import Collections

extension Direction {
    init?<S: StringProtocol>(_ str: S) {
        switch str {
        case "U": self = .up
        case "D": self = .down
        case "L": self = .left
        case "R": self = .right
        default: return nil
        }
    }
}

extension Direction {
    init(_ num: Int) {
        switch num {
        case 0: self = .right
        case 1: self = .down
        case 2: self = .left
        case 3: self = .up
        default: fatalError("Nope.")
        }
    }

    var offset: Point {
        switch self {
        case .right: return Point(0, 1)
        case .down: return Point(1, 0)
        case .left: return Point(0, -1)
        case .up: return Point(-1, 0)
        }
    }
}

public final class Day: DayType {
    public init() {}

    struct Cmd {
        var d: Direction
        var n: Int

        init<S: StringProtocol>(_ str: S, part: Part) {
            let split = str.split(whereSeparator: \.isWhitespace)
            if part == ._1 {
                d = Direction(split[0])!
                n = Int(String(split[1]))!
            } else {
                let hex = UInt32(String(split[2]).dropFirst(2).dropLast(), radix: 16)!
                d = Direction(Int(hex & 0x0F))
                n = Int(hex >> 4)
            }
        }
    }

    class Map {
        private let cmds: [Cmd]

        init<S: StringProtocol>(_ str: S, part: Part) {
            self.cmds = str.split(whereSeparator: \.isNewline).map { Cmd($0, part: part) }
        }

        func count() -> Int {
            var cnt = 0
            var row = 0
            var col = 0
            var line = 0

            for cmd in cmds {
                let newRow = row + cmd.n * cmd.d.offset.row
                let newCol = col + cmd.n * cmd.d.offset.col
                cnt += col * newRow - row * newCol
                line += cmd.n
                row = newRow
                col = newCol
            }
            return cnt / 2 + line / 2 + 1
        }
    }

    public func run(_ str: String, part: Part) -> String {
        "\(Map(str, part: part).count())"
    }
}
