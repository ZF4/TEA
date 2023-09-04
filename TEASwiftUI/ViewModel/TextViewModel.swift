import Foundation

class TextViewModel: ObservableObject {
    
    @Published var sectionOne: [TextModel] = []
    @Published var sectionTwo: [TextModel] = []

    init() {
        getItems()
    }
    
    func getItems() {
        let sectionOneItems = [
            TextModel(title: "Great friends"),
            TextModel(title: "Living next to a park")
            ]
        sectionOne.append(contentsOf: sectionOneItems)
        
        let sectionTwoItems = [
            TextModel(title: "Code on this app"),
            TextModel(title: "Read a chapter of my book")
        ]
        sectionTwo.append(contentsOf: sectionTwoItems)
        
    }
    
    func addSectionOne(title: String) {
        let newItem = TextModel(title: title)
        sectionOne.append(newItem)
    }
    
    func addSectionTwo(title: String) {
        let newItem = TextModel(title: title)
        sectionTwo.append(newItem)
    }
    //func to update text if needed (do some sort of click on index to pop up a small edit box for text)
    
//    func updateItem(item: TextModel) {
//        if let index = items.firstIndex(where: {$0.id == item.id}) {
//            items[index]
//        }
//    }
    
    func deleteSectionOne(indexSet: IndexSet) {
        sectionOne.remove(atOffsets: indexSet)
    }
    
    func moveSectionOne(from: IndexSet, to: Int) {
        sectionOne.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteSectionTwo(indexSet: IndexSet) {
        sectionTwo.remove(atOffsets: indexSet)
    }
    
    func moveSectionTwo(from: IndexSet, to: Int) {
        sectionTwo.move(fromOffsets: from, toOffset: to)
    }
}
