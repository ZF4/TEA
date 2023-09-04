import SwiftUI

struct QuoteView: View {
    var model: QuoteModel
    
    var body: some View {
        HStack {
            VStack {
                Text("\"\(model.quote)\"")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text("-\(model.author)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .foregroundColor(Color.gray)
            .background(Color.white.opacity(0.3))
            .cornerRadius(5)
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var item1 = QuoteModel(quote: "quote", author: "author")
    
    static var previews: some View {
        QuoteView(model: item1)
            .background(Color.gray)
    }
}
