enum Road: UInt8, CaseIterable {
    case flat
    case hill
    case crater
    case sprout

    var imagePath: String {
        let name = switch self {
        case .flat: "flat"
        case .hill: "hill"
        case .crater: "crater"
        case .sprout: "sprout"
        }
        return "Images/Road/\(name)"
    }
}
