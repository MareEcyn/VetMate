import SwiftUI

struct PickerFieldView: View {
    private let name: String
    private let options: [String]
    
    @Binding var selected: Int
    
    var body: some View {
        HStack {
            QuestionTextView(question: name)
            Spacer()
            Picker(selection: $selected, label: Text(""), content: {
                ForEach(0..<options.count) { index in
                    Text(options[index]).tag(index)
                }
            })
        }
    }
    
    init(name: String, options: [String], binding: Binding<Int>) {
        self.name = name
        self.options = options
        self._selected = binding
    }
}
