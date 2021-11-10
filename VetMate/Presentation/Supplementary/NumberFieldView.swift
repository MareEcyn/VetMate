import SwiftUI
import Combine

struct NumberFieldView: View {
    @Binding var number: String
    private let question: String
    private let placeholder: String
    private let hint: String
    
    var body: some View {
        HStack(spacing: 40) {
            QuestionTextView(question: question)
            HStack {
                TextField(placeholder, text: $number)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                    .font(.title2)
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.trailing)
                    .onReceive(Just(number)) { validateInput($0) }
                Text(hint)
                    .padding(.trailing)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .background(Color.white)
            .cornerRadius(8)
        }
    }

    init(question: String, placeholder: String = "", hint: String, binding: Binding<String>) {
        self.question = question
        self.placeholder = placeholder
        self.hint = hint
        self._number = binding
    }
    
    private func validateInput(_ value: String) {
        if value.range(of: "^\\d+\\d*\\.?\\d*$", options: .regularExpression) != nil {
            number = value
        } else if !number.isEmpty {
            number = String(value.prefix(number.count - 1))
        }
    }
}

struct NumberFieldQuestion_Previews: PreviewProvider {
    @State static var binding = ""
    static var previews: some View {
        NumberFieldView(question: "Вес", hint: "кг", binding: $binding)
    }
}
