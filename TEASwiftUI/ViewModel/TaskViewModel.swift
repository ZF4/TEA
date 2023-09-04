import Foundation

class TaskViewModel: ObservableObject {
    /*
     CRUD Functions live in ViewModel:
     
     Create
     Read
     Update
     Delete
     
     */
    
    @Published var items: [TaskModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            TaskModel(title: "Code", isCompleted: false, time: Date.now),
            TaskModel(title: "Finish presentation", isCompleted: true, time: Date.now),
            TaskModel(title: "Exercise", isCompleted: false, time: Date.now)
            ]
        items.append(contentsOf: newItems)
    }
    
    func addItem(title: String) {
        let newItem = TaskModel(title: title, isCompleted: false, time: Date.now)
        items.append(newItem)
    }
    
    func updateItem(item: TaskModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}
