enum Cat {
    case running(Running)
    case jumping(Jumping)

    var violationIndices: [UInt8] {
        switch self {
        case let .running(value):
            value.violationIndices
        case let .jumping(value):
            value.violationIndices
        }
    }

    func next() -> Cat {
        switch self {
        case let .running(value):
            Cat.running(value.next())
        case let .jumping(value):
            Cat.jumping(value.next())
        }
    }
}

extension Cat {
    enum Running: UInt8, CaseIterable {
        case frame0
        case frame1
        case frame2
        case frame3
        case frame4

        var violationIndices: [UInt8] {
            switch self {
            case .frame0: [1, 2, 3]
            case .frame1: [1, 2]
            case .frame2: [1, 2]
            case .frame3: [1]
            case .frame4: [1, 3]
            }
        }

        var imagePath: String {
            "Images/Cat/running-\(rawValue)"
        }

        func next() -> Running {
            Running(rawValue: (rawValue + 1) % 5)!
        }
    }
}

extension Cat {
    enum Jumping: UInt8, CaseIterable {
        case frame0
        case frame1
        case frame2
        case frame3
        case frame4
        case frame5
        case frame6
        case frame7
        case frame8
        case frame9

        var violationIndices: [UInt8] {
            switch self {
            case .frame0: [1, 2, 3]
            case .frame1: [1, 2]
            case .frame2: [1, 2]
            case .frame3: [1, 2]
            case .frame4: [1, 2]
            case .frame5: [1]
            case .frame6: []
            case .frame7: []
            case .frame8: []
            case .frame9: [2, 3]
            }
        }

        var imagePath: String {
            "Images/Cat/jumping-\(rawValue)"
        }

        func next() -> Jumping {
            Jumping(rawValue: (rawValue + 1) % 10)!
        }
    }
}
