import Foundation
import CoreLocation

struct Animal: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let category: String
    let description: String
    let habitat: String
    let curiosities: [String]
    let image: String
    let sound: String
    let lat: Double
    let lng: Double
}

final class AnimalRepository: ObservableObject {
    @Published var animals: [Animal] = []
    
    init() { load() }
    
    func load() {
        if let url = Bundle.main.url(forResource: "animals_1000", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode([Animal].self, from: data)
                DispatchQueue.main.async {
                    self.animals = decoded
                }
            } catch {
                print("Failed to load animals: \(error)")
            }
        } else {
            print("animals_1000.json not found")
        }
    }
}
