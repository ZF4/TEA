import Foundation

struct QuoteModel: Codable {
    var id = UUID()
    var quote: String
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
    }
}
