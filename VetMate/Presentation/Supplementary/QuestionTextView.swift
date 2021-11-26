import SwiftUI

struct QuestionTextView: View {
    let question: String
    
    var body: some View {
        Text(question)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.fieldName)
    }
}

struct QuestionTextView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTextView(question: "question")
    }
}
