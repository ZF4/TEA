import Foundation

struct TaskModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool?
    let time: Date?

    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, time: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.time = time
    }
    
    func updateCompletion() -> TaskModel {
        return TaskModel(id: id, title: title, isCompleted: !isCompleted!, time: time!)
    }
}
