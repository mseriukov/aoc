import AOCCommon
import Collections

public final class Day: DayType {
    public init() {}
    
    class Map {
        var data: [[Int]]
        var rows: Int
        var cols: Int

        init(_ str: String) {
            data = str.split(whereSeparator: \.isNewline).map({ $0.map { Int(String($0))! } })
            rows = data.count
            cols = data[0].count
        }

        func advancePoint(_ p: Point, in d: Direction) -> Point? {
            point(p.advanced(d), offset: .zero)
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
        
        func draw(_ dist: [State: Int] = [:], _ prev: [State: State]) {
            var path: [Point] = []
            if var state = dist.keys.first(where: { $0.p == Point(rows - 1, cols - 1) }) {
                while true {
                    path.append(state.p)
                    guard let ns = prev[state] else { break }
                    state = ns
                }
            }

            for row in 0..<rows {
                var str = ""
                for col in 0..<cols {
                    let p = Point(row, col)
                    str += path.contains(p) ? "*" : "\(data(at: p))"
                }
                print(str)
            }
        }
        
        struct State: Comparable, Equatable, Hashable {
            func hash(into hasher: inout Hasher) {
                p.hash(into: &hasher)
                d.hash(into: &hasher)
                s.hash(into: &hasher)
            }

            static func == (lhs: Self, rhs: Self) -> Bool {
                lhs.p == rhs.p &&
                lhs.d == rhs.d &&
                lhs.s == rhs.s
            }

            static func < (lhs: Day.Map.State, rhs: Day.Map.State) -> Bool {
                lhs.cost < rhs.cost
            }

            var p: Point
            var d: Direction
            var s: Int
            var cost: Int
        }

        func neighbours(_ state: State, part: Part) -> [State] {
            var result: [State] = []
            if part == ._1 {
                do { // Left
                    let nd = state.d.ccw()
                    if let np = advancePoint(state.p, in: nd) {
                        let nc = state.cost + data(at: np)
                        result.append(State(p: np, d: nd, s: 1, cost: nc))
                    }
                }
                do { // Right
                    let nd = state.d.cw()
                    if let np = advancePoint(state.p, in: nd) {
                        let nc = state.cost + data(at: np)
                        result.append(State(p: np, d: nd, s: 1, cost: nc))
                    }
                }
                do { // Forward
                    if state.s < 3, let np = advancePoint(state.p, in: state.d) {
                        let nc = state.cost + data(at: np)
                        result.append(State(p: np, d: state.d, s: state.s + 1, cost: nc))
                    }
                }
            } else {
                if state.s < 10, let np = advancePoint(state.p, in: state.d) {
                    let nc = state.cost + data(at: np)
                    result.append(State(p: np, d: state.d, s: state.s + 1, cost: nc))
                }

                guard state.s >= 4 else { return result }

                do { // Left
                    let nd = state.d.ccw()
                    if let np = advancePoint(state.p, in: nd) {
                        let nc = state.cost + data(at: np)
                        result.append(State(p: np, d: nd, s: 1, cost: nc))
                    }
                }
                do { // Right
                    let nd = state.d.cw()
                    if let np = advancePoint(state.p, in: nd) {
                        let nc = state.cost + data(at: np)
                        result.append(State(p: np, d: nd, s: 1, cost: nc))
                    }
                }
            }
            return result
        }

        func dijkstra(_ source: State, part: Part) -> (dist: [State: Int], prev: [State: State]) {
            var dist: [State: Int] = [source: 0]
            var prev: [State: State] = [:]
            var queue: Heap<State> = Heap()
            queue.insert(source)

            while true {
                guard let state = queue.popMin() else { return (dist, prev) }
                for n in neighbours(state, part: part) {
                    let curDist = dist[state] ?? Int.max
                    let newDist = dist[n] ?? Int.max
                    let alt = curDist + data(at: n.p)
                    if alt < newDist {
                        dist[n] = alt
                        prev[n] = state
                        if !queue.unordered.contains(n) {
                            queue.insert(n)
                        }
                    }
                }
            }
            return (dist, prev)
        }

        func search(part: Part) -> Int? {
            let (dist, prev) = dijkstra(State(p: .zero, d: .right, s: 1, cost: 0), part: part)
            draw(dist, prev)
            return dist.keys.filter({ $0.p == Point(rows - 1, cols - 1) }).compactMap({ dist[$0] }).min()
        }
    }
    
    public func run(_ str: String, part: Part) -> String {
        let map = Map(str)
        return "\(map.search(part: part)!)"
    }
}
