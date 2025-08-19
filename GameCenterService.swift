import Foundation
import GameKit
import UIKit

final class GameCenterService: ObservableObject {
    @Published var isAuthenticated = false
    
    func authenticate() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if let vc = vc {
                let scene = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }.first
                scene?.keyWindow?.rootViewController?.present(vc, animated: true)
            } else {
                self.isAuthenticated = GKLocalPlayer.local.isAuthenticated
                if let error = error { print("GC error: \(error.localizedDescription)") }
            }
        }
    }
    func submit(score: Int, leaderboardID: String) {
        guard isAuthenticated else { return }
        let gk = GKScore(leaderboardIdentifier: leaderboardID)
        gk.value = Int64(score)
        GKScore.report([gk]) { err in if let err = err { print("Submit error: \(err)") } }
    }
}

extension UIWindowScene {
    var keyWindow: UIWindow? { return self.windows.first { $0.isKeyWindow } }
}
