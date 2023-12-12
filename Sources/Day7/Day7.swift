import Foundation

public class Day7: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    enum Card: String {
        case _A = "A"
        case _K = "K"
        case _Q = "Q"
        case _J = "J"
        case _T = "T"
        case _9 = "9"
        case _8 = "8"
        case _7 = "7"
        case _6 = "6"
        case _5 = "5"
        case _4 = "4"
        case _3 = "3"
        case _2 = "2"

        var strength: Int {
            switch self {
            case ._A: return 14
            case ._K: return 13
            case ._Q: return 12
            case ._J: return 11
            case ._T: return 10
            case ._9: return 9
            case ._8: return 8
            case ._7: return 7
            case ._6: return 6
            case ._5: return 5
            case ._4: return 4
            case ._3: return 3
            case ._2: return 2
            }
        }
    }

    struct Hand {
        var cards: [Card]
        var maxcards: [Card]
        var bid: Int

        // Fuck it... It works though.
        func weight(for part: Part) -> Int {
            let maxcards = part == .first ? cards : self.maxcards
            let map: [Card: Int] = maxcards.reduce([:]) { res, next in
                var res = res
                res[next] = (res[next] ?? 0) + 1
                return res
            }

            let mult = map.reduce(1) { result, pair in
                var power = 1
                switch pair.value {
                case 5: power = 12 // Five of a kind
                case 4: power = 11 // Four of a kind
                case 3:
                    let rest = maxcards.filter { $0 != pair.key }
                    if rest[0] == rest[1] {
                        power = 10 // Full house
                    } else {
                        power = 9 // Three of a kind
                    }
                case 2:
                    let rest = maxcards.filter { $0 != pair.key }
                    if rest[0] == rest[1] || rest[0] == rest[2] || rest[1] == rest[2] {
                        power = 8 // Two pair
                    } else {
                        power = 7 // One pair
                    }
                default:
                    power = 6
                }
                return max(result, Int(pow(16.0, Double(power))))
            }

            var strength = 0
            for (idx, card) in cards.reversed().enumerated() {
                let multiplier = part == .first ? card.strength : (card == ._J ? 1 : card.strength)
                strength += Int(pow(16.0, Double(idx))) * multiplier
            }
            return mult + strength
        }

        func maximize(cards: [Card]) -> [Card] {
            let map: [Card: Int] = cards
                .filter { $0 != ._J }
                .reduce([:]) { res, next in
                var res = res
                res[next] = (res[next] ?? 0) + 1
                return res
            }
            guard !map.isEmpty else {
                return [._A, ._A, ._A, ._A, ._A]
            }

            let pair = map.max(by: { $0.1 < $1.1 })!
            return cards.map { $0 == ._J ? pair.0 : $0 }
        }

        init<S>(str: S) where S: StringProtocol {
            let split = str.split(whereSeparator: \.isWhitespace).map { $0.trimmingCharacters(in: .whitespaces) }
            
            cards = Array(split[0]).map { Card(rawValue: String($0))! }
            maxcards = []
            bid = Int(split[1])!
            maxcards = maximize(cards: cards)
        }
    }

    func parseInput(_ input: String) -> [Hand] {
        let lines = input.split(whereSeparator: \.isNewline)
        return lines.map { Hand(str: $0) }
    }

    func runFirst(_ input: String) -> String {
        var hands = parseInput(input)
        hands.sort(by: { $0.weight(for: .first) < $1.weight(for: .first) })

        var result = 0
        for (idx, hand) in hands.enumerated() {
            result += hand.bid * (idx + 1)
        }

        return "\(result)"
    }

    func runSecond(_ input: String) -> String {
        var hands = parseInput(input)
        hands.sort(by: { $0.weight(for: .second) < $1.weight(for: .second) })

        var result = 0
        for (idx, hand) in hands.enumerated() {
            result += hand.bid * (idx + 1)
        }

        return "\(result)"
    }
}
