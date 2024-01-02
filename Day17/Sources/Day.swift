import AOCCommon

public final class Day: DayType {
    public init() {}
    
    class Map {
        var data: [[Int]]
        var rows: Int
        var cols: Int
        
        enum Direction: CaseIterable {
            case up, down, left, right
            
            func next(_ includingForward: Bool) -> [Direction] {
                switch self {
                case .up:
                    return [.left, .right] + (includingForward ? [.up] : [])
                case .down:
                    return [.left, .right] + (includingForward ? [.down] : [])
                case .left:
                    return [.up, .down] + (includingForward ? [.left] : [])
                case .right:
                    return [.up, .down] + (includingForward ? [.right] : [])
                }
            }
        }
        
        struct Point: Hashable, Equatable {
            var row: Int
            var col: Int
            
            static let zero = Self(0, 0)
            
            mutating func advance(_ dir: Direction) {
                switch dir {
                case .up: row -= 1
                case .down: row += 1
                case .left: col -= 1
                case .right: col += 1
                }
            }
            
            func advanced(_ dir: Direction) -> Point {
                switch dir {
                case .up: return Point(row - 1, col)
                case .down: return Point(row + 1, col)
                case .left: return Point(row, col - 1)
                case .right: return Point(row, col + 1)
                }
            }
            
            init(_ row: Int, _ col: Int) {
                self.row = row
                self.col = col
            }
        }
        
        struct Crucible {
            var p: Point
            var d: Direction
            var blocks: Int
            
            mutating func advance(_ dir: Direction) {
                p.advance(d)
            }
            
            func next() -> [Crucible] {
                let includingForward = blocks < 3
                return d.next(includingForward).map {
                    Crucible(
                        p: p.advanced($0),
                        d: $0,
                        blocks: includingForward && d == $0 ? blocks + 1 : 1
                    )
                }
            }
        }
        
        init(_ str: String) {
            data = str.split(whereSeparator: \.isNewline).map({ $0.map { Int(String($0))! } })
            rows = data.count
            cols = data[0].count
        }
        
        func point(_ p: Point, offset: Point = .zero) -> Point? {
            let newRow = p.row + offset.row
            let newCol = p.col + offset.col
            guard newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols else { return nil }
            return Point(newRow, newCol)
        }
        
        func data(at p: Point) -> Int {
            guard let p = point(p) else { fatalError("Out of bounds") }
            return data[p.row][p.col]
        }
        
        func draw(_ points: [Point] = []) {
            for row in 0..<rows {
                var str = ""
                for col in 0..<cols {
                    str += "\u{001B}[38;2;250;0;0m\u{001B}[48;2;0;200;0m" + (points.contains(.init(row, col)) ? "*" : "\(data(at: .init(row, col)))" + "\u{001B}[0m")
                }
                print(str)
            }
        }
        
        struct State: Comparable {
            static func < (lhs: Day.Map.State, rhs: Day.Map.State) -> Bool {
                lhs.heatLoss > rhs.heatLoss
            }
            
            static func == (lhs: Day.Map.State, rhs: Day.Map.State) -> Bool {
                lhs.heatLoss == rhs.heatLoss
            }
            
            var crucible: Crucible
            var heatLoss: Int
        }
        
        struct DPoint: Hashable {
            let p: Point
            let d: Direction
        }
        
        func search() -> Int {
            var result: Int = Int.max
            var queue: PriorityQueue<State> = PriorityQueue()
            var visited: Set<DPoint> = Set()
            let startPoint = Point(0, 0)
            let finishPoint = Point(rows - 1, cols - 1)
            
            queue.push(.init(crucible: .init(p: startPoint, d: .right, blocks: 1), heatLoss: 0))
            while true {
                guard let state = queue.pop() else { break }
                guard !visited.contains(DPoint(p: state.crucible.p, d: state.crucible.d)) else { continue }
                visited.insert(DPoint(p: state.crucible.p, d: state.crucible.d))
                let heatLoss = state.heatLoss + data(at: state.crucible.p)
                
                if state.crucible.p == finishPoint {
                    result = min(result, heatLoss - data(at: startPoint))
                }
                
                let nextCrucibles = state.crucible.next()
                    .filter { point($0.p) != nil }
                
                for crucible in nextCrucibles {
                    queue.push(.init(crucible: crucible, heatLoss: heatLoss))
                }
            }
            return result
        }
    }
    
    public func run(_ str: String, part: Part) -> String {
        let map = Map(Day.testP1!.input)
        return "42"
    }
}
