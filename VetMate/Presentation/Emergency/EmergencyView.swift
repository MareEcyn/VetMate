import SwiftUI

struct EmergencyView: View {
    @State private var weight = ""
    @State private var species = 0
    let model: EmergencyModel
    
    var body: some View {
        NavigationView {
            VStack {
                GroupBox {
                    NumberFieldQuestion(question: "Вес", hint: "кг", binding: $weight)
                    SegmentedFieldQuestion(question: "Вид",
                                           options: ["Кошка", "Собака"],
                                           binding: $species)
                }
                .groupBoxStyle(AppGroupBoxStyle())
                .padding()
                List {
                    ForEach(0..<model.drugs.count) { i in
                        EmergencyDrugView(drug: model[i], weight: weight, species: Species(rawValue: species)!)
                    }
                }
                .listStyle(PlainListStyle())
                .buttonStyle(PlainButtonStyle())
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            .navigationTitle("Скорая помощь")
        }
        .hideKeyboardOnTap()
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView(model: EmergencyModel())
    }
}
