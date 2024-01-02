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
    
    func parseInput(_ input: String) -> [(String, [Int])] {
        var result: [(String, [Int])] = []
        let lines = input.split(whereSeparator: \.isNewline)
        
        for line in lines {
            let split = line.split(whereSeparator: \.isWhitespace)
            let split2 = split[1].split(separator: ",")
            
            result.append((String(split[0]), split2.map { Int(String($0))! }))
        }
        
        return result
    }
    
    struct State: Hashable {
        var record: String
        var groups: [Int]
    }
    
    var cache: [State: Int] = [:]
    func count(_ state: State) -> Int {
        guard !state.record.isEmpty else { return state.groups.isEmpty ? 1 : 0 }
        guard !state.groups.isEmpty else { return state.record.contains("#") ? 0 : 1 }
        if let result = cache[state] { return result }
        
        var result = 0
        
        if state.record.first == "." || state.record.first == "?" {
            result += count(.init(
                record: String(state.record.dropFirst()),
                groups: state.groups
            ))
        }
        
        if state.record.first == "#" || state.record.first == "?" {
            let firstGroup = state.groups[0]
            if
                firstGroup <= state.record.count,
                !state.record.prefix(firstGroup).contains("."),
                (firstGroup == state.record.count || Array(state.record)[firstGroup] != "#" )
            {
                result += count(.init(
                    record: String(state.record.dropFirst(firstGroup + 1)),
                    groups: Array(state.groups.dropFirst())
                ))
            }
        }
        cache[state] = result
        return result
    }
    
    func runFirst(_ input: String) -> String {
        let data = parseInput(input)
        
        var res = 0
        for d in data {
            res += count(.init(
                record: d.0,
                groups: d.1
            ))
        }
        return "\(res)"
    }
    
    func runSecond(_ input: String) -> String {
        let data = parseInput(input)
        
        var res = 0
        for d in data {
            res += count(.init(
                record: [d.0, d.0, d.0, d.0, d.0].joined(separator: "?"),
                groups: [d.1, d.1, d.1, d.1, d.1].flatMap { $0 }
            ))
        }
        return "\(res)"
    }
}
