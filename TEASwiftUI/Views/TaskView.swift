import SwiftUI
import SwiftData

struct TaskView: View {
    
    let model: TaskModel
        
    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.isCompleted! ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(model.isCompleted! ? .blue.opacity(0.6) : .blue.opacity(0.6))

                Text(model.title)
                Spacer()
            }
            .font(.title2)
        .padding(.vertical, 5)
            
            HStack {
                Text(model.time?.localTimeString() ?? Date().formatted())
                Spacer()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskModel.self, configurations: config)
    
    let example = TaskModel(title: "Test", isCompleted: false, time: Date())
    return TaskView(model: example)
        .modelContainer(container)
}


//struct TaskView_Previews: PreviewProvider {
//    
//    static var item1 = TaskModel(title: "item1", isCompleted: false, time: Date())
//    static var item2 = TaskModel(title: "item2", isCompleted: true, time: Date())
//    
//    static var previews: some View {
//        Group {
//            TaskView(model: item1)
//            TaskView(model: item2)
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}

