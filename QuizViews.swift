import SwiftUI

struct QuizHubView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Quiz: dalle descrizioni") { QuizDescriptionView() }
                NavigationLink("Quiz: dai versi") { QuizSoundView() }
                NavigationLink("Quiz: dalle curiosità") { QuizCuriosityView() }
                NavigationLink("Quiz: a scelta multipla") { QuizMultipleChoiceView() }
            }
            .navigationTitle("Quiz")
        }
    }
}

struct QuizDescriptionView: View {
    @EnvironmentObject var repo: AnimalRepository
    @EnvironmentObject var gameCenter: GameCenterService
    @EnvironmentObject var profile: UserProfileStore
    @State private var score = 0
    @State private var idx = 0
    @State private var answer = ""
    var body: some View {
        let list = repo.animals.shuffled()
        VStack(alignment: .leading, spacing: 12) {
            Text("Punteggio: \(score)")
            Text(list[idx].description)
            TextField("La tua risposta", text: $answer).textFieldStyle(.roundedBorder)
            HStack {
                Button("Verifica") {
                    if answer.lowercased().trimmingCharacters(in: .whitespaces) == list[idx].name.lowercased() {
                        score += 10; profile.profile.completedQuizzes += 1
                    }
                    idx = (idx + 1) % list.count
                    answer = ""
                }
                Button("Invia a Game Center") { gameCenter.submit(score: score, leaderboardID: "LEADERBOARD_ID") }
            }
            Spacer()
        }.padding()
    }
}

struct QuizSoundView: View {
    @EnvironmentObject var repo: AnimalRepository
    @EnvironmentObject var audio: AudioService
    @EnvironmentObject var profile: UserProfileStore
    @State private var current = 0
    @State private var score = 0
    var body: some View {
        let list = repo.animals.shuffled()
        VStack(alignment: .leading, spacing: 12) {
            Text("Punteggio: \(score)")
            Button("Riproduci verso") { audio.play(named: list[current].sound) }
            ForEach(list.shuffled().prefix(4), id: \.id) { a in
                Button(a.name) {
                    if a.id == list[current].id { score += 10; profile.profile.correctSounds += 1 }
                    current = (current + 1) % list.count
                }.buttonStyle(.bordered)
            }
            Spacer()
        }.padding()
    }
}

struct QuizCuriosityView: View {
    @EnvironmentObject var repo: AnimalRepository
    @State private var score = 0
    @State private var current = 0
    var body: some View {
        let list = repo.animals.shuffled()
        VStack(alignment: .leading, spacing: 12) {
            Text("Punteggio: \(score)")
            Text(list[current].curiosities.joined(separator: " • "))
            let options = [list[current]] + Array(list.shuffled().prefix(3))
            ForEach(options.shuffled(), id: \.id) { a in
                Button(a.name) {
                    if a.id == list[current].id { score += 10 }
                    current = (current + 1) % list.count
                }.buttonStyle(.bordered)
            }
            Spacer()
        }.padding()
    }
}

struct QuizMultipleChoiceView: View {
    @EnvironmentObject var repo: AnimalRepository
    @State private var score = 0
    @State private var current = 0
    var body: some View {
        let list = repo.animals.shuffled()
        let question = list[current]
        VStack(alignment: .leading, spacing: 12) {
            Text("Punteggio: \(score)")
            Text("Qual è l'animale?").font(.headline)
            Text(question.description).foregroundColor(.secondary)
            let options = ([question] + Array(list.shuffled().prefix(3))).shuffled()
            ForEach(options, id: \.id) { a in
                Button(a.name) {
                    if a.id == question.id { score += 10 }
                    current = (current + 1) % list.count
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }.padding()
    }
}
