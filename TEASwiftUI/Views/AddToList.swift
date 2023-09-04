import SwiftUI

struct AddToList: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @EnvironmentObject var textViewModel: TextViewModel
    @EnvironmentObject var visionModel: VisionModel
    
    //Allows us to go back to previous view, look more into this.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingSheet = false
    @State var alertText: String = ""
    @State var showingAlert = false
    @State var storedItems: [StoredItem] = []
    @State var textFieldColor = #colorLiteral(red: 0.917349577, green: 0.9285115004, blue: 1, alpha: 1)
    @State private var selected = SegmentSelected.task
    
    enum SegmentSelected: String {
        case task = "Tasks"
        case textSectionOne = "Gratefuls"
        case textSectionTwo = "Rocks"
    }

    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $visionModel.textFieldText)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(textFieldColor))
                    .foregroundColor(Color.black)
                .cornerRadius(10)
                Spacer()
                
                VStack {
                    Text("Which section are you adding to?")
                        .bold()
                    
                    Picker("Which section", selection: $selected) {
                        Text(SegmentSelected.task.rawValue).tag(SegmentSelected.task)
                        
                        Text(SegmentSelected.textSectionOne.rawValue).tag(SegmentSelected.textSectionOne)
                        
                        Text(SegmentSelected.textSectionTwo.rawValue).tag(SegmentSelected.textSectionTwo)
                    }
                    .pickerStyle(.segmented)
        
                }
                //MARK: Add a lbl to tell user we have successfulky added a new item
                Spacer()
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(10)
                        
                })
                .alert(isPresented: $showingAlert, content: getAlert)
            }
            .padding(14)
            .sheet(isPresented: $showingSheet) {
                VisionView()
                    .task {
                        await visionModel.requestDataScannerAccessStatus()
                    }
            }
        }
        .navigationTitle("Add an item 🖋️")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingSheet.toggle() }, label: {
                    Image(systemName: "camera")
                })
            }
        }
    }
    
    //Func to save items to our array and push us back to TaskView
    func saveButtonPressed() {
        if TextSufficient() == true {
            switch selected {
            case .task:
                taskViewModel.addItem(title: visionModel.textFieldText.capitalizedSentence)
            case .textSectionOne:
                textViewModel.addSectionOne(title: visionModel.textFieldText.capitalizedSentence)
            case .textSectionTwo:
                textViewModel.addSectionTwo(title: visionModel.textFieldText.capitalizedSentence)
            }
            self.presentationMode.wrappedValue.dismiss()
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
}

struct AddToList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddToList()
        }
        .environmentObject(TaskViewModel())
    }
}
