import SwiftUI

protocol CalculatorModel {
    var name: String { get }
    func getResult() -> String?
}

// MARK: - Container view

struct CalculatorContainerView<Calculator: View & CalculatorModel>: View {
    let calculator: Calculator
    
    var body: some View {
        VStack {
            GroupBox(label: Label("Данные пациента", systemImage: "list.bullet.rectangle.portrait.fill")
                        .foregroundColor(.gray)) {
                calculator
            }
            .groupBoxStyle(AppGroupBoxStyle())
            .padding()
            Spacer()
        }
        .navigationBarTitle(calculator.name, displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {  },
                   label: {
                        Image(systemName: "star")
                            .foregroundColor(.favorite)
            })
        )
    }
    
    init(_ calculator: Calculator) {
        self.calculator = calculator
    }
}

// MARK: - Result view

struct CalculatorResultView: View {
    let result: String
    var body: some View {
        Text(result)
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
            .padding()
            .background(Color.calculatorResult)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
    init(_ result: String) {
        self.result = result
    }
}

// MARK: - Calculators

struct PhisiologicalLossesView: View, CalculatorModel {
    @State private var weight = ""
    
    let name: String
    
    var body: some View {
        VStack {
            NumberFieldView(name: "Вес", hint: "кг", maxValue: 200, binding: $weight)
            if let result = getResult() {
                CalculatorResultView(result)
            }
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber
        else { return nil }
        let result = (30 * weight) + 70
        let dailyLoss = result
        let injectionRate = result/24
        return
            """
            Потери: \(Int(dailyLoss)) мл/сутки
            Скорость введения: \(Int(injectionRate)) мл/ч
            """
    }
}

struct ComplexVolumeView: View, CalculatorModel {
    @State private var weight = ""
    @State private var dehydration = ""
    @State private var currentLosses = ""
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        NumberFieldView(name: "Дегидратация", hint: "%", binding: $dehydration)
        NumberFieldView(name: "Текущие потери", hint: "мл/ч", binding: $currentLosses)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber,
              let dehydration = dehydration.asPositiveNumber,
              let currentLosses = currentLosses.asPositiveNumber
        else { return nil }
        let losses = (30 * weight) + 70
        let result = (losses + (dehydration * weight * 10) + currentLosses)
        if dehydration >= 8 {
            return
                """
                Потери: \(Int(result)) мл/сутки
                Скорость введения: \(Int(result / 24)) мл/ч
                Рекомендуемая скорость \(Int((1 / 75 * result) / 6)) - \(Int((1 / 50 * result) / 4)) мл/ч в первые 4-6ч, и затем \(Int(result - ((1 / 50 * result) / 6) / 20)) - \(Int(result - ((1 / 50 * result) / 4) / 18)) мл/ч
                """
        } else {
            return
                """
                Потери: \(Int(result)) мл/сутки\nСкорость введения: \(Int(result/24)) мл/ч
                """
        }
    }
}

struct FreeWaterDeficitView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct KInfusionView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct OsmolalityView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CRIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DosesView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BodySurfaceAreaView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BloodView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhlebotomyView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TransfusionView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AnionDeficitView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BicarbonateDeficitView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AaGradientView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AcidBaseBalanceView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddVolumeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FinalConcentrationView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EchocardiographyView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MeanArterialPressureView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
