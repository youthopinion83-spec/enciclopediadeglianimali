import Foundation
import AVFoundation

final class AudioService: ObservableObject {
    private var player: AVAudioPlayer?
    func play(named: String) {
        let base = named.replacingOccurrences(of: ".wav", with: "")
        guard let url = Bundle.main.url(forResource: base, withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch { print("Audio error: \(error)") }
    }
}
