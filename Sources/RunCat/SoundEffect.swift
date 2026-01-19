enum SoundEffect: Int, CaseIterable {
    case jump
    case hit

    var soundPath: String {
        let name = switch self {
        case .jump: "jump"
        case .hit: "hit"
        }
        return "Sounds/\(name)"
    }
}
