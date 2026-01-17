enum Speed: UInt8 {
    case gear0 = 3
    case gear1 = 2
    case gear2 = 1

    func next() -> Speed {
        Speed(rawValue: max(rawValue - 1, 1))!
    }
}
