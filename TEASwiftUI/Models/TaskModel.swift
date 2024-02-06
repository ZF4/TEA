import Foundation
import SwiftData

@Model
class TaskModel: Identifiable {
    @Attribute(.unique) let id: String
    let title: String
    var isCompleted: Bool?
    let time: Date?
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool? = nil, time: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.time = time
    }
}
extension TaskModel {
    
    static var defaults: [TaskModel] {
        [
            .init(title: "Exercise Today 🏃🏻", isCompleted: false, time: .now)
        ]
    }
}

