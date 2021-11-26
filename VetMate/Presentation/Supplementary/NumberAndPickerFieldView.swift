import SwiftUI
import Combine

struct NumberAndPickerFieldView: View {
    @Binding var numberValue: String
    @Binding var pickerValue: Int
    private let name: String
    private let placeholder: String
    private let maxValue: Double
    private let options: [String]
    
    var body: some View {
        HStack(spacing: 40) {
            QuestionTextView(question: name)
            HStack {
                TextField(placeholder, text: $numberValue)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                    .font(.title2)
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.trailing)
                    .onReceive(Just(numberValue)) { validateInput($0) }
                Picker(selection: $pickerValue, label: Text(""), content: {
                    ForEach(0..<options.count) { index in
                        Text(options[index]).tag(index)
                    }
                })
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
            .background(Color.white)
            .cornerRadius(8)
        }
    }

    init(name: String, placeholder: String = "", maxValue: Double = 1000, options: [String], numberBinding: Binding<String>, pickerBinding: Binding<Int>) {
        self.name = name
        self.placeholder = placeholder
        self.maxValue = maxValue
        self.options = options
        self._numberValue = numberBinding
        self._pickerValue = pickerBinding
    }
    
    private func validateInput(_ input: String) {
        if input.range(of: "^\\d+\\d*\\.?\\d*$", options: .regularExpression) != nil, Double(input)! <= maxValue {
            numberValue = input
        } else if !numberValue.isEmpty {
            numberValue = String(input.prefix(numberValue.count - 1))
        }
    }
}
