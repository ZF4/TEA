import Foundation
import SwiftUI
import SwiftData

@Observable
class CardViewModel: ObservableObject {
    var modelContext: ModelContext? = nil
    var taskSection: [TaskModel] = []
    var gratefulSection: [TextModel] = []
    var rockSection: [TextModel] = []
    let textTypes = ""
    
    init() {
        
    }
    
    //MARK: Task Section functions
    func getTaskItems() {
        let fetchDescriptor = FetchDescriptor<TaskModel>(
            sortBy: [SortDescriptor(\.time)]
        )
        do {
            taskSection = (try (modelContext?.fetch(fetchDescriptor) ?? [])) 
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addTaskItem(title: String, time: Date) {
        let newItem = TaskModel(title: title, isCompleted: false, time: time)
        modelContext?.insert(newItem)

        getTaskItems()
    }
    
    func initializeData() {
        TaskModel.defaults.forEach { modelContext?.insert($0) }
        TextModel.defaults.forEach { modelContext?.insert($0) }
        
    }
    
    func updateTaskItem(item: TaskModel) {
        item.isCompleted?.toggle()

        getTaskItems()
    }
    
    func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let task = taskSection[index]
            modelContext?.delete(task)
            getTaskItems()
        }
    }
    
    func moveTask(from: IndexSet, to: Int) {
        taskSection.move(fromOffsets: from, toOffset: to)
    }
    
    //MARK: Text Section functions
    
    func getTextItems() {
        let fetchGrateful = FetchDescriptor<TextModel>(
            predicate: #Predicate {
                $0.textType == "grateful"
            },
            sortBy: [SortDescriptor(\.title)])
        
        let fetchRock = FetchDescriptor<TextModel>(
            predicate: #Predicate {
                $0.textType == "rock"
            },
            sortBy: [SortDescriptor(\.title)])
        
        do {
            gratefulSection = (try (modelContext?.fetch(fetchGrateful) ?? []))
            
            rockSection = (try (modelContext?.fetch(fetchRock) ?? []))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addTextModel(title: String, textType: String) {
        let newItem = TextModel(title: title, textType: textType)
        modelContext?.insert(newItem)
        
        getTextItems()
    }
    
    func deleteGratefulModel(indexSet: IndexSet) {
        for index in indexSet {
            let text = gratefulSection[index]
            modelContext?.delete(text)
            getTextItems()
        }
    }
    
    func deleteRockModel(indexSet: IndexSet) {
        for index in indexSet {
            let text = rockSection[index]
            modelContext?.delete(text)
            getTextItems()
        }
    }
    
    func moveGrateful(from: IndexSet, to: Int) {
        gratefulSection.move(fromOffsets: from, toOffset: to)
    }
    
    func moveRock(from: IndexSet, to: Int) {
        rockSection.move(fromOffsets: from, toOffset: to)
    }
}

/*
 CRUD Functions live in ViewModel:
 Create
 Read
 Update
 Delete
 */
