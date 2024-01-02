import Foundation
import AOCCommon

public final class Day: DayType {
    public init() {}
    
    enum Color: String {
        case red
        case green
        case blue
    }
    
    struct CubeSet {
        var r: Int = 0
        var g: Int = 0
        var b: Int = 0
        
        init() { }
        
        init<S>(_ str: S) where S: StringProtocol {
            let colorCountStrs = str.split(separator: ",")
            for colorCountStr in colorCountStrs {
                let components = colorCountStr.split(separator: " ")
                guard
                    let count = Int(components[0]),
                    let color = Color(rawValue: String(components[1]))
                else { fatalError("Unable to parse cube set.") }
                
                switch color {
                case .red: self.r = count
                case .green: self.g = count
                case .blue: self.b = count
                }
            }
        }
        
        func isValid(_ maxR: Int, _ maxG: Int, _ maxB: Int) -> Bool {
            r <= maxR && g <= maxG && b <= maxB
        }
        
        var power: Int {
            r * g * b
        }
    }
    
    struct Game {
        var id: Int
        var sets: [CubeSet]
        
        init<S>(_ str: S) where S: StringProtocol {
            var line = str.dropFirst(5)
            let idStr = line.prefix(while: \.isNumber)
            guard let id = Int(idStr) else { fatalError("Unable to parse game id.") }
            line = line.dropFirst(idStr.count + 2) // 2 is ": "
            let setStrs = line.split(separator: ";")
            
            self.id = id
            self.sets = setStrs.map({ CubeSet($0) })
        }
        
        func isValid(_ maxR: Int, _ maxG: Int, _ maxB: Int) -> Bool {
            sets.allSatisfy { $0.isValid(maxR,  maxG,  maxB) }
        }
        
        func minimalSet() -> CubeSet {
            var minimalSet = CubeSet()
            for set in sets {
                if minimalSet.r < set.r { minimalSet.r = set.r }
                if minimalSet.g < set.g { minimalSet.g = set.g }
                if minimalSet.b < set.b { minimalSet.b = set.b }
            }
            return minimalSet
        }
    }
    
    public func run(_ input: String, part: Part) -> String {
        let lines = input.split(whereSeparator: \.isNewline)
        var result = 0
        for line in lines {
            let game = Game(line)
            switch part {
            case ._1:
                if game.isValid(12, 13, 14) {
                    result += game.id
                }
                
            case ._2:
                result += game.minimalSet().power
            }
        }
        
        return "\(result)"
    }
}
