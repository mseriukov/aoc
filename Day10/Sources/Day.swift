import Foundation
import AOCCommon

public final class Day: DayType {
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
        var cols: Int
        var rows: Int
        var startPoint: Point = .zero
        var mazePoints: Set<Point> = Set()
        struct Point: Equatable, Hashable {
            var row: Int
            var col: Int
            
            static let zero = Point(0, 0)
            
            init(_ row: Int, _ col: Int) {
                self.row = row
                self.col = col
            }
        }
        
        enum CellType: String {
            case _v = "|" // | is a vertical pipe connecting north and south.
            case _h = "-" // - is a horizontal pipe connecting east and west.
            case ne = "L" // L is a 90-degree bend connecting north and east.
            case nw = "J" // J is a 90-degree bend connecting north and west.
            case sw = "7" // 7 is a 90-degree bend connecting south and west.
            case se = "F" // F is a 90-degree bend connecting south and east.
            case _g = "." // . is ground; there is no pipe in this tile.
            case _s = "S" // S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
            case vv = " "
            
            var isPipe: Bool {
                switch self {
                case ._g, ._s: return false
                default: return true
                }
            }
            
            var pretty: String {
                var str: String
                switch self {
                case ._v: str = "│"
                case ._h: str = "─"
                case .ne: str = "└"
                case .nw: str = "┘"
                case .sw: str = "┐"
                case .se: str = "┌"
                case .vv: str = "*"
                default:  str = "."
                }
                return str
            }
        }
        
        class Cell {
            var type: CellType
            var p: Point
            var dist: Int?
            
            init(type: CellType, p: Point) {
                self.type = type
                self.p = p
            }
        }
        
        var data: [[Cell]]
        
        func cell(_ p: Point) -> Cell? {
            guard
                p.row >= 0 && p.row < rows,
                p.col >= 0 && p.col < cols
            else { return nil }
            return data[p.row][p.col]
        }
        
        func neighbours(_ c: Cell) -> [Cell] {
            var result: [Cell] = []
            
            switch c.type {
            case ._v:
                if let c = cell(c.p, offset: .init(-1, 0)), [._v, .sw, .se].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(+1, 0)), [._v, .ne, .nw].contains(c.type) {
                    result.append(c)
                }
            case ._h:
                if let c = cell(c.p, offset: .init(0, -1)), [._h, .ne, .se].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(0, +1)), [._h, .nw, .sw].contains(c.type) {
                    result.append(c)
                }
            case .ne:
                if let c = cell(c.p, offset: .init(-1, 0)), [._v, .sw, .se].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(0, +1)), [._h, .nw, .sw].contains(c.type) {
                    result.append(c)
                }
            case .nw:
                if let c = cell(c.p, offset: .init(-1, 0)), [._v, .sw, .se].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(0, -1)), [._h, .ne, .se].contains(c.type) {
                    result.append(c)
                }
            case .se:
                if let c = cell(c.p, offset: .init(+1, 0)), [._v, .ne, .nw].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(0, +1)), [._h, .nw, .sw].contains(c.type) {
                    result.append(c)
                }
            case .sw:
                if let c = cell(c.p, offset: .init(+1, 0)), [._v, .ne, .nw].contains(c.type) {
                    result.append(c)
                }
                
                if let c = cell(c.p, offset: .init(0, -1)), [._h, .ne, .se].contains(c.type) {
                    result.append(c)
                }
            default: break
            }
            
            
            return result
        }
        
        func cell(_ p: Point, offset: Point) -> Cell? {
            cell(Point(p.row + offset.row, p.col + offset.col))
        }
        
        func draw() {
            for r in 0..<rows {
                var rowStr = ""
                for c in 0..<cols {
                    let p = Point(r, c)
                    let c = cell(p)!
                    //                    if mazePoints.contains(p) {
                    //                        rowStr.append("\u{1B}[0;31m")
                    //                    } else {
                    //                        rowStr.append("\u{1B}[0;37m")
                    //                    }
                    rowStr.append(c.type.pretty)
                }
                print(rowStr)
            }
        }
        
        init<S>(_ str: S) where S: StringProtocol {
            let lines = str.split(whereSeparator: \.isNewline)
            
            self.rows = lines.count
            self.cols = lines[0].count
            self.data = lines.map { Array($0).map { Cell(type: CellType(rawValue: String($0))!, p: .zero) } }
            
            for r in 0..<rows {
                for c in 0..<cols {
                    let p = Point(r, c)
                    guard let c = cell(p) else { continue }
                    c.p = p
                    if c.type == ._s {
                        self.startPoint = p
                        
                        let so = Point(+1, 0)
                        let no = Point(-1, 0)
                        let eo = Point(0, +1)
                        let wo = Point(0, -1)
                        
                        //  |
                        //  S
                        //  |
                        if
                            let n = cell(p, offset: no),
                            let s = cell(p, offset: so),
                            [._v, .sw, .se].contains(n.type),
                            [._v, .nw, .ne].contains(s.type)
                        {
                            c.type = ._v
                        }
                        
                        //  -S-
                        if
                            let w = cell(p, offset: wo),
                            let e = cell(p, offset: eo),
                            [._h, .ne, .se].contains(w.type),
                            [._h, .nw, .sw].contains(e.type)
                        {
                            c.type = ._h
                        }
                        
                        //  S-
                        //  |
                        if
                            let e = cell(p, offset: eo),
                            let s = cell(p, offset: so),
                            [._h, .nw, .sw].contains(e.type),
                            [._v, .ne, .nw].contains(s.type)
                        {
                            c.type = .se
                        }
                        
                        //  -S
                        //   |
                        if
                            let w = cell(p, offset: wo),
                            let s = cell(p, offset: so),
                            [._h, .ne, .se].contains(w.type),
                            [._v, .ne, .nw].contains(s.type)
                        {
                            c.type = .sw
                        }
                        
                        //   |
                        //  -S
                        if
                            let w = cell(p, offset: wo),
                            let n = cell(p, offset: no),
                            [._h, .ne, .se].contains(w.type),
                            [._v, .sw, .se].contains(n.type)
                        {
                            c.type = .nw
                        }
                        
                        //  |
                        //  S-
                        if
                            let e = cell(p, offset: eo),
                            let n = cell(p, offset: no),
                            [._h, .sw, .nw].contains(e.type),
                            [._v, .sw, .se].contains(n.type)
                        {
                            c.type = .ne
                        }
                    }
                }
            }
            
        }
        
        func bfs(_ c: Cell) -> Int {
            var maxdist = 0
            c.dist = 0
            var stack: [Cell] = [c]
            while !stack.isEmpty {
                let cell = stack.first!
                stack.removeFirst()
                
                let ns = neighbours(cell).filter { $0.dist == nil }
                for n in ns {
                    n.dist = cell.dist! + 1
                }
                //cell.type = .vv
                mazePoints.insert(cell.p)
                maxdist = max(maxdist, cell.dist!)
                stack.append(contentsOf: ns)
            }
            return maxdist
        }
    }
    
    func runFirst(_ input: String) -> String {
        let map = Map(input)
        let res = map.bfs(map.cell(map.startPoint)!)
        //map.draw()
        return "\(res)"
    }
    
    func runSecond(_ input: String) -> String {
        let map = Map(input)
        _ = map.bfs(map.cell(map.startPoint)!)
        //map.draw()
        var cnt = 0
        for r in 0..<map.rows {
            var lastCorner: Map.CellType?
            var isInside = false
            for c in 0..<map.cols {
                let p = Map.Point(r, c)
                let cell = map.cell(p)!
                
                let isWall = cell.type.isPipe && map.mazePoints.contains(p)
                
                if isWall {
                    switch cell.type {
                    case ._v:
                        isInside = !isInside
                    case .ne:
                        isInside = !isInside
                        lastCorner = .ne
                    case .se:
                        isInside = !isInside
                        lastCorner = .se
                    case .sw:
                        if let lastCorner, lastCorner == .se {
                            isInside = !isInside
                        }
                        lastCorner = nil
                    case .nw:
                        if let lastCorner, lastCorner == .ne {
                            isInside = !isInside
                        }
                        lastCorner = nil
                        
                    default: break
                    }
                } else {
                    if isInside {
                        cnt += 1
                    }
                }
            }
        }
        return "\(cnt)"
    }
}
