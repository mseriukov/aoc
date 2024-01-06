import Foundation
import AOCCommon

enum Category: String {
    case x, m, a, s
}

enum Action: CustomDebugStringConvertible {
    case accept
    case reject
    case send(to: String)

    var debugDescription: String {
        switch self {
        case .accept: return "ACCEPT"
        case .reject: return "REJECT"
        case let .send(to: wf): return "WF(\(wf))"
        }
    }

    init<S: StringProtocol>(_ str: S) {
        switch str {
        case "A": self = .accept
        case "R": self = .reject
        default: self = .send(to: String(str))
        }
    }
}

enum Relation: String {
    case more = ">"
    case less = "<"
}

struct Condition {
    var category: Category
    var relation: Relation
    var value: Int

    init<S: StringProtocol>(_ str: S) {
        self.category = Category(rawValue: String(str.first!))!
        self.relation = Relation(rawValue: String(str.dropFirst().first!))!
        self.value = Int(String(str.dropFirst(2)))!
    }

    func validate(_ ratings: Ratings) -> Bool {
        guard
            let rValue = ratings.map[category]
        else { return false }
        switch relation {
        case .more:
            return rValue > value
        case .less:
            return rValue < value
        }
    }
}

struct Rule {
    var condition: Condition?
    var action: Action

    init<S: StringProtocol>(_ str: S) {
        if str.contains(":") {
            let split = str.split(separator: ":")
            self.condition = Condition(split[0])
            self.action = Action(split[1])
        } else {
            self.condition = nil
            self.action = Action(str)
        }
    }
}

struct Workflow {
    var name: String
    var rules: [Rule]

    init<S: StringProtocol>(_ str: S) {
        var split = str.split(separator: "{")
        name = String(split[0])
        split = split[1].dropLast().split(separator: ",")
        rules = split.map { Rule($0) }
    }
}

struct Ratings {
    var map: [Category: Int]

    init(_ map: [Category: Int]) {
        self.map = map
    }

    init<S: StringProtocol>(_ str: S) {
        var map: [Category: Int] = [:]
        str.dropFirst().dropLast().split(separator: ",").forEach { split in
            let subsplit = split.split(separator: "=")
            map[Category(rawValue: String(subsplit[0]))!] = Int(String(subsplit[1]))!
        }
        self.map = map
    }
}

public final class Day: DayType {
    public init() {}

    var workflows: [String: Workflow] = [:]

    private func parseInput<S: StringProtocol>(_ str: S) -> ([String: Workflow], [Ratings]) {
        let split = str.split(omittingEmptySubsequences:false, whereSeparator: \.isNewline)
        let idx = split.firstIndex(of: "")!

        let workflows = Dictionary(uniqueKeysWithValues: split[0..<idx].map { Workflow($0) }.map { ($0.name, $0) })
        let ratings = split[(idx + 1)..<split.count].map { Ratings($0) }

        return (workflows, ratings)
    }

    func apply(workflow: Workflow, to rating: Ratings) -> Action {
        for rule in workflow.rules {
            guard let condition = rule.condition else { return rule.action }
            if condition.validate(rating) {
                return rule.action
            } else {
                continue
            }
        }
        fatalError("Shouldn't reach this point")
    }

    func validate(rating: Ratings, workflows: [String: Workflow]) -> Bool {
        var workflow = workflows["in"]!
        while true {
            let action = apply(workflow: workflow, to: rating)
            switch action {
            case .accept: 
                return true
            case .reject: 
                return false
            case let .send(to: newWorkflow):
                workflow = workflows[newWorkflow]!
            }
        }
    }

    struct CategoryRange: CustomDebugStringConvertible {
        var x: ClosedRange<Int>
        var m: ClosedRange<Int>
        var a: ClosedRange<Int>
        var s: ClosedRange<Int>

        var debugDescription: String {
            "{x: \(x.lowerBound)...\(x.upperBound), m: \(m.lowerBound)...\(m.upperBound), a: \(a.lowerBound)...\(a.upperBound), s: \(s.lowerBound)...\(s.upperBound)}"
        }

        init(_ x: ClosedRange<Int>, _ m: ClosedRange<Int>, _ a: ClosedRange<Int>, _ s: ClosedRange<Int>) {
            self.x = x
            self.m = m
            self.a = a
            self.s = s
        }

        // 1...4000 s > 2000 -> 1...2000, 2001...4000
        // 1...4000 s < 2000 -> 1...1999, 2000...4000

        func split(by condition: Condition) -> (CategoryRange?, CategoryRange?) {
            let lo = condition.relation == .more ? 0 : -1
            let ro = condition.relation == .more ? +1 : 0
            switch condition.category {
            case .x:
                guard x.contains(condition.value - 1) else { return (nil, nil) }
                return (.init(x.lowerBound...(condition.value + lo), m, a, s), .init((condition.value + ro)...x.upperBound, m, a, s))
            case .m:
                guard m.contains(condition.value - 1) else { return (nil, nil) }
                return (.init(x, m.lowerBound...(condition.value + lo), a, s), .init(x, (condition.value + ro)...m.upperBound, a, s))
            case .a:
                guard a.contains(condition.value - 1) else { return (nil, nil) }
                return (.init(x, m, a.lowerBound...(condition.value + lo), s), .init(x, m, (condition.value + ro)...a.upperBound, s))
            case .s:
                guard s.contains(condition.value - 1) else { return (nil, nil) }
                return (.init(x, m, a, s.lowerBound...(condition.value + lo)), .init(x, m, a, (condition.value + ro)...s.upperBound))
            }
        }

        func count() -> Int {
            x.count * m.count * a.count * s.count
        }
    }

    func validate(range: CategoryRange, workflow: Workflow) -> [(CategoryRange, Action)] {
        var result: [(CategoryRange, Action)] = []
        var curRange = range
        for rule in workflow.rules {
            guard let condition = rule.condition else {
                result.append((curRange, rule.action))
                continue
            }
            let (ruleLeft, ruleRight) = curRange.split(by: condition)
            if condition.relation == .more {
                if let ruleRight {
                    result.append((ruleRight, rule.action))
                }
                if let ruleLeft {
                    curRange = ruleLeft
                }
            } else {
                if let ruleLeft {
                    result.append((ruleLeft, rule.action))
                }
                if let ruleRight {
                    curRange = ruleRight
                }
            }
        }
        return result
    }

    public func run(_ str: String, part: Part) -> String {
        let (workflows, ratings) = parseInput(str)
        self.workflows = workflows

        if part == ._1 {
            var result = 0
            for rating in ratings {
                if validate(rating: rating, workflows: workflows) {
                    result += rating.map.values.reduce(0, +)
                }
            }
            return "\(result)"
        } else {
            var result = 0

            let initial = CategoryRange(
                1...4000,
                1...4000,
                1...4000,
                1...4000
            )

            var queue: [(CategoryRange, Action)] = [
                (initial, .send(to: "in"))
            ]

            while true {
                guard let (range, action) = queue.first else { break }
                print("\(range) -> \(action)")
                queue.removeFirst()
                switch action {
                case .accept:
                    result += range.count()
                case .reject:
                    continue
                case let .send(to: workflowName):
                    guard let workflow = workflows[workflowName] else { break }
                    queue.append(contentsOf: validate(range: range, workflow: workflow))
                }
            }
            return "\(result)"
        }
    } // 118684559352431 high
}
