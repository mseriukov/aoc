import Foundation

public class Day3: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    func runFirst(_ input: String) -> String {
        let rows = input.split(whereSeparator: \.isNewline)
        var result = 0

        let rowsCount = rows.count
        let colsCount = rows.first!.count

        func row(at index: Int) -> [Character] {
            guard
                index >= 0,
                index < rowsCount
            else {
                return Array(String(repeating: ".", count: colsCount))
            }
            return Array(rows[index])
        }

        for rowIndex in 0..<rowsCount {
            let previousRow = row(at: rowIndex - 1)
            let currentRow = row(at: rowIndex)
            let nextRow = row(at: rowIndex + 1)

            func char(for row: [Character], at index: Int) -> Character {
                guard
                    index >= 0,
                    index < colsCount
                else {
                    return "."
                }
                return row[index]
            }

            func isSymbol(_ c: Character) -> Bool {
                !c.isNumber && c != "."
            }

            var numBuf: [Character] = []
            var hasSymbol = false

            func processNumBuf() {
                guard !numBuf.isEmpty else { return }
                let num = Int(String(numBuf))!
                print("\(num): \(hasSymbol)")
                if hasSymbol {
                    result += num
                    hasSymbol = false
                }
                numBuf = []
            }

            for colIndex in 0..<colsCount {
                let c = char(for: currentRow, at: colIndex)

                if c.isNumber {
                    numBuf.append(c)
                    let nw = char(for: previousRow, at: colIndex - 1)
                    let nn = char(for: previousRow, at: colIndex + 0)
                    let ne = char(for: previousRow, at: colIndex + 1)
                    let ww = char(for: currentRow, at: colIndex - 1)

                    let ee = char(for: currentRow, at: colIndex + 1)
                    let sw = char(for: nextRow, at: colIndex - 1)
                    let ss = char(for: nextRow, at: colIndex + 0)
                    let se = char(for: nextRow, at: colIndex + 1)
                    
                    hasSymbol = hasSymbol || [nw, nn, ne, ww, ee, sw, ss, se].map({ isSymbol($0) }).reduce(false, { $0 || $1 })
                } else {
                    processNumBuf()
                }
            }
            processNumBuf()
        }
        return "\(result)"
    }

    func runSecond(_ input: String) -> String {
        let rows = input.split(whereSeparator: \.isNewline)
        var result = 0

        let rowsCount = rows.count
        let colsCount = rows.first!.count

        func row(at index: Int) -> [Character] {
            guard
                index >= 0,
                index < rowsCount
            else {
                return Array(String(repeating: ".", count: colsCount))
            }
            return Array(rows[index])
        }

        for rowIndex in 0..<rowsCount {
            let previousRow = row(at: rowIndex - 1)
            let currentRow = row(at: rowIndex)
            let nextRow = row(at: rowIndex + 1)

            func char(for row: [Character], at index: Int) -> Character {
                guard
                    index >= 0,
                    index < colsCount
                else {
                    return "."
                }
                return row[index]
            }

            for colIndex in 0..<colsCount {
                let c = char(for: currentRow, at: colIndex)

                if c == "*" {
                    func numbers(in row: [Character]) -> [(Int, Range<Int>)] {
                        var result: [(Int, Range<Int>)] = []

                        func collect(_ idx: Int) {
                            if !numbuf.isEmpty {
                                let num = Int(String(numbuf))!
                                let range = Range(uncheckedBounds: (numStartIdx!, idx))
                                result.append((num, range))
                                numStartIdx = nil
                                numbuf = []
                            }
                        }

                        var numbuf: [Character] = []
                        var numStartIdx: Int?
                        for idx in 0..<colsCount {
                            let c =  char(for: row, at: idx)
                            if c.isNumber {
                                if numStartIdx == nil { numStartIdx = idx }
                                numbuf.append(c)
                            } else {
                                collect(idx)
                            }
                        }
                        collect(colsCount)
                        return result
                    }

                    var nums: [Int] = []

                    func processRow(_ row: [Character]) {
                        numbers(in: row)
                            .filter { $0.1.overlaps(Range(uncheckedBounds: (colIndex - 1, colIndex + 2))) }
                            .forEach { nums.append($0.0) }
                    }
                    
                    processRow(previousRow)
                    processRow(currentRow)
                    processRow(nextRow)

                    if nums.count == 2 {
                        print(nums)
                        result += nums[0] * nums[1]
                    }
                }
            }
        }
        return "\(result)"
    }
}
