enum Runner: Int8 {
    case page0
    case page1
    case page2
    case page3
    case page4

    var page: String {
        switch self {
        case .page0: "cat-0"
        case .page1: "cat-1"
        case .page2: "cat-2"
        case .page3: "cat-3"
        case .page4: "cat-4"
        }
    }
}
