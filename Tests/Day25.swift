import XCTest
@testable import aoc

final class Day25Tests: XCTestCase {
    func testDay25() throws {
        let day = Day25()
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
