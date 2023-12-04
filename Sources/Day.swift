public enum Part {
    case first
    case second
}

public protocol Day {
    var firstHalf: TestData? { get }
    var secondHalf: TestData? { get }
    var realInput: String { get }

    func run(_ input: String, part: Part) -> String
}
