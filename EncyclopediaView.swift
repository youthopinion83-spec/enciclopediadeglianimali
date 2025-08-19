import SwiftUI

struct EncyclopediaView: View {
    @EnvironmentObject var repo: AnimalRepository
    @State private var query: String = ""
    @State private var selected: Animal?
    
    var filtered: [Animal] {
        if query.isEmpty { return repo.animals }
        return repo.animals.filter { $0.name.localizedCaseInsensitiveContains(query) || $0.category.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Cerca animale...", text: $query)
                        .textFieldStyle(.roundedBorder)
                }.padding(.horizontal)
                
                List(filtered) { a in
                    Button { selected = a } label: {
                        HStack {
                            Image(uiImage: UIImage(named: a.image) ?? UIImage(named: "default_animal")!).resizable().frame(width: 48, height: 48).clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(a.name).font(.headline)
                                Text(a.habitat).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                }.listStyle(.plain)
            }
            .navigationTitle("Enciclopedia")
            .sheet(item: $selected) { animal in
                AnimalDetailView(animal: animal)
            }
        }
    }
}
