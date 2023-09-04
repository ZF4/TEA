import SwiftUI

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

struct TextView_Previews: PreviewProvider {
    
    static var item1 = TextModel(title: "item1")
    
    static var previews: some View {
        TextView(model: item1)
    }
}
