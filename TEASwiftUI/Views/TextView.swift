import SwiftUI
import SwiftData

struct TextView: View {
    
    var model: TextModel
    
    var body: some View {
        HStack {
            Text(model.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 5)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TextModel.self, configurations: config)
    
    let example = TextModel(title: "Test", textType: "rock")
    return TextView(model: example)
        .modelContainer(container)
}
