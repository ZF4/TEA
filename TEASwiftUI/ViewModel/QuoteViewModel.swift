import Foundation
import Combine

class QuoteViewModel: ObservableObject {
    
    @Published var quotes: [QuoteModel] = []
    @Published var quote: QuoteModel = QuoteModel(quote: "", author: "")
    @Published var hasError = false
    @Published var error: UserError?
    
    private var bagOfQuotes = Set<AnyCancellable>()
    
    init() {
        fetchQuote()
        print("did init quote")
    }

    func fetchQuote() {
        let usersUrlString = "https://zenquotes.io/api/today"
        if let url = URL(string: usersUrlString) {
            
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: [QuoteModel].self, decoder: JSONDecoder())
                .sink { res in
                    
                } receiveValue: { [weak self] quote in
                    self?.quote = quote[0]
                    print(quote)
                }
                .store(in: &bagOfQuotes)
        }
    }
    
}

extension QuoteViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
