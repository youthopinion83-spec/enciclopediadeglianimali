import SwiftUI
import MapKit

struct RootTabView: View {
    @EnvironmentObject var repo: AnimalRepository
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            EncyclopediaView()
                .tabItem { Label("Enciclopedia", systemImage: "book") }
                .tag(0)
            QuizHubView()
                .tabItem { Label("Quiz", systemImage: "gamecontroller") }
                .tag(1)
            DailyAnimalView()
                .tabItem { Label("Del Giorno", systemImage: "sun.max") }
                .tag(2)
            HabitatMapView()
                .tabItem { Label("Mappa", systemImage: "map") }
                .tag(3)
            ProfileView()
                .tabItem { Label("Profilo", systemImage: "person.circle") }
                .tag(4)
        }
    }
}
