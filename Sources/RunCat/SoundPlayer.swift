import PlaydateKit

struct SoundPlayer {
    private let samplePlayers: [Sound.SamplePlayer]

    init() {
        samplePlayers = SoundEffect.allCases.map {
            let player = Sound.SamplePlayer()
            player.setSample(path: $0.soundPath)
            return player
        }
    }

    func play(_ soundEffect: SoundEffect) {
        samplePlayers[soundEffect.rawValue].play()
    }
}
