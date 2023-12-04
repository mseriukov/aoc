import Foundation

class Node {
    let letter: Character?
    let number: Int?
    var parent: Node? = nil
    var children: [Node]

    init(letter: Character?, number: Int?, children: [Node]) {
        self.letter = letter
        self.number = number
        self.children = children
    }
}

public class Day1: Day {
    /// Search tree root node.
    lazy var root: Node = {
        let nums = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        let root: Node = Node(letter: nil, number: nil, children: [])
        for (idx, num) in nums.enumerated() {
            var node = root
            for (i, c) in num.enumerated() {
                if let child = node.children.first(where: { $0.letter == c }) {
                    node = child
                } else {
                    let child = Node(
                        letter: c,
                        number: (i + 1) == num.count ? (idx + 1) : nil,
                        children: []
                    )
                    child.parent = node
                    node.children.append(child)
                    node = child
                }
            }
        }
        return root
    }()

    public func run(_ input: String, part: Part) -> String {
        let chars = Array(input)
        var result = 0
        var digits: [Int] = []
        var node = root

        func collect() {
            result += (digits.first ?? 0) * 10 + (digits.last ?? 0)
            digits = []
            node = root
        }

        var characterIndex = 0
        var wordStartIndex = characterIndex // To handle cases like "seight".
        while characterIndex < chars.count {
            let c = chars[characterIndex]
            if c.isLetter {
                guard part == .second else {
                    characterIndex += 1
                    continue
                }
                if node === root {
                    wordStartIndex = characterIndex
                }
                if let aNode = node.children.first(where: { $0.letter == c }) {
                    node = aNode
                } else {
                    node = root
                    characterIndex = wordStartIndex + 1
                    continue // To handle cases like "twone".
                }

                if let n = node.number {
                    digits.append(n)
                    node = root
                    continue
                }
            } else if c.isNumber {
                digits.append(Int("\(c)")!)
                node = root
            } else if c.isNewline {
                collect()
            }
            characterIndex += 1
        }
        collect()
        return "\(result)"
    }
}
