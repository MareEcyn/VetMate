import SwiftUI

struct SegmentedFieldView: View {
    @Binding var selected: Int
    private let name: String
    private let segments: [String]
    
    var body: some View {
        HStack(spacing: 40) {
            QuestionTextView(question: name)
            Picker(selection: $selected, label: Text(""), content: {
                ForEach(0..<segments.count) { index in
                    Text(segments[index]).tag(index)
                }
            })
            .pickerStyle(.segmented)
            .onAppear {
                UISegmentedControl.appearance()
                    .selectedSegmentTintColor = UIColor(Color._blue)
                UISegmentedControl.appearance()
                    .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance()
                    .setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            }
        }
    }
    
    init(name: String, segments: [String], binding: Binding<Int>) {
        self.name = name
        self.segments = segments
        self._selected = binding
    }
}
