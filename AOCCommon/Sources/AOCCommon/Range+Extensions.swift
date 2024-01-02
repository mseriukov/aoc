import Foundation

extension Range {
    public func split(by ranges: [Self]) -> [Self] {
        let poi: [Bound] = ranges.flatMap { [$0.lowerBound, $0.upperBound] }.sorted()
        var result: [Self] = []
        
        var lower = self.lowerBound
        for p in poi {
            if self.contains(p) {
                result.append(Self(uncheckedBounds: (lower, p)))
                lower = p
            }
        }
        result.append(Self(uncheckedBounds: (lower, self.upperBound)))
        return result
    }
}
