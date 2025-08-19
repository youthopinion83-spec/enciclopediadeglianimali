import SwiftUI
import WidgetKit

struct DailyAnimalView: View {
    @EnvironmentObject var repo: AnimalRepository
    @State private var today: Animal?
    var body: some View {
        VStack(spacing: 16) {
            if let a = today {
                Image(uiImage: UIImage(named: a.image) ?? UIImage(named: "default_animal")!)
                    .resizable().scaledToFit().frame(height: 200).clipShape(RoundedRectangle(cornerRadius: 12))
                Text(a.name).font(.title).bold()
                Text(a.curiosities.first ?? "").multilineTextAlignment(.center)
            } else {
                ProgressView()
            }
        }
        .padding()
        .navigationTitle("Animale del giorno")
        .onAppear { today = repo.animals.randomElement() }
    }
}
