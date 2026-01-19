import PlaydateKit

@PlaydateMain
final class Game: PlaydateGame {
    var frameCounter = UInt8.zero
    var lastButtons = PDButtons()
    var engine = Engine()
    let renderer = Renderer()
    let soundPlayer = SoundPlayer()

    init() {
        engine.send(.gameLaunched)
        renderer.render(engine)
        engine.onJump = { self.soundPlayer.play(.jump) }
        engine.onHit = { self.soundPlayer.play(.hit) }
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
        }
        renderer.render(engine)
        return true
    }

    func gameWillPause() {
        System.log("Paused!")
    }
}
