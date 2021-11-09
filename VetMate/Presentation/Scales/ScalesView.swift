import SwiftUI
import RealmSwift

struct ScalesView: View {
    @State var showScalesList = false
    @State var scale: Scale?
    @State var selectedAnswers = [Int: [Int]]()
    @ObservedResults(Scale.self) var scales
    
    var body: some View {
        NavigationView {
            Group {
                if scale == nil {
//                    HintView("Выберите шкалу")
                    Button("Шкалы") {
                        showScalesList = true
                    }
                    .popover(isPresented: $showScalesList, content: {
                        ScalesListView(scaleToShow: $scale,
                                       showScalesList: $showScalesList,
                                       selectedAnswers: $selectedAnswers)
//                            .environment(\.realmConfiguration, ScalesModel.getRealmConfiguration())
//                                       scales: scales.map { $0 })
                    })
                } else {
                    List {
                        ForEach(0..<scale!.sections.count) { sIndex in
                            Section(header: ScaleSectionHeader(scale!.sections[sIndex].title)) {
                                ForEach(0..<scale!.sections[sIndex].questions.count) { qIndex in
                                    Text(scale!.sections[sIndex].questions[qIndex].text)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .contentShape(Rectangle())
                                        .listRowBackground(getRowColor(forRow: qIndex, inSection: sIndex).0)
                                        .foregroundColor(getRowColor(forRow: qIndex, inSection: sIndex).1)
                                        .onTapGesture {
                                            updateAnswers(forQuestion: qIndex, inSection: sIndex)
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle(scale == nil ? "Шкалы" : scale!.name)
            .toolbar(content: {
                ToolbarItemGroup(placement: .bottomBar) {
                    Text(getScore())
                        .font(.body)
                        .padding(.leading)
                    Spacer()
//                    Button("Шкалы") {
//                        showScalesList = true
//                    }
//                    .popover(isPresented: $showScalesList, content: {
////                        ScalesListView(scaleToShow: $scale,
////                                       showScalesList: $showScalesList,
////                                       selectedAnswers: $selectedAnswers,
////                                       scales: scales.map { $0 })
//                        ScalesListView()
//                    })
                }
            })
        }
    }
}

extension ScalesView {
    func updateAnswers(forQuestion question: Int, inSection section: Int) {
        if selectedAnswers[section] == nil {
            selectedAnswers[section] = [question]
        } else {
            if let qIndex = selectedAnswers[section]?.firstIndex(of: question) {
                selectedAnswers[section]?.remove(at: qIndex)
            } else {
                selectedAnswers[section]? = [question]
            }
        }
    }
    
    func getRowColor(forRow row: Int, inSection section: Int) -> (Color, Color) {
        if selectedAnswers[section]?.firstIndex(of: row) != nil {
            return (.interactiveBlue, .white)
        }
        return (.white, .black)
    }
    
    func getScore() -> String {
        guard let scale = scale, !selectedAnswers.isEmpty else { return "" }
        var score = 0
        var description = ""
        for section in selectedAnswers {
            for answer in section.value {
                score += scale.sections[section.key].questions[answer].score
            }
        }
        switch scale.name {
        case "Шкала Апгар #1":
            switch score {
            case 7...10:
                description = "без нарушений"
            case 4...6:
                description = "некоторые нарушения"
            case 0...3:
                description = "серьезные нарушения"
            default:
                description = "n/a"
            }
        case "Шкала Апгар #2":
            switch score {
            case 10...14:
                description = "без нарушений"
            case 5...9:
                description = "некоторые нарушения"
            case 0...4:
                description = "серьезные нарушения"
            default:
                description = "n/a"
            }
        default:
            description = "n/a"
        }
        return String(score) + " \(description)"
    }
}

struct ScaleSectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.bold)
    }
    
    init(_ text: String) {
        self.text = text
    }
}

struct ScalesView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesView()
    }
}
