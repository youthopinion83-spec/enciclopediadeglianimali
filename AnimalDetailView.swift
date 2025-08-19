import SwiftUI
import MapKit

struct AnimalDetailView: View, Identifiable {
    var id: String { animal.id }
    let animal: Animal
    @EnvironmentObject var audio: AudioService
    @EnvironmentObject var profile: UserProfileStore
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: animal.lat, longitude: animal.lng), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Image(uiImage: UIImage(named: animal.image) ?? UIImage(named: "default_animal")!)
                    .resizable().scaledToFit().frame(maxWidth: .infinity).clipShape(RoundedRectangle(cornerRadius: 12))
                Text(animal.name).font(.largeTitle).bold()
                Text(animal.description)
                Text("Habitat: \(animal.habitat)").font(.subheadline)
                Text("Curiosità").font(.headline)
                ForEach(animal.curiosities, id: \.self) { c in Text("• " + c) }
                HStack {
                    Button("Ascolta verso") { audio.play(named: animal.sound) }.buttonStyle(.borderedProminent)
                    NavigationLink("Apri su mappa") { HabitatMapView(centerOn: animal) }.buttonStyle(.bordered)
                }
            }.padding()
        }
        .onAppear { profile.profile.exploredAnimalIDs.insert(animal.id) }
    }
}
