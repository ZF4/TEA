import SwiftUI
import SwiftData

struct CardView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    @AppStorage("username") private var username = "friend"
    @AppStorage("isAskingName") private var isAskingName = true
    
    @EnvironmentObject var cardViewModel: CardViewModel
    @EnvironmentObject var quoteViewModel: QuoteViewModel
    @State var addTask = false
    @State private var showCredits = false
    @State private var showAddToList = false
    @State var isEditing = false
    
    var taskSectionTitle: String = "Today we will conquer 💪"
    var gratefulSectionTitle: String = "I'm grateful for 🙌"
    var rockSectionTitle: String = "Big Rocks for today 🪨"
    
    var body: some View {
        ZStack {
            List {
                //MARK: Task
                Section {
                    conquerSection
                        .moveDisabled(true)
                } header: {
                    HStack {
                        Text(taskSectionTitle)
                            .foregroundColor(Color.secondary)
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                //MARK: Grateful
                Section {
                    gratefulSection
                        .moveDisabled(true)
                } header: {
                    HStack {
                        Text(gratefulSectionTitle)
                            .foregroundColor(Color.secondary)
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                //MARK: Rock
                Section {
                    rockSection
                        .moveDisabled(true)
                } header: {
                    HStack {
                        Text(rockSectionTitle)
                            .foregroundColor(Color.secondary)
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                //MARK: Quote
                Section {
                    ZStack(alignment: .center) {
                        quoteSection
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                            }
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring, value: isEditing)
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { self.isEditing.toggle() }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    })
                    Spacer()
                }
                
                ToolbarItem(placement: .navigation) {
                    Text("Hello, \(username)")
                        .font(.title3)
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                    Spacer()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showCredits.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    })
                    .sheet(isPresented: $showCredits) {
                        CreditView(showCredits: $showCredits)
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        showAddToList.toggle()
                    }, label: {
                        Image(systemName:showAddToList ? "xmark" : "plus")
                            .foregroundStyle(.white)
                    })
                    
                }
            }
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            
            ZStack {
                if showAddToList {
                    AddToList(showNewScreen: $showAddToList)
                        .padding(.top, 75)
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring, value: showAddToList)
            .zIndex(2.0)
        }
        .sheet(isPresented: $isAskingName) {
            NameView()
        }
        .onAppear {
            cardViewModel.modelContext = context
            
            if isFirstTimeLaunch {
                cardViewModel.initializeData()
                isFirstTimeLaunch = false
            }
            cardViewModel.getTaskItems()
            cardViewModel.getTextItems()
        }
    }
    
    //MARK: Section Layout
    private var conquerSection: some View {
        ForEach(cardViewModel.taskSection) { item in
            TaskView(model: item)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        cardViewModel.updateTaskItem(item: item)
                    }
                }
        }
        .onDelete(perform: cardViewModel.deleteTask)
        .onMove(perform: cardViewModel.moveTask)
    }
    
    private var gratefulSection: some View {
        ForEach(cardViewModel.gratefulSection) { item in
            TextView(model: item)
        }
        .onDelete(perform: cardViewModel.deleteGratefulModel)
        .onMove(perform: cardViewModel.moveGrateful)
    }
    
    private var rockSection: some View {
        ForEach(cardViewModel.rockSection) { item in
            TextView(model: item)
        }
        .onDelete(perform: cardViewModel.deleteRockModel)
        .onMove(perform: cardViewModel.moveRock)
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
        }
        .environmentObject(CardViewModel())
        .environmentObject(QuoteViewModel())
    }
    
}
