import SwiftUI

struct MeasurementsView: View {
    @State private var tappableFieldColor = Color.white
    @State private var activeSegment = 1
    @ObservedObject var model: MeasurementsModel
    
    var body: some View {
        NavigationView {
            VStack {
                if !model.inProgress {
                    HintView("Касайтесь экрана при каждой капле")
                        .padding(40)
                } else {
                    Text("\(model.resultVolume) мл")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(model.isStabilized ? .green : .black)
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    DropVolumeView(options: ["20 в мл", "60 в мл"], binding: $activeSegment)
                        .padding()
                        .onChange(of: activeSegment) { _ in
                            model.resetCounter()
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { model.resetCounter() },
                           label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .foregroundColor(.interactiveBlue)
                    })
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(tappableFieldColor)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)) {
                    tappableFieldColor = .interactiveBlue
                                }
                withAnimation(.easeInOut(duration: 0.3)) {
                    tappableFieldColor = .white
                                }
                let volume = activeSegment == 0 ? 20 : 60
                model.addDrop(withVolume: volume)
            }
        }
    }
}

// MARK: - Previews

struct MeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementsView(model: MeasurementsModel())
    }
}

// MARK: - Embedded views

struct DropVolumeView: View {
    @Binding var selected: Int
    private let options: [String]
    
    var body: some View {
        Picker(selection: $selected, label: Text(""), content: {
            ForEach(0..<options.count) { index in
                Text(options[index]).tag(index)
            }
        })
        .pickerStyle(.segmented)
    }
    
    init(options: [String], binding: Binding<Int>) {
        self.options = options
        self._selected = binding
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = UIColor(Color.interactiveBlue)
        UISegmentedControl.appearance()
            .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance()
            .setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}
