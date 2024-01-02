import AOCCommon

extension Day {
    public static var testP1: TestData? {
        .init(
            input: """
            Time:      7  15   30
            Distance:  9  40  200
            """,
            output: "288"
        )
    }
    
    public static var testP2: TestData? {
        .init(
            input: testP1!.input,
            output: "71503"
        )
    }
    
    public static var realInput: String {
        """
        Time:        63     78     94     68
        Distance:   411   1274   2047   1035
        """
    }
}
