import SwiftUI
import RealmSwift

struct ScalesListView: View {
    let scalesList: Results<Scale>
    @Binding var activeScale: Scale?
    @Binding var selectedAnswers: [Int: Int]
    @Binding var isScaleListDisplayed: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { dissmissView() },
                   label: { Text("Закрыть") })
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 16))
                .foregroundColor(.interactiveBlue)
        }
        List {
            ForEach(scalesList, id: \.name) { scale in
                ScalesListRow(name: scale.name, author: scale.author)
                .onTapGesture {
                    dissmissView()
                    wipeAnswers()
                    showScale(scale)
                }
            }
        }.listStyle(PlainListStyle())
    }
    
    private func wipeAnswers() {
        selectedAnswers = [Int: Int]()
    }
    
    private func dissmissView() {
        isScaleListDisplayed = false
    }
    
    private func showScale(_ scale: Scale) {
        activeScale = scale
    }
}

// MARK: - Embedded views

struct ScalesListRow: View {
    let name: String
    let author: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.subheadline)
            Text(author)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading) // to make whole List row tappable
        .contentShape(Rectangle())
    }
}
