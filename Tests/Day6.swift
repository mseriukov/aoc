import XCTest
@testable import aoc

final class Day6Tests: XCTestCase {
    func testDay6() throws {
        let day = Day6()
        if let data = day.firstHalf {
            XCTAssertEqual(day.run(data.input, part: .first), data.output)
        }
        print("First result:" + day.run(day.realInput, part: .first))
        if let data = day.secondHalf {
            XCTAssertEqual(day.run(data.input, part: .second), data.output)
        }
        print("Second result:" + day.run(day.realInput, part: .second))
    }
}