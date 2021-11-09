import SwiftUI

struct HintView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.body)
            .fontWeight(.light)
            .foregroundColor(.gray)
    }
    
    init(_ text: String) {
        self.text = text
    }
}
