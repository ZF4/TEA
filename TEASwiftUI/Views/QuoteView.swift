import SwiftUI

struct QuoteView: View {
    var model: QuoteModel
    
    var body: some View {
        VStack {
            VStack {
                Text("\"\(model.quote)\"")
                    .foregroundStyle(Color.blue)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text("-\(model.author)")
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            .padding(10)
            .background (
                CustomClipShape()
                    .stroke(Color.blue, lineWidth: 2)
            )
        }
        .padding(.horizontal, 20)
    }
}

struct CustomClipShape: Shape {
    let cornerRadius: CGFloat = 10 // Adjust corner radius as needed

    func path(in rect: CGRect) -> Path {
        // Calculate the path based on the size of the text with corner radius
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        return Path(path.cgPath)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var item1 = QuoteModel(quote: "quote", author: "author")
    
    static var previews: some View {
        QuoteView(model: item1)
    }
}
