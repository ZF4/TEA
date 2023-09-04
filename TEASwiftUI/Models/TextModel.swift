import Foundation

struct TextModel: Identifiable {
    let id: String
    let title: String

    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
}
