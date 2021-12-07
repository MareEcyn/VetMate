import SwiftUI
import RealmSwift

struct ScalesView: View {
    @ObservedObject var viewModel: ScalesViewModel
    @State var isScaleListDisplayed = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if viewModel.activeScale == nil {
                        HintView("Выберите шкалу")
                    } else {
                        List {
                            ForEach(Array(viewModel.activeScale!.questions), id: \.text) { question in
                                Section(header: SectionHeader(question.text)) {
                                    ForEach(Array(question.answers), id: \.text) { answer in
                                        SectionAnswer(answer.text)
                                            .listRowBackground(getRowColor(forRow: answer.index, inSection: question.index).0)
                                            .foregroundColor(getRowColor(forRow: answer.index, inSection: question.index).1)
                                            .onTapGesture {
                                                viewModel.updateAnswers(withAnswer: answer.index, forQuestion: question.index)
                                            }
                                    }
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .refreshable {
                            viewModel.currentAnswers.removeAll()
                        }
                    }
                }
                .navigationBarTitle(viewModel.activeScale == nil ? "Шкалы" : viewModel.activeScale!.name, displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: { isScaleListDisplayed = true },
                                               label: {
                                                    Image(systemName: "list.bullet.rectangle.fill")
                                                        .foregroundColor(._blue)
                                        })
                                        .popover(isPresented: $isScaleListDisplayed,
                                                 content: {
                                                    ScalesListView(scalesList: viewModel.scales,
                                                                   activeScale: $viewModel.activeScale,
                                                                   selectedAnswers: $viewModel.currentAnswers,
                                                                   isScalesListDisplayed: $isScaleListDisplayed)
                                                })
                )
                if viewModel.activeScale != nil && !viewModel.currentAnswers.isEmpty {
                    VStack {
                        Spacer()
                        if viewModel.activeScale!.name.contains("Шкала боли") {
                            PainScaleResultView(score: viewModel.getScaleResult().value,
                                                description: viewModel.getScaleResult().description)
                        } else {
                            ScalesResultView(score: viewModel.getScaleResult().value,
                                             description: viewModel.getScaleResult().description)
                        }
                    }
                }
            }
        }
    }
}

extension ScalesView {
    
    /// Return different colors for selected and unselected row state.
    /// - Parameters:
    ///   - forRow: index of a row
    ///   - inSection: index of a row's section
    /// - Returns: Tuple represented background and foreground colors for specified row
    private func getRowColor(forRow row: Int, inSection section: Int) -> (Color, Color) {
        if viewModel.currentAnswers[section] == row {
            return (._blue, .white)
        }
        return (.white, .black)
    }
}

// MARK: - Embedded views

struct SectionHeader: View {
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

struct SectionAnswer: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
    }
    
    init(_ text: String) {
        self.text = text
    }
}

struct ScalesResultView: View {
    let score: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer()
            VStack(alignment: .trailing) {
                Text(score)
                    .font(.callout)
                    .fontWeight(.bold)
                Text(description)
                    .font(.callout)
                    .fontWeight(.light)
            }
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .background(Color.white)
    }
}

struct PainScaleResultView: View {
    private var backgroundColor: Color {
        var color = Color.black
        switch Int(score)! {
        case 10...12:
            color = ._red
        case 7...9:
            color = ._orange
        case 4...6:
            color = ._yellow
        case 1...3:
            color = ._green
        case 0:
            color = ._blue
        default:
            color = ._black
        }
        return color
    }
    
    let score: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {  },
                   label: {
                Image(systemName: "eye.square.fill")
                    .foregroundColor(.white)
            })
            Spacer()
            VStack(alignment: .trailing) {
                Text(score)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(description)
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.white)
            }
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .background(backgroundColor)
    }
}
