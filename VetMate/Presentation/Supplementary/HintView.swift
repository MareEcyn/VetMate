import SwiftUI

struct HintView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
    }
    
    init(_ text: String) {
        self.text = text
    }
}
