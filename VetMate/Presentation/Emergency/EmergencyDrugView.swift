import SwiftUI

struct EmergencyDrugView: View {
    @State private var showDescription = false
    let drug: EmergencyDrug
    let weight: String
    let species: Species
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(drug.name + " \(drug.concentration)")
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                Text(drug.administrationRoute)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    Text(drug.calculateFor(weight: weight, species: species))
                        .font(.title2)
                        .fontWeight(.medium)
                    Text(drug.unit)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Button(action: {
                    showDescription = true
                }, label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.interactiveBlue)
                })
                .popover(isPresented: $showDescription, content: {
                    Text(drug.formulaDescription)
                        .font(.caption2)
                })
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}
