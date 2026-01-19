struct Engine {
    static let ROADS_COUNT: Int = 20
    static let JUMP_THRESHOLD: UInt8 = 17

    private var counter = UInt8.zero
    private var limit: UInt8 = 5
    private var isJumpRequested = false
    private var sproutStock = UInt8.zero

    var status = Status.newGame
    var speed = Speed.gear0
    var score = UInt16.zero
    var cat = Cat.running(.frame0)
    var roads = [Road](repeating: .sprout, count: Int(Self.ROADS_COUNT))
    var isAutoPlay = false
    var onJump: (() -> Void)?
    var onHit: (() -> Void)?

    init() {}

    mutating func send(_ action: Action) {
        switch action {
        case .gameLaunched:
            initialize()

        case .tickReceived:
            guard judge() else {
                onHit?()
                return
            }
            updateRoads()
            updateCat()
            autoJump()

        case .aButtonPressed:
            switch status {
            case .newGame, .gameOver:
                initialize()
                status = .playing

            case .playing where !isAutoPlay:
                isJumpRequested = true

            default:
                break
            }

        case .bAndLeftButtonsPressed:
            isAutoPlay.toggle()
        }
    }

    private mutating func initialize() {
        counter = Self.JUMP_THRESHOLD
        isJumpRequested = false
        score = .zero
        speed = .gear0
        cat = .running(.frame0)
        for index in roads.indices {
            guard roads[index] == .sprout else { continue }
            roads[index] = Road(rawValue: UInt8.random(in: 0 ..< 3))!
        }
    }

    private mutating func judge() -> Bool {
        guard status == .playing else {
            return false
        }
        let sproutIndices = roads.indices.compactMap { index in
            roads[index] == .sprout ? UInt8(exactly: index) : nil
        }
        let offsettedViolationIndices = cat.violationIndices.map { $0 + 4 }
        if offsettedViolationIndices.hasCommonElements(with: sproutIndices) {
            status = .gameOver
            return false
        } else {
            return true
        }
    }

    private mutating func updateRoads() {
        if roads[0] == .sprout {
            score = min(999, score + 1)
            if score.isMultiple(of: 10) {
                speed = speed.next()
            }
        }
        counter = counter > .zero ? counter - 1 : limit - 1
        // Sprout Chance
        if counter == .zero {
            let randomValue = UInt8.random(in: 0 ..< 27)
            if randomValue.isMultiple(of: 3) { // 1/3
                sproutStock += 1
            }
            if randomValue.isMultiple(of: 9) { // 1/9
                sproutStock += 1
            }
            if randomValue.isMultiple(of: 27) { // 1/27
                sproutStock += 1
            }
            limit = sproutStock == .zero ? 5 : 10
        }
        roads.shift()
        if sproutStock > .zero {
            sproutStock -= 1
            roads[Self.ROADS_COUNT - 1] = .sprout
        } else {
            roads[Self.ROADS_COUNT - 1] = Road(rawValue: UInt8.random(in: 0 ..< 3))!
        }
    }

    private mutating func updateCat() {
        switch cat {
        case .running(.frame4) where isJumpRequested:
            cat = .jumping(.frame0)
            isJumpRequested = false

        case .jumping(.frame9) where isJumpRequested:
            cat = cat.next()
            isJumpRequested = false

        case .jumping(.frame9):
            cat = .running(.frame0)

        default:
            cat = cat.next()
            if case .jumping(.frame5) = cat {
                onJump?()
            }
        }
    }

    private mutating func autoJump() {
        if isAutoPlay, roads[Int(Self.JUMP_THRESHOLD - 1)] == .sprout {
            isJumpRequested = true
        }
    }

    enum Action {
        case gameLaunched
        case tickReceived
        case aButtonPressed
        case bAndLeftButtonsPressed
    }
}
