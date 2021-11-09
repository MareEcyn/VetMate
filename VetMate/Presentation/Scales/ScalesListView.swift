import SwiftUI
import RealmSwift

struct ScalesListView: View {
    @Binding var scaleToShow: Scale?
    @Binding var showScalesList: Bool
    @Binding var selectedAnswers: [Int: [Int]]
    @ObservedResults(Scale.self) var scales
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: {
                dissmissView()
            }, label: {
                Text("Закрыть")
            })
            .padding(.top)
        }
        List {
                ForEach(0..<scales.count) { scaleIndex in
                    VStack(alignment: .leading) {
                        Text(scales[scaleIndex].name)
                        Text(scales[scaleIndex].author)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading) // to make whole List row tappable
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showScale(atIndex: scaleIndex)
                        dissmissView()
                        selectedAnswers = [Int: [Int]]()
                    }
                }
        }
        .navigationBarTitle("df")
        .padding()
    }
    
    private func dissmissView() {
        showScalesList = false
    }

    private func showScale(atIndex index: Int) {
        scaleToShow = scales[index]
    }
}
