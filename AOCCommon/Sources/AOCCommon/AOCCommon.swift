import Foundation

public struct TestData {
    public let input: String
    public let output: String

    public init(
        input: String,
        output: String
    ) {
        self.input = input
        self.output = output
    }
}

public enum Part: String, Codable {
    case _1 
    case _2
}

public protocol DayType {
    static var realInput: String { get }
    static var testP1: TestData? { get }
    static var testP2: TestData? { get }

    func run(_ str: String, part: Part) -> String
}

