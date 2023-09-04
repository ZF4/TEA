import SwiftUI

struct TaskView: View {
    
    let model: TaskModel
    @State private var taskTime = Date.now
    
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
                Text("12:00pm")
                Spacer()
            }
        }
    }
}


struct TaskView_Previews: PreviewProvider {
    
    static var item1 = TaskModel(title: "item1", isCompleted: false, time: Date.now)
    static var item2 = TaskModel(title: "item2", isCompleted: true, time: Date.now)
    
    static var previews: some View {
        Group {
            TaskView(model: item1)
            TaskView(model: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}

