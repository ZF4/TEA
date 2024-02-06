import Foundation

//Does not need to be sent to SwiftData
struct QuoteModel: Codable {
    var id = UUID()
    var quote: String
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
    }
}
