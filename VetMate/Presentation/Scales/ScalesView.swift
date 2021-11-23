//swiftlint:disable cyclomatic_complexity

import SwiftUI
import RealmSwift

struct ScalesView: View {
    @State var showScalesList = false
    @State var scale: Scale?
    @State var selectedAnswers = [Int: Int]() // [question table index: answer table index]
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
                                            updateAnswers(withAnswer: answer.index, forQuestion: question.index)
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
    func updateAnswers(withAnswer answer: Int, forQuestion question: Int) {
        if selectedAnswers[question] == nil {
            selectedAnswers[question] = answer
        } else {
            if selectedAnswers[question] == answer {
                selectedAnswers.removeValue(forKey: question)
            } else {
                selectedAnswers[question] = answer
            }
        }
    }
    
    func getRowColor(forRow row: Int, inSection section: Int) -> (Color, Color) {
        if selectedAnswers[section] == row {
            return (.interactiveBlue, .white)
        }
        return (.white, .black)
    }
    
    func getResult() -> Result? {
        guard let scale = scale, !selectedAnswers.isEmpty else {
            return (value: "Нет", description: "Данных")
        }
        var score = 0
        var description = ""
        for question in selectedAnswers {
            score += scale.questions[question.key].answers[question.value].score
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
        case "Шкала комы":
            switch score {
            case 15...18:
                description = "низкая вероятность"
            case 9...14:
                description = "умеренная вероятность"
            case 1...8:
                description = "высокая вероятность"
            default:
                description = "n/a"
            }
        case "Шкала боли (собаки)":
            switch score {
            case 10...12:
                description = "сильная боль"
            case 6...9:
                description = "боль средней силы"
            case 2...5:
                description = "умеренная боль"
            case 0...1:
                description = "боли нет, или она минимальна"
            default:
                description = "n/a"
            }
        case "Шкала боли (кошки)":
            switch score {
            case 10...12:
                description = "сильная боль"
            case 6...9:
                description = "боль средней силы"
            case 2...5:
                description = "умеренная боль"
            case 0...1:
                description = "боли нет, или она минимальна"
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
