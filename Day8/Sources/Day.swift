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
    
    enum Instruction: String {
        case L
        case R
    }
    
    func parseInput(_ input: String) -> ([Instruction], [String: (String, String)]) {
        var lines = input.split(whereSeparator: \.isNewline)
        let instructionsLine = lines[0]
        
        let instructions = Array(instructionsLine).compactMap { Instruction(rawValue: String($0)) }
        
        lines.removeFirst()
        var map: [String: (String, String)] = [:]
        for line in lines {
            let split = line.split(separator: "=").map { $0.trimmingCharacters(in: .whitespaces) }
            let split2 = split[1].dropFirst().dropLast().split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            
            map[split[0]] = (split2[0], split2[1])
        }
        return (instructions, map)
    }
    
    func runFirst(_ input: String) -> String {
        let (inst, map) = parseInput(input)
        
        var step = 0
        var cur = "AAA"
        
        while true {
            if cur == "ZZZ" { break }
            let i = inst[step % inst.count]
            let pair = map[cur]!
            cur = i == .L ? pair.0 : pair.1
            step += 1
        }
        
        return "\(step)"
    }
    
    func runSecond(_ input: String) -> String {
        let (inst, map) = parseInput(input)
        
        var step = 0
        var cur = map.filter { Array($0.key).last! == "A" }.map { $0.0 }
        
        let set = Set(cur
            .map { solve(cur: $0, map: map, inst: inst) }
            .flatMap { primeFactors($0) })
        
        let result = set.reduce(1, *)
        
        return "\(result)"
    }
    
    func solve(cur: String, map: [String: (String, String)], inst: [Instruction]) -> Int {
        var cur = cur
        var step = 0
        while true {
            if Array(cur).last! == "Z" { break }
            let i = inst[step % inst.count]
            let pair = map[cur]!
            cur = i == .L ? pair.0 : pair.1
            step += 1
        }
        return step
    }
    
    func primeFactors(_ n: Int) -> [Int] {
        var n = n
        var factors: [Int] = []
        
        var divisor = 2
        while divisor * divisor <= n {
            while n % divisor == 0 {
                factors.append(divisor)
                n /= divisor
            }
            divisor += divisor == 2 ? 1 : 2
        }
        if n > 1 {
            factors.append(n)
        }
        
        return factors
    }
}
