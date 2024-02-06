import SwiftUI

struct AddToList: View {
    @EnvironmentObject var taskViewModel: CardViewModel
    @EnvironmentObject var visionModel: VisionModel
    @Environment(\.dismiss) var dismiss
    @Binding var showNewScreen: Bool
    
    @State private var showingSheet = false
    @State private var timeSelected = Date()
    @State var alertText: String = ""
    @State var showingAlert = false
    @State var textSufficient = false
    @State var storedItems: [StoredModel] = []
    @State var textFieldColor = #colorLiteral(red: 0.917349577, green: 0.9285115004, blue: 1, alpha: 1)
    @State var selected = SegmentSelected.task
    
    enum SegmentSelected: String {
        case task = "Tasks"
        case textSectionOne = "Gratefuls"
        case textSectionTwo = "Rocks"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color("backgroundColor"))
            RoundedRectangle(cornerRadius: 25)
                .stroke(.blue, lineWidth: 2)
            
            ScrollView {
                HStack {
                    Spacer()
                    Text("Scan some text")
                    Image(systemName: "arrow.forward")
                    Button(action: { showingSheet.toggle() }, label: {
                        Image(systemName: "camera")
                            .foregroundStyle(Color.blue)
                            .padding(.trailing)
                    })
                }
                .padding(.top)
                
                VStack {
                    TextField("Type something here...", text: $visionModel.textFieldText)
                        .foregroundColor(Color.white)
                        .padding(.leading)
                        .frame(height: 55)
                        .cornerRadius(10)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(Color.white)
                        }
                    Spacer()
                    
                    VStack {
                        Text("Which section are you adding to?")
                            .bold()
                            .foregroundStyle(Color.white)
                        
                        Picker("Which section", selection: $selected) {
                            Text(SegmentSelected.task.rawValue).tag(SegmentSelected.task)
                            
                            Text(SegmentSelected.textSectionOne.rawValue).tag(SegmentSelected.textSectionOne)
                            
                            Text(SegmentSelected.textSectionTwo.rawValue).tag(SegmentSelected.textSectionTwo)
                        }
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(6)
                        .pickerStyle(.segmented)
                        
                    }
                    //MARK: Add a pop up alert to tell user we have successfully added a new item
                    
                    if selected == .task {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color("timeBackground"))
                            HStack() {
                                Text("Pick a time:")
                                DatePicker("", selection: $timeSelected, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                        }
                    }
                    
                    Button(action: saveButtonPressed, label: {
                        Text("Save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(newFunc())
                            .cornerRadius(10)
                        
                    })
                    .alert(isPresented: $showingAlert, content: getAlert)
                }
                .padding(.horizontal, 14)
                .sheet(isPresented: $showingSheet) {
                    VisionView()
                        .task {
                            await visionModel.requestDataScannerAccessStatus()
                        }
                }
            }
        }
        .padding(.top)
        .offset(y:50)
    }
    
    //Func to save items to our array and push us back to TaskView
    func saveButtonPressed() {
        //Method returns our time in a string formatt
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        if TextSufficient() == true {
            switch selected {
            case .task:
                taskViewModel.addTaskItem(title: visionModel.textFieldText.capitalizedSentence, time: timeSelected)
            case .textSectionOne:
                taskViewModel.addTextModel(title: visionModel.textFieldText.capitalizedSentence, textType: "grateful")
            case .textSectionTwo:
                taskViewModel.addTextModel(title: visionModel.textFieldText.capitalizedSentence, textType: "rock")
            }
            dismiss()
        }
        visionModel.textFieldText = ""
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertText))
    }
    
    func TextSufficient() -> Bool {
        if visionModel.textFieldText.count < 3 {
            alertText = "Enter more than three characters! ✍️"
            showingAlert.toggle()
            return false
        }
        return true
    }
    
    func newFunc() -> Color {
        if visionModel.textFieldText.count >= 3 {
            return Color.blue
        } else {
            return Color.gray.opacity(0.5)
        }
    }
}

struct AddToList_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            AddToList(showNewScreen: .constant(true))
        }
        .environmentObject(CardViewModel())
        .environmentObject(VisionModel())
    }
}
