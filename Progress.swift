import Foundation

struct UserProfile: Codable {
    var nickname: String = "Esploratore"
    var avatarSystemName: String = "pawprint"
    var exploredAnimalIDs: Set<String> = []
    var completedQuizzes: Int = 0
    var correctSounds: Int = 0
    var streakMax: Int = 0
    
    var achievedExplore1000: Bool { exploredAnimalIDs.count >= 1000 }
    var achievedStreak20: Bool { streakMax >= 20 }
    var achievedSounds200: Bool { correctSounds >= 200 }
}

final class UserProfileStore: ObservableObject {
    @Published var profile: UserProfile = .init() { didSet { save() } }
    private let key = "UserProfileStore.profile"
    
    init() { load() }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            profile = decoded
        }
    }
    func save() {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
