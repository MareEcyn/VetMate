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
                        viewModel.selectedAnswers.removeAll()
                    }
                }
            }
            .navigationBarTitle(viewModel.activeScale == nil ? "Шкалы" : viewModel.activeScale!.name, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { isScaleListDisplayed = true },
                       label: {
                            Image(systemName: "list.bullet.rectangle.fill")
                                .foregroundColor(.interactiveBlue)
                })
                .popover(isPresented: $isScaleListDisplayed,
                         content: {
                                ScalesListView(scalesList: viewModel.scales,
                                               activeScale: $viewModel.activeScale,
                                               selectedAnswers: $viewModel.selectedAnswers,
                                               isScaleListDisplayed: $isScaleListDisplayed)
                                }
                        )
            )
                if viewModel.activeScale != nil && !viewModel.selectedAnswers.isEmpty {
                    VStack {
                        Spacer()
                        if viewModel.activeScale!.name.contains("Шкала боли") {
                            PainScaleToolbar(score: viewModel.getResult().value,
                                             description: viewModel.getResult().description)
                        } else {
                            ScalesToolbar(score: viewModel.getResult().value,
                                          description: viewModel.getResult().description)
                        }
                    }
                }
            }
        }
    }
}

extension ScalesView {
    
    /// Allow use of separate colors for selected and unselected rows.
    /// - Parameters:
    ///   - row: index of row
    ///   - section: index of row's section
    /// - Returns: Tuple represented background and foreground colors for specified row
    private func getRowColor(forRow row: Int, inSection section: Int) -> (Color, Color) {
        if viewModel.selectedAnswers[section] == row {
            return (.interactiveBlue, .white)
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

struct ScalesToolbar: View {
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

struct PainScaleToolbar: View {
    let score: String
    let description: String
    var backgroundColor: Color {
        var color = Color.black
        switch Int(score)! {
        case 10...12:
            color = .red
        case 6...9:
            color = .orange
        case 2...5:
            color = .green
        case 0...1:
            color = .blue
        default:
            color = .black
        }
        return color
    }
    
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
