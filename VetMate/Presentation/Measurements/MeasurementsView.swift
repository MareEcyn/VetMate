import SwiftUI

struct MeasurementsView: View {
    @State private var tappableFieldColor = Color.white
    @State private var currentVolumeIndex = 1
    @ObservedObject var model: MeasurementsModel
    
    var body: some View {
        NavigationView {
            VStack {
                if !model.inProgress {
                    HintView("Касайтесь экрана при каждой капле")
                        .padding(40)
                } else {
                    MeasurementsResultView(text: String(model.resultVolume))
                        .foregroundColor(model.isStabilized ? ._green : ._black)
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SegmentedFieldView(name: "", segments: ["20 в мл", "60 в мл"], binding: $currentVolumeIndex)
                        .padding()
                        .onChange(of: currentVolumeIndex) { _ in
                            model.resetCounter()
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { model.resetCounter() },
                           label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(._blue)
                    })
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(tappableFieldColor)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)) {
                    tappableFieldColor = ._blue
                }
                withAnimation(.easeInOut(duration: 0.3)) {
                    tappableFieldColor = .white
                }
                let volume = currentVolumeIndex == 0 ? 20 : 60
                model.addDrop(quantity: volume)
            }
        }
    }
}

// MARK: - Embedded views

struct MeasurementsResultView: View {
    let text: String
    
    var body: some View {
        Text("\(text) мл")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

// MARK: - Previews

struct MeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementsView(model: MeasurementsModel())
    }
}
