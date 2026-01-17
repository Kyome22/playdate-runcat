import PlaydateKit

@PlaydateMain
final class Game: PlaydateGame {
    var logoSprite = Sprite.Sprite()
    var page: Int8 = 5

    init() {
        logoSprite.bounds = .init(x: 0, y: 0, width: 400, height: 240)
        setPage()
    }

    private func setPage() {
        let newPage = Int8(System.crankAngle / 24) % 5
        if page != newPage {
            page = newPage
            let runner = Runner(rawValue: page)!
            logoSprite.image = try! Graphics.Bitmap(path: runner.page)
            logoSprite.addToDisplayList()
        }
    }

    func update() -> Bool {
        Sprite.drawDisplayListSprites()
        setPage()
        return true
    }

    func gameWillPause() {
        System.log("Paused!")
    }
}
