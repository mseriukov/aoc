import AOCCommon

extension Day {
    public static var testP1: TestData? {
        .init(
            input: """
            .|...\\....
            |.-.\\.....
            .....|-...
            ........|.
            ..........
            .........\\
            ..../.\\\\..
            .-.-/..|..
            .|....-|.\\
            ..//.|....
            """,
            output: "46"
        )
    }
    
    public static var testP2: TestData? {
        .init(
            input: testP1!.input,
            output: "51"
        )
    }
    
    public static var realInput: String {
        """
        \\.\\............/........|............/.-....................|............|.......-..............//....../../..
        ......\\.-/..|...............-...-\\......../.............-.../.............../........-................../../..
        .........\\..\\......................................................../\\.......\\.............................-.
        ....|.........-..................|..../....-......................................|.../...............|.../...
        .....|...|..-....|................/............./......./............../|.......|.....|.................../...
        .........-............../.|.-...\\..........................|..................//............-\\......|.........
        .........|...................||.........-.|/.......---...-...........\\........\\.-...\\..../......|.............
        .......|-................................................................./........../..../...................
        ......-......|......././...............................\\.....\\.........|...........|..\\-............|\\........
        |...\\.............................-...\\\\-.................|................................-.........|........
        ...\\....|.|........................-.........................\\..|............................-....|...........
        \\.........|..|./....................../..........-......|...-....................\\....-../...\\.-.....|/.......
        ......\\./................|...................-....../..................................|.......-....-.........
        ......-.........................................|....\\..................../-./-.......|........./.............
        ................|...|...\\....\\....-....//........./...../.....-..............|\\.|..\\.........\\......./\\....\\.\\
        .\\...|.....|......./....-...........|.............-..\\...-..-....................|.../.....-...........--.....
        ......................................-................../..............\\.\\\\........../.../................\\..
        .-..........|..|......................|....|.-|.....................-..../............|......./..../..\\/.-.\\..
        ..\\..\\.............../-......-................-......................................\\....../......|..........
        .........\\.....\\.......................................-../........./-....-.................\\....../..../.....
        ......-..\\..-.............|...................|....../.......\\../........../.....-............................
        .............|../.\\...\\....|...............|.........../..|-....../........../..../|.|.\\........|........\\..|.
        ..\\............|...../...................\\......................./...-.......-..........................-.....
        ....|......................|......../.|.\\.../......|...|..-.....................|................../..\\.......
        .....................................................-................/\\..-....|..........................-.\\.
        ................../...\\..........\\...........\\............................................./.../.........|.|..
        .....-......................................./....-........|.-........................|.........\\.....\\.......
        ...............\\/\\..........|.|................................|.\\......\\......\\............|...-.............
        ..................................\\.......-.........|-........../...........\\\\..\\.|../......|........\\..|.....
        ..............-...........\\.....\\\\./......................./...-...........-..........................././....
        ...-..............-..........................\\..........|...........-/........../.../...|.....................
        ...\\..............-......./-...........|............./.......-./........-..-....|......./\\.-.......\\./........
        .........|......././..\\.-......./............-....-..................|....-......../........-.........\\.......
        ....|.........................../....................-..................-...\\|............................|...
        .-........-...........|..............................|.........................................\\......-......-
        ............./......../..-....\\...............................././.......|................................|...
        .|\\../......-./........./...............-./..............\\../..............|....|........./...................
        ..................................................|............................-..............................
        .............-...................\\.......|........|.............../......-....|......../.../.-...\\|...........
        .................../..............-|........................|.............\\..\\.........................././...
        ...../.........../..-.......|........../.......|........................./......|......./..........|..........
        ../...-........../...........................-.|..\\../..................\\.....-...........|...................
        .........\\.......-.......-.\\.|......|.......||......|.\\....-...-.................-..........-..\\..............
        ................................\\./.......\\/............-................./.....\\......../....................
        /...........-......|..|....../.....\\.........|.....................................\\...................|....-.
        ...........\\.............../.......\\......................................................................\\..-
        ....../...................-..................|-\\......................-..................\\....................
        /............./...........|.....|............/.................................-....................-......\\|.
        ...............\\..|..............|............\\../.../..........................\\\\................|......./...
        ....--/............|......|......-........-...../........./.........../-..\\..|........-.......................
        |.-....-.........................|../................\\................../......\\..../.\\..|...../.../|.........
        ....................................../.........\\........-....................../.-..-.\\.....././.../.....\\..\\
        ......\\...../............./................-...........\\.................../.....-../......-..................
        ....../............../...........|......|..................................|...................|..............
        ......-../.../.|.........././..........\\.......\\........./......|..............\\.................-.........../
        ...../...|........//...../.................\\................../.\\.............-............/.........../......
        ..............-.....|................\\................/.........|.....\\.......\\....................\\.....\\....
        ..........|..........-.../..................\\.-.......................................\\..-.........|..........
        ....|..................-.....|..................|...........-......./.....-......../...|........\\....\\-.|.....
        .......................-......./......................./.-.-.........|.....|.................|................
        ...|................/......-.....|....-..-.........-|....|..................../.../....-......\\.......-......\\
        ............-.............................-...................../..............|.|.......-....................
        -....-..............|................./......../.\\............./../............../..-...-...........|.........
        .|............|..........-................./................|.....................|./....\\......./.....\\......
        ..........|\\.|...................-.............\\......|..-..\\.......\\..........\\........|......-.../........\\.
        \\.......\\....................\\..............|................................|..............-.../.............
        ......../-....................|...............-........................\\................\\..............-......
        ...|..-.............//.-.............../........-........../..|.............\\|../....................-........
        ..../.\\.-.-|.....\\.-|..../.....\\..|.........../........................-.....................-..........|.....
        ...../-..........\\.........-....................\\.............................\\............|-..\\..........|...
        ...-...../....................../-......\\...|.....-........................../.|.........|.......\\..\\.....\\../
        ...................\\...../......................./...-.....\\.-.........-...../.|...................|......./..
        ../.....|..|..\\.........|.../.................../..-............\\../........\\.....\\.....................\\.....
        .........................../...\\.|........\\...||..........\\......\\.-....|.........\\-..\\.......................
        ../.........|............................/../-||..............|-........\\............\\....\\.\\................|
        ../....|....................|.....|-.......|.................../...\\.-.\\.............-.................-......
        ....|..............................................................-|.........................................
        ..................\\-.\\/.........|../|....../|..\\...-...\\.........|/............./...\\...\\.....................
        .\\.........-../....|-......................./................/\\..\\........................................./..
        ./......................-...............|...............|................-.......................\\............
        ................\\..........././............................-....\\/..........-.../../....|.........-....|...../
        .-..-..|\\..\\/........\\./....|.......................\\.........../.....|......./-.-..../..../..................
        \\.....|........................../.|...../.-...............|.../\\...|.........|.\\|....../.-......|............
        .........-|............./..../.\\.|//.......-....-...........\\.........-..-.........\\....\\..........|..........
        ....................|.......-../.....\\-..........\\................-..................\\.-........|.............
        .....|.\\-........................./........................................../.......-.\\....-......../........
        ...................|..............\\..|/................................|/..../........../..|.................|
        .......\\...|./......../..........-............-....|...........-/.\\...-......./....\\......./........\\....../..
        ...\\............\\..........\\../................./....-......|..........................................\\......
        ............|......|......../.............\\...|.....................\\.\\\\......................................
        -.-.-......\\.......|..........-.|.....|\\....\\/..............-/..........|............|......./.........-......
        ......................../...|................./......\\............../..............-/.......\\.....\\\\..........
        ...|.|.-..-./..................../................................-....\\|........./...-..|........\\......-....
        ....\\....-../.........|....|........-./..\\../...|...../-.|.|....\\................................./...|......-
        ..............\\../..............|.|................\\......./.............../.\\......|.....|..\\...../....../...
        ............|....\\......|........|.......\\.................................................../.-..............
        .|............|...\\....................../............................................\\.......|.-.-...........
        .....-.\\|......\\.............|............|....-.........\\....|.............................../....\\....-.|...
        ............|./.........................\\...|..............................\\...|..|..............|...-........
        .-.....|..................|....-.............-..\\..-...............-....-..................-..................
        ..\\......-.-./..................................-............\\........./........-.-.............-............-
        ..../.\\--...............//..................................||................\\.................|......|......
        ..|./...\\......................|.........../........\\.....-....-.................................../-....\\....
        .........-........\\..............................|.......|......../...........|....../......|..\\.|..../.......
        ....../....-....|\\............|.....|..\\../||....................................\\.....................-......
        .....\\.....--...././......................-........\\\\............-...............\\....-....|................./
        ........./........../...-................/...........-............................................-........./.
        .........-..-...|/..\\.........................\\............\\..-........-.........-...............\\......|./.-.
        |......................-.....-..-.........../-..................|.....|.........\\./........./...-/............
        ..............-...........|-....-.../.............-........./...../.................../.......--.|....-..../..
        """
    }
}
