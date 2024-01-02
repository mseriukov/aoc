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
    
    func parseInput(_ input: String) -> [String] {
        input.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.map { String($0) }
    }
    
    func hash(_ input: String) -> Int {
        var result = 0
        for c in Array(input) {
            result = result + Int(c.asciiValue!)
            result = result * 17
            result = result % 256
        }
        return result
    }
    
    func runFirst(_ input: String) -> String {
        let data = parseInput(input)
        
        let result = data.reduce(0, { $0 + hash($1) })
        
        return "\(result)"
    }
    
    struct Lens {
        var id: String
        var focal: Int
    }
    
    enum Cmd {
        case remove(String)
        case add(Lens)
    }
    
    func parseCmd(_ input: String) -> (Int, Cmd) {
        var str = ""
        
        var chars = Array(input)
        var idx = 0
        while true {
            guard idx < chars.count else { break }
            guard chars[idx] != "-", chars[idx] != "=" else { break }
            str += String(chars[idx])
            idx += 1
        }
        let hash = hash(str)
        switch chars[idx] {
        case "-":
            return (hash, .remove(str))
        case "=":
            idx += 1
            var numStr = ""
            while idx < chars.count {
                numStr += String(chars[idx])
                idx += 1
            }
            return (hash, .add(Lens(id: str, focal: Int(numStr)!)))
        default:
            fatalError("Shouldn't reach this point.")
        }
    }
    
    func runSecond(_ input: String) -> String {
        let data = parseInput(input).map { parseCmd($0) }
        
        var map: [Int: [Lens]] = [:]
        
        for (hash, cmd) in data {
            switch cmd {
            case let .remove(id):
                map[hash] = map[hash]?.filter { $0.id != id }
            case let .add(lens):
                if var lenses = map[hash], let lensIdx = lenses.firstIndex(where: { $0.id == lens.id}) {
                    lenses[lensIdx].focal = lens.focal
                    map[hash] = lenses
                } else {
                    map[hash] = (map[hash] ?? []) + [lens]
                }
            }
        }
        
        let result = map.reduce(0) { result, pair in
            let sum = pair.value.enumerated().map { $0.element.focal * ($0.offset + 1) * (pair.key + 1) }.reduce(0, +)
            return result + sum
        }
        return "\(result)"
    }
}
