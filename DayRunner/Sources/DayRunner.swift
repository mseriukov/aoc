import ArgumentParser
import AOCCommon

extension Part: ExpressibleByArgument { }

enum Input: String, Codable, ExpressibleByArgument {
    case real
    case test
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
        var s = ""

        guard let dayType = dayList[dayNumber] else {
            print("Unknown day.")
            return
        }

        var expected: String? = nil
        var inputStr: String? = nil
        switch input {
        case .real:
            inputStr = dayType.realInput

        case .test:
            inputStr = part == ._1 ? dayType.testP1?.input : dayType.testP2?.input
            expected = part == ._1 ? dayType.testP1?.output : dayType.testP2?.output
        }
        guard let inputStr else {
            print("NO INPUT.")
            return
        }

        let dayInstance = dayType.init()
        let result = dayInstance.run(inputStr, part: part)
        print("Result: \(result)")
        if let expected {
            if expected == result {
                print("VALID.".fc(.green).reset())
            } else {
                print("INVALID. Expected: \(expected)".fc(.red).reset())
            }
        }
    }
}
