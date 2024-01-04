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

    init()
    func run(_ str: String, part: Part) -> String
}

public enum Direction: CaseIterable {
    case up, down, left, right

    public func ccw() -> Direction {
        switch self {
        case .up: return .left
        case .down: return .right
        case .left: return .down
        case .right: return .up
        }
    }

    public func cw() -> Direction {
        switch self {
        case .up: return .right
        case .down: return .left
        case .left: return .up
        case .right: return .down
        }
    }
}

public struct Point: Hashable, Equatable {
    public var row: Int
    public var col: Int

    public static let zero = Self(0, 0)

    public func advanced(_ dir: Direction) -> Point {
        switch dir {
        case .up: return Point(row - 1, col)
        case .down: return Point(row + 1, col)
        case .left: return Point(row, col - 1)
        case .right: return Point(row, col + 1)
        }
    }

    public init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}
