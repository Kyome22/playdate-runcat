enum Road: UInt8, CaseIterable {
    case flat
    case hill
    case crater
    case sprout

    var imagePath: String {
        switch self {
        case .flat: "road-flat"
        case .hill: "road-hill"
        case .crater: "road-crater"
        case .sprout: "road-sprout"
        }
    }
}
