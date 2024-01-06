import XCTest
@testable import Day20

final class DayTests: XCTestCase {
    func testDay() throws {
        let day = Day()
        if let data = Day.testP1 {
            XCTAssertEqual(day.run(data.input, part: ._1), data.output)
        }
        if let data = Day.testP2 {
            XCTAssertEqual(day.run(data.input, part: ._2), data.output)
        }
    }
}
