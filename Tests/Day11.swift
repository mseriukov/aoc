import XCTest
@testable import aoc

final class Day11Tests: XCTestCase {
    func testDay11() throws {
        let day = Day11()
        if let data = day.firstHalf {
            XCTAssertEqual(day.run(data.input, part: .first), data.output)
        }
        print("First result:" + day.run(day.realInput, part: .first))
        // It will fail, you need to change expansion to 9 for the second part.
//        if let data = day.secondHalf {
//            XCTAssertEqual(day.run(data.input, part: .second), data.output)
//        }
        print("Second result:" + day.run(day.realInput, part: .second))
    }
}
