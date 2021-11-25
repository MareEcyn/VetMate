import SwiftUI
import Combine

struct NumberFieldView: View {
    @Binding var value: String
    private let name: String
    private let placeholder: String
    private let hint: String
    private let maxValue: Double
    
    var body: some View {
        HStack(spacing: 40) {
            QuestionTextView(question: name)
            HStack {
                TextField(placeholder, text: $value)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                    .font(.title2)
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.trailing)
                    .onReceive(Just(value)) { validateInput($0) }
                Text(hint)
                    .padding(.trailing)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .background(Color.white)
            .cornerRadius(8)
        }
    }

    init(name: String, placeholder: String = "", hint: String, maxValue: Double = 1000, binding: Binding<String>) {
        self.name = name
        self.placeholder = placeholder
        self.hint = hint
        self.maxValue = maxValue
        self._value = binding
    }
    
    private func validateInput(_ input: String) {
        if input.range(of: "^\\d+\\d*\\.?\\d*$", options: .regularExpression) != nil, Double(input)! <= maxValue {
            value = input
        } else if !value.isEmpty {
            value = String(input.prefix(value.count - 1))
        }
    }
}
