import ArgumentParser
import AOCCommon
import Day17

extension Part: ExpressibleByArgument { }

enum Input: String, Codable, ExpressibleByArgument {
    case real
    case testP1
    case testP2
}

@main
struct DayRunner: ParsableCommand {
    @Option(
        name: .customShort("d"),
        help: "Day number"
    )
    var dayNumber: Int = 1

    @Option(
        name: .customShort("p"),
        help: "Part"
    )
    var part: Part = ._1

    @Option(
        name: .customShort("i"),
        help: "Input"
    )
    var input: Input = .real
}

extension DayRunner {
    mutating func run() throws {
        let days: [Int: any Day] = [
            17 : Day17.Day()
        ]
        
        guard let dayType = days[dayNumber] else {
            print("Unknown day.")
            return
        }
        
        var expected: String? = nil
        let inputStr: String
        switch input {
        case .real: 
            inputStr = dayType.realInput
        case .testP1:
            inputStr = dayType.testP1.input
            expected = dayType.testP1.output
        case .testP2:
            inputStr = dayType.testP2.input
            expected = dayType.testP2.output
        }
        let dayInstance = dayType()
        let result = day.run(inputStr, part: part)
        if let expected {
            if expected == result {
                print("VALID. Result: \(result)")
            } else {
                print("INVALID. Result: \(result) Expected: \(expected)")
            }
        }
    }
}

