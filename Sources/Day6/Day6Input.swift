extension Day6 {
    public var firstHalf: TestData? {
        .init(
            input: """
            Time:      7  15   30
            Distance:  9  40  200
            """,
            output: "288"
        )
    }

    public var secondHalf: TestData? {
        .init(
            input: """
            Time:      7  15   30
            Distance:  9  40  200
            """,
            output: "71503"
        )
    }

    public var realInput: String { """
    Time:        63     78     94     68
    Distance:   411   1274   2047   1035
    """
    }
}
