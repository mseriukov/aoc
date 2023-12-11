import Foundation

public class Day6: Day {
    public func run(_ input: String, part: Part) -> String {
        switch part {
        case .first:
            return runFirst(input)
        case .second:
            return runSecond(input)
        }
    }

    struct GameData {
        var time: Int
        var distance: Int
    }

    func parseInput(_ input: String) -> [GameData] {
        let lines = input.split(whereSeparator: \.isNewline)
        assert(lines.count == 2, "More than two lines of input!")

        let times = lines[0].split(whereSeparator: \.isWhitespace)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .dropFirst()
            .map { Int($0)! }


        let distances = lines[1].split(whereSeparator: \.isWhitespace)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .dropFirst()
            .map { Int($0)! }

        
        return zip(times, distances).map {
            GameData(time: $0.0, distance: $0.1)
        }
    }

    func runFirst(_ input: String) -> String {
        let data = parseInput(input)
        var result = 1
        for datum in data {
            var cnt = 0
            for time in 0..<datum.time {
                if (datum.time - time) * time > datum.distance {
                    cnt += 1
                }
            }
            result *= cnt
        }

        return "\(result)"
    }

    func runSecond(_ input: String) -> String {
        let data = parseInput(input)

        let mergedData = data.reduce(("","")) { ($0.0 + "\($1.time)", $0.1 + "\($1.distance)") }

        let game = GameData(time: Int(mergedData.0)!, distance: Int(mergedData.1)!)

        var cnt = 0
        for time in 0..<game.time {
            if (game.time - time) * time > game.distance {
                cnt += 1
            }
        }

        return "\(cnt)"
    }
}
