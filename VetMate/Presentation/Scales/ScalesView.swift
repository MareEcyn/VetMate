import SwiftUI
import RealmSwift

struct ScalesView: View {
    @State var showScalesList = false
    @State var scale: Scale?
    @State var selectedAnswers = [Int: [Int]]()
    @ObservedResults(Scale.self) var scales
    typealias Result = (value: String, description: String)
    
    var body: some View {
        NavigationView {
            Group {
                if scale == nil {
                    HintView("Выберите шкалу")
                } else {
                    List {
                        /*** https://forums.swift.org/t/compile-error-generic-struct-foreach-requires-that-s-allcases-conform-to-randomaccesscollection-but-allcases-is-fine-when-using-it-directly/38417
                         */
                        ForEach(Array(scale!.questions), id: \.text) { question in
                            Section(header: ScaleSectionHeader(question.text)) {
                                ForEach(Array(question.answers), id: \.text) { answer in
                                    Text(answer.text)
                                        .font(.callout)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .contentShape(Rectangle())
                                        .listRowBackground(getRowColor(forRow: answer.index, inSection: question.index).0)
                                        .foregroundColor(getRowColor(forRow: answer.index, inSection: question.index).1)
                                        .onTapGesture {
                                            updateAnswers(forQuestion: answer.index, inSection: question.index)
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationBarTitle(scale == nil ? "Шкалы" : scale!.name, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { showScalesList = true },
                       label: {
                            Image(systemName: "list.bullet.rectangle.fill")
                                .foregroundColor(.interactiveBlue)
                })
                .popover(isPresented: $showScalesList,
                         content: {
                            ScalesListView(scaleToShow: $scale,
                                           showScalesList: $showScalesList,
                                           selectedAnswers: $selectedAnswers)
                })
            )
            .toolbar(content: {
                ToolbarItemGroup(placement: .bottomBar) {
                    if scale != nil {
                    HStack(alignment: .top) {
                        Text("Очки")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(getResult()?.value ?? "Нет")
                            Text(getResult()?.description ?? "Данных")
                        }
                    }
                    }
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
    
    func getResult() -> Result? {
        guard let scale = scale, !selectedAnswers.isEmpty else { return nil }
        var score = 0
        var description = ""
        for section in selectedAnswers {
            for answer in section.value {
                score += scale.questions[section.key].answers[answer].score
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
        return (value: String(score), description: description)
    }
}

// MARK: - Embedded views

struct ScaleSectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption2)
            .fontWeight(.bold)
    }
    
    init(_ text: String) {
        self.text = text
    }
}

// MARK: - Preview

struct ScalesView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesView()
    }
}
