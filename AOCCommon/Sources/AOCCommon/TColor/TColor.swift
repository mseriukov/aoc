import Foundation

public struct TColor24 {
    let r: UInt8
    let g: UInt8
    let b: UInt8

    init(r: UInt8, g: UInt8, b: UInt8) {
        self.r = r
        self.g = g
        self.b = b
    }
}

public extension String {
    func fc(_ c: TColor24) -> String {
        "\u{001B}[38;2;\(c.r);\(c.g);\(c.b)m" + self
    }

    func bc(_ c: TColor24) -> String {
        "\u{001B}[48;2;\(c.r);\(c.g);\(c.b)m" + self
    }

    func reset() -> String {
        self + "\u{001B}[0m"
    }
}
