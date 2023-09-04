import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    @EnvironmentObject var textViewModel: TextViewModel
    @EnvironmentObject var quoteViewModel: QuoteViewModel
    @State var addTask = false
    var taskSectionTitle: String = "Today we will conquer 💪"
    var gratefulSectionTitle: String = "I'm grateful for 🙌"
    var rockSectionTitle: String = "Big Rocks for today 🪨"
    
    var body: some View {
            List {
                //MARK: Task
                Section {
                    conquerSection
                } header: {
                    HStack {
                        Text(taskSectionTitle)
                            .foregroundColor(Color.secondary)
                        Spacer()
                        NavigationLink("+", destination: AddToList())
                    }
                }
                .listRowBackground(Color.secondary.opacity(0.1))
                
                //MARK: Grateful
                Section {
                    gratefulSection
                } header: {
                    HStack {
                        Text(gratefulSectionTitle)
                            .foregroundColor(Color.secondary)
                        Spacer()
                        NavigationLink("+", destination: AddToList())
                    }
                }
                .listRowBackground(Color.secondary.opacity(0.1))

                //MARK: Rock
                Section {
                    rockSection
                } header: {
                    HStack {
                        Text(rockSectionTitle)
                            .foregroundColor(Color.secondary)
                        Spacer()
                        NavigationLink("+", destination: AddToList())
                    }
                }
                .listRowBackground(Color.secondary.opacity(0.1))

                //MARK: Quote
                Section {
                    quoteSection
                } 
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("teaLogo")
                }
            }
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarItems(leading: EditButton()
                .foregroundColor(Color.white))
            .navigationBarTitleDisplayMode(.inline)

        }
    
    private var conquerSection: some View {
            ForEach(taskViewModel.items) { item in
                TaskView(model: item)
                    .onTapGesture {
                        withAnimation(.linear) {
                            taskViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: taskViewModel.deleteItem)
            .onMove(perform: taskViewModel.moveItem)
    }
    
    private var gratefulSection: some View {
        ForEach(textViewModel.sectionOne) { item in
            TextView(model: item)
            }
        .onDelete(perform: textViewModel.deleteSectionOne)
        .onMove(perform: textViewModel.moveSectionOne)
    }
    
    private var rockSection: some View {
        ForEach(textViewModel.sectionTwo) { item in
            TextView(model: item)
            }
        .onDelete(perform: textViewModel.deleteSectionTwo)
        .onMove(perform: textViewModel.moveSectionTwo)
    }
    
    private var quoteSection: some View {
        HStack {
            Spacer()
            QuoteView(model: quoteViewModel.quote)
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardView()
        }
        .environmentObject(TaskViewModel())
        .environmentObject(TextViewModel())
        .environmentObject(QuoteViewModel())
    }
    
}
