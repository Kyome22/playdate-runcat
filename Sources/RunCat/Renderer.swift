import PlaydateKit

struct Renderer {
    private let catSprite = Sprite.Sprite()
    private let roadSprites = (0 ..< Engine.ROADS_COUNT).map { _ in Sprite.Sprite() }
    private let font = try! Graphics.Font(path: "RunCatFont")

    private var catRunningBitmaps = [Graphics.Bitmap]()
    private var catJumpingBitmaps = [Graphics.Bitmap]()
    private var roadBitmaps = [Graphics.Bitmap]()

    init() {
        catRunningBitmaps = Cat.Running.allCases.map { try! Graphics.Bitmap(path: $0.imagePath) }
        catJumpingBitmaps = Cat.Jumping.allCases.map { try! Graphics.Bitmap(path: $0.imagePath) }
        roadBitmaps = Road.allCases.map { try! Graphics.Bitmap(path: $0.imagePath) }

        catSprite.bounds = .init(x: 80, y: Display.height - 92, width: 80, height: 64)
        catSprite.addToDisplayList()

        for index in roadSprites.indices {
            roadSprites[index].bounds = .init(x: 20 * index, y: Display.height - 56, width: 20, height: 36)
            roadSprites[index].addToDisplayList()
        }
    }

    func render(_ engine: Engine) {
        catSprite.image = bitmap(for: engine.cat)
        for index in engine.roads.indices {
            roadSprites[index].image = bitmap(for: engine.roads[index])
        }
        Sprite.drawDisplayListSprites()

        Graphics.setFont(font)
        if engine.isAutoPlay {
            Graphics.drawText("AUTO", at: Point(x: 8, y: 8))
        }
        Graphics.drawText("SCORE:\(engine.score)", at: Point(x: Display.width - 98, y: 8))
        if engine.status == .gameOver {
            Graphics.drawText("GAME OVER!", at: Point(x: (Display.width - 100) / 2, y: (Display.height - 10) / 2 - 20))
        }
        if engine.status == .newGame || engine.status == .gameOver {
            Graphics.drawText("PRESS A TO PLAY.", at: Point(x: (Display.width - 160) / 2, y: (Display.height - 10) / 2))
        }
    }

    private func bitmap(for cat: Cat) -> Graphics.Bitmap {
        switch cat {
        case let .running(frame):
            catRunningBitmaps[Int(frame.rawValue)]
        case let .jumping(frame):
            catJumpingBitmaps[Int(frame.rawValue)]
        }
    }

    private func bitmap(for road: Road) -> Graphics.Bitmap {
        roadBitmaps[Int(road.rawValue)]
    }
}
