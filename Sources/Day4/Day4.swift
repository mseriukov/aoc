import Foundation

public class Day4: Day {
    struct Card {
        var id: Int
        var winning: [Int]
        var have: [Int]

        init<S>(str: S) where S: StringProtocol {
            //Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
            let str = str.dropFirst(4).trimmingCharacters(in: .whitespaces)
            let split1 = str.split(separator: ":")
            self.id = Int(split1[0])!

            let split2 = split1[1].split(separator: "|")
            let winningSplit = split2[0].split(separator: " ")
            let haveSplit = split2[1].split(separator: " ")

            self.winning = winningSplit.map { Int(String($0))! }
            self.have = haveSplit.map { Int(String($0))! }
        }

        func points() -> Int {
            var points = 0
            for num in have where winning.contains(num) {
                if points == 0 { points = 1 } else { points *= 2 }
            }
            return points
        }

        var haveWinningCount: Int {
            have.filter { winning.contains($0) }.count
        }
    }


    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    func runFirst(_ input: String) -> String {
        let lines = input.split(whereSeparator: \.isNewline)
        let cards = lines.map { Card(str: $0) }
        
        let result = cards.reduce(0, { $0 + $1.points() })

        return "\(result)"
    }

    func runSecond(_ input: String) -> String {
        let lines = input.split(whereSeparator: \.isNewline)
        let cards = lines.map { Card(str: $0) }

        var registry: [Int: Int] = [:]

        for card in cards {
            registry[card.id - 1] = 1
        }

        for idx in 0..<cards.count {
            let card = cards[idx]
            let amount = (registry[idx] ?? 0)
            let winningCount = card.haveWinningCount
            guard winningCount > 0 else { continue }
            for i in (idx + 1)...(idx + winningCount) {
                guard i > 0 && i < cards.count else { continue }
                registry[i] = (registry[i] ?? 0) + amount
            }
        }

        let result = registry.reduce(0) { $0 + $1.value }
        return "\(result)"
    }
}
