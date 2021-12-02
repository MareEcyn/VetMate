// swiftlint:disable cyclomatic_complexity

import RealmSwift

class ScalesViewModel: ObservableObject {
    typealias Result = (value: String, description: String)
    @Published var activeScale: Scale?
    @Published var selectedAnswers = [Int: Int]() // [question table index: answer table index]
    @ObservedResults(Scale.self) var scales
}

extension ScalesViewModel {
    
    /// Update answers when user specified new choice.
    /// - Parameters:
    ///   - answer: answer index
    ///   - question: question index
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
    
    /// Calculate and return scale result from selected answers.
    /// - Returns: Tuple represented score as label `value` and it's descryption as label `description`
    func getResult() -> Result {
        guard let scale = activeScale, !selectedAnswers.isEmpty else {
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
            case "Шкала боли (собаки)", "Шкала боли (кошки)":
            switch score {
            case 10...12:
                description = "сильная боль"
            case 7...9:
                description = "значительная боль"
            case 4...6:
                description = "умеренная или значительная боль"
            case 1...3:
                description = "умеренная боль"
            case 0:
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
