import SwiftUI
import WidgetKit
import GameKit
import MapKit
import AVFoundation

@main
struct EnciclopediaDegliAnimaliApp: App {
    @StateObject var profile = UserProfileStore()
    @StateObject var repo = AnimalRepository()
    @StateObject var audio = AudioService()
    @StateObject var gameCenter = GameCenterService()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(profile)
                .environmentObject(repo)
                .environmentObject(audio)
                .environmentObject(gameCenter)
                .onAppear { gameCenter.authenticate() }
        }
    }
}
