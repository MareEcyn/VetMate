import SwiftUI

struct EmergencyView: View {
    @State private var weight = ""
    @State private var species = 0
    @FocusState private var weightIsFocused: Bool
    let model: EmergencyModel
    
    var body: some View {
        NavigationView {
            VStack {
                GroupBox {
                    NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
                        .focused($weightIsFocused)
                    SegmentedFieldView(name: "Вид", segments: ["Кошка", "Собака"], binding: $species)
                }
                .groupBoxStyle(AppGroupBoxStyle())
                .padding()
                List {
                    ForEach(0..<model.drugs.count) { i in
                        DrugView(drug: model[i], weight: weight, species: Species(rawValue: species)!)
                    }
                }
                .hideKeyboardOnTap()
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            .navigationTitle("Скорая помощь")
        }
    }
}

// MARK: - Embedded views

private struct DrugView: View {
    let drug: EmergencyDrug
    let weight: String
    let species: Species
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(drug.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(drug.concentration)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    Text(drug.dosageFor(weight: weight, species: species))
                        .font(.title2)
                        .fontWeight(.medium)
                    Text(drug.unit + " " + "(\(drug.route))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

// MARK: - Preview

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView(model: EmergencyModel())
    }
}
