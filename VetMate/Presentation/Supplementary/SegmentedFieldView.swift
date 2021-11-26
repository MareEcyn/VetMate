import SwiftUI

struct SegmentedFieldView: View {
    @Binding var selected: Int
    private let question: String
    private let options: [String]
    
    var body: some View {
        HStack(spacing: 40) {
            QuestionTextView(question: question)
            Picker(selection: $selected, label: Text(""), content: {
                ForEach(0..<options.count) { index in
                    Text(options[index]).tag(index)
                }
            })
                .pickerStyle(.segmented)
        }
    }
    
    init(question: String, options: [String], binding: Binding<Int>) {
        self.question = question
        self.options = options
        self._selected = binding
    }
}

struct SegmentedPickerQuestion_Previews: PreviewProvider {
    @State static var species = 0
    static var previews: some View {
        SegmentedFieldView(question: "Вид", options: ["Кошка", "Собака"], binding: $species)
    }
}
