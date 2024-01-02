import Foundation
import AOCCommon

public final class Day: DayType {
    public init() {}
    
    struct Transform {
        var src: Int
        var dst: Int
        var len: Int
        
        var sourceRange: Range<Int>
        
        func apply(_ input: Int) -> Int? {
            if input >= src && input < (src + len) {
                let offset = input - src
                let output = dst + offset
                return output
            }
            return nil
        }
        
        func apply(_ input: Range<Int>) -> Range<Int>? {
            let source = src..<(src + len)
            guard source.overlaps(input) else { return nil }
            
            let offset = dst - src
            if input.lowerBound >= source.lowerBound && input.upperBound <= source.upperBound {
                return (input.lowerBound + offset)..<(input.upperBound + offset)
            }
            fatalError("Shouldn't reach this point.")
        }
        
        init(_ dst: Int, _ src: Int, _ len: Int) {
            self.dst = dst
            self.src = src
            self.len = len
            
            sourceRange = src..<(src + len)
        }
        
        init<S>(str: S) where S: StringProtocol {
            let split = str.split(separator: " ")
            let dst = Int(split[0])!
            let src = Int(split[1])!
            let len = Int(split[2])!
            
            self.init(dst, src, len)
        }
    }
    
    struct Map {
        var transforms: [Transform]
        
        func reversed() -> Map {
            Map(transforms: transforms.reversed())
        }
        
        func transform(_ input: Int) -> Int {
            transforms.compactMap { $0.apply(input) }.first ?? input
        }
        
        func transform(_ input: Range<Int>) -> [Range<Int>] {
            let inputRanges = input.split(by: transforms.map(\.sourceRange))
            return inputRanges.compactMap { range in
                var result: Range<Int>?
                for transform in transforms {
                    result = transform.apply(range)
                    if result != nil { break }
                }
                return result ?? range
            }.filter { !$0.isEmpty }
        }
        
        init(transforms: [Transform]) {
            self.transforms = transforms
        }
    }
    
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case ._1:
            return runFirst(input)
        case ._2:
            return runSecond(input)
        }
    }
    
    func parseInput(_ input: String) -> ([Map], [Int]) {
        let lines = input.split(whereSeparator: \.isNewline)
        var seeds: [Int] = []
        var transforms: [Transform] = []
        var maps: [Map] = []
        for line in lines {
            if seeds.isEmpty {
                seeds = line.dropFirst(7).split(separator: " ").map { Int($0)! }
                continue
            }
            if line.isEmpty || line.first?.isLetter ?? false {
                if !transforms.isEmpty {
                    maps.append(Map(transforms: transforms))
                    transforms = []
                }
                continue
            }
            transforms.append(Transform(str: line))
        }
        if !transforms.isEmpty {
            maps.append(Map(transforms: transforms))
            transforms = []
        }
        return (maps, seeds)
    }
    
    func runFirst(_ input: String) -> String {
        let (maps, seeds) = parseInput(input)
        let locatons = seeds.map { maps.reduce($0) { $1.transform($0) } }
        return "\(locatons.min()!)"
    }
    
    func runSecond(_ input: String) -> String {
        let (maps, seeds) = parseInput(input)
        
        let ranges = stride(from: 0, to: seeds.count - 1, by: 2).map {
            seeds[$0]..<(seeds[$0] + seeds[$0+1])
        }
        
        var inputRanges = ranges
        for map in maps {
            var result: [Range<Int>] = []
            
            for range in inputRanges {
                result.append(contentsOf: map.transform(range))
            }
            inputRanges = result
        }
        
        return "\(inputRanges.min(by: { $0.lowerBound < $1.lowerBound })!.lowerBound)"
    }
}
