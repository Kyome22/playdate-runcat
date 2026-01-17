import PlaydateKit

@PlaydateMain
final class Game: PlaydateGame {
    var frameCounter = UInt8.zero
    var lastButtons = PDButtons()
    var engine = Engine()

    let catSprite = Sprite.Sprite()
    let roadSprites = (0 ..< Engine.ROADS_COUNT).map { _ in Sprite.Sprite() }

    init() {
        engine.send(.gameLaunched)

        catSprite.bounds = .init(x: 80, y: Display.height - 92, width: 80, height: 64)
        catSprite.image = try! Graphics.Bitmap(path: engine.cat.imagePath)
        catSprite.addToDisplayList()

        engine.roads.enumerated().forEach { index, road in
            roadSprites[index].bounds = .init(x: 20 * index, y: Display.height - 56, width: 20, height: 36)
            roadSprites[index].image = try! Graphics.Bitmap(path: road.imagePath)
            roadSprites[index].addToDisplayList()
        }

        Sprite.drawDisplayListSprites()
    }

    func update() -> Bool {
        let currentButtons = System.buttonState.current
        if currentButtons == .a, lastButtons.isEmpty {
            engine.send(.aButtonPressed)
        } else if currentButtons == .b.union(.left), lastButtons != .b.union(.left) {
            engine.send(.bAndLeftButtonsPressed)
        }
        lastButtons = currentButtons

        if engine.status == .playing {
            frameCounter &+= 1
            guard frameCounter >= engine.speed.rawValue else { return true }
            frameCounter = 0
            engine.send(.tickReceived)
            catSprite.image = try! Graphics.Bitmap(path: engine.cat.imagePath)
            engine.roads.enumerated().forEach { index, road in
                roadSprites[index].image = try! Graphics.Bitmap(path: road.imagePath)
            }
        }
        Sprite.drawDisplayListSprites()

        Graphics.setFont(Font.RunCat)
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
        return true
    }

    func gameWillPause() {
        System.log("Paused!")
    }
}
