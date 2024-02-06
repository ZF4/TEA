import SwiftUI

struct NameView: View {
    @State var nameTextField = ""
    @AppStorage("isAskingName") private var isAskingName = true
    @AppStorage("username") private var username = ""
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(Color.black)
            
            VStack {
                Image(systemName: "face.dashed")
                    .font(.system(size: 100))
                    .foregroundStyle(Color.yellow)
                
                
                Text("Can I have your first name?")
                    .font(.title2)
                    .fontWeight(.light)
                    .padding(.bottom, 5)
                
                HStack {
                    TextField("Name", text: $nameTextField)
                        .frame(width: 200)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom, 5)
                    
                    Button(action: {
                        username = nameTextField
                        isAskingName = false
                    }, label: {
                        Image(systemName: "arrowshape.right")
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(buttonColor())
                }
            }
        }
        .frame(width: 350, height: 450)
        .cornerRadius(10)
    }
    
    func buttonColor() -> Color {
        if nameTextField.count >= 3 {
            return Color.blue
        } else {
            return Color.gray.opacity(0.5)
        }
    }
}

#Preview {
    NameView()
}
