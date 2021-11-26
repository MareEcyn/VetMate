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

struct FreeWaterDeficitView: View, CalculatorModel {
    @State private var weight = ""
    @State private var currentNa = ""
    @State private var desiredNa = ""
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        NumberFieldView(name: "Текущий Na", hint: "ммоль/л", binding: $currentNa)
        NumberFieldView(name: "Требуемый Na", hint: "ммоль/л", binding: $desiredNa)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber,
              let currentNa = currentNa.asPositiveNumber,
              let desiredNa = desiredNa.asPositiveNumber
        else { return nil }
        let result = (( currentNa / desiredNa) - 1) * weight * 0.6
        return
            """
            Дефицит: -\(abs(result).accuracy(1)) л
            """
    }
}

struct KInfusionView: View, CalculatorModel {
    @State private var potassium = ""
    @State private var solutionVolumeIndex = 0
    @State private var solutionTypeIndex = 0
    @State private var weight = ""
    @State private var solutionVolume = ""
    let solutionVolumes = ["100 мл", "250 мл", "500 мл", "1000 мл", "Другое"]
    let solutionTypes = ["NaCl 0.9%", "Раствор Рингера"]
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Калий", hint: "ммоль/л", binding: $potassium)
        PickerFieldView(name: "Объем раствора", options: solutionVolumes, binding: $solutionVolumeIndex)
        if solutionVolumeIndex == solutionVolumes.count - 1 {
            NumberFieldView(name: "", hint: "мл", binding: $solutionVolume)
        }
        PickerFieldView(name: "Тип раствора", options: solutionTypes, binding: $solutionTypeIndex)
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let potassium = potassium.asPositiveNumber
        else { return nil }
        let result = 0
        return
            """
            idk
            """
    }
}

struct OsmolalityView: View, CalculatorModel {
    @State private var sodium = ""
    @State private var bun = "" // blood urea nitrogen
    @State private var glucose = ""
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Натрий", hint: "ммоль/л", binding: $sodium)
        NumberFieldView(name: "Азот мочевины", hint: "ммоль/л", binding: $bun)
        NumberFieldView(name: "Глюкоза", hint: "ммоль/л", binding: $glucose)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let sodium = sodium.asPositiveNumber,
              let bun = bun.asPositiveNumber,
              let glucose = glucose.asPositiveNumber
        else { return nil }
        let result = (2 * sodium) + bun + glucose
        return
            """
            Осмоляльность: \(Int(result)) мОсм/кг
            """
    }
}

struct CRIView: View, CalculatorModel {
    @State private var weight = ""
    @State private var doseValue = ""
    @State private var doseUnitIndex = 0
    @State private var speedValue = ""
    @State private var speedUnitIndex = 0
    @State private var injectorVolumeIndex = 0
    @State private var concentration = ""
    let doseUnits = ["мг/кг/ч", "мкг/кг/ч", "мг/кг/мин", "мкг/кг/мин"]
    let speedUnits = ["мл/ч", "мл/мин"]
    let injectorVolumes = ["10", "20", "60"]
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Масса", hint: "кг", binding: $weight)
        NumberAndPickerFieldView(name: "Доза", options: doseUnits, numberBinding: $doseValue, pickerBinding: $doseUnitIndex)
        NumberAndPickerFieldView(name: "Скорость", options: speedUnits, numberBinding: $speedValue, pickerBinding: $speedUnitIndex)
        SegmentedFieldView(question: "Объём шприца", options: injectorVolumes, binding: $injectorVolumeIndex)
        NumberFieldView(name: "Концентрация", hint: "%", binding: $concentration)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber
        else { return nil }
        let result = 0
        return
            """
            idk
            """
    }
}

struct DosesView: View, CalculatorModel {
    @State private var weight = ""
    @State private var doseValue = ""
    @State private var doseUnitIndex = 0
    @State private var concentrationValue = ""
    @State private var concentrationUnitIndex = 0
    let doseUnits = ["мкг/кг", "мг/кг", "г/кг"]
    let concentrationUnits = ["мкг/л", "мг/л", "г/л"]
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Масса", hint: "кг", binding: $weight)
        NumberAndPickerFieldView(name: "Дозировка", options: doseUnits, numberBinding: $doseValue, pickerBinding: $doseUnitIndex)
        NumberAndPickerFieldView(name: "Концентрация", options: concentrationUnits, numberBinding: $concentrationValue, pickerBinding: $concentrationUnitIndex)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber
        else { return nil }
        let result = 0
        return
            """
            idk
            """
    }
}

struct BodySurfaceAreaView: View, CalculatorModel {
    @State private var species = 1
    @State private var weight = ""
    
    let name: String
    
    var body: some View {
        SegmentedFieldView(question: "Вид", options: ["Кошка", "Собака"], binding: $species)
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber
        else { return nil }
        var result = 0.0
        if species == 0 { result = 0.101 * Double(pow(weight, 2 / 3)) }
        else { result = 0.1 * Double(pow(weight, 2 / 3)) }
        return
            """
            Площадь поверхности тела: \(result.accuracy(4)) м2
            """
    }
}

struct BloodVolumeView: View, CalculatorModel {
    @State private var species = 1
    @State private var weight = ""
    
    let name: String
    
    var body: some View {
        SegmentedFieldView(question: "Вид", options: ["Кошка", "Собака"], binding: $species)
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber
        else { return nil }
        var result = species == 0 ? 55 * weight : 86 * weight
        return
            """
            ОЦК: \(Int(result)) мл
            """
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

struct AnionDeficitView: View, CalculatorModel  {
    @State private var sodium = ""
    @State private var potassium = ""
    @State private var chlorine = ""
    @State private var bicarbonate = ""
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Натрий", hint: "мЭкв/л", binding: $sodium)
        NumberFieldView(name: "Калий", hint: "мЭкв/л", binding: $potassium)
        NumberFieldView(name: "Хлор", hint: "мЭкв/л", binding: $chlorine)
        NumberFieldView(name: "Гидрокарбонаты", hint: "мЭкв/л", binding: $bicarbonate)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let sodium = sodium.asPositiveNumber,
              let potassium = potassium.asPositiveNumber,
              let chlorine = chlorine.asPositiveNumber,
              let bicarbonate = bicarbonate.asPositiveNumber
        else { return nil }
        var result = (sodium + potassium) - (chlorine + bicarbonate)
        return
            """
            Дефицит анионов: \(Int(result)) мЭкв/л
            """
    }
}

struct BicarbonateDeficitView: View, CalculatorModel {
    @State private var species = 1
    @State private var weight = ""
    @State private var bicarbonate = ""
    
    let name: String
    
    var body: some View {
        SegmentedFieldView(question: "Вид", options: ["Кошка", "Собака"], binding: $species)
        NumberFieldView(name: "Вес", hint: "кг", binding: $weight)
        NumberFieldView(name: "Гидрокарбонаты", hint: "ммоль/л", binding: $bicarbonate)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let weight = weight.asPositiveNumber,
              let bicarbonate = bicarbonate.asPositiveNumber
        else { return nil }
        var result = 0
        return
            """
            idk
            """
    }
}

struct AaGradientView: View, CalculatorModel {
    @State private var PaO2 = ""
    @State private var PaCO2 = ""
    @State private var FIO2_valueIndex = 0
    @State private var FIO2 = ""
    let FIO2_options = ["100%", "Атмосферный", "Другой"]
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "PaO2", hint: "мм р.с.", binding: $PaO2)
        NumberFieldView(name: "PaCO2", hint: "мм р.с.", binding: $PaCO2)
        PickerFieldView(name: "FIO2", options: FIO2_options, binding: $FIO2_valueIndex)
        if FIO2_valueIndex == FIO2_options.count - 1 {
            NumberFieldView(name: "", hint: "%", binding: $FIO2)
        }
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let PaO2 = PaO2.asPositiveNumber
        else { return nil }
        var result = 0
        return
            """
            idk
            """
    }
}

struct AcidBaseBalanceView: View, CalculatorModel {
    @State private var species = 1
    @State private var pH = ""
    @State private var pCO2 = ""
    @State private var HCO3 = ""
    
    let name: String
    
    var body: some View {
        SegmentedFieldView(question: "Вид", options: ["Кошка", "Собака"], binding: $species)
        NumberFieldView(name: "pH", hint: "кг", binding: $pH)
        NumberFieldView(name: "pCO2", hint: "кПа", binding: $pCO2)
        NumberFieldView(name: "HCO3", hint: "ммоль/л", binding: $HCO3)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let pH = pH.asPositiveNumber,
              let pCO2 = pCO2.asPositiveNumber,
              let HCO3 = HCO3.asPositiveNumber
        else { return nil }
        var result = 0
        return
            """
            idk
            """
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

struct MeanArterialPressureView: View, CalculatorModel {
    @State private var systolicPressure = ""
    @State private var diastolicPressure = ""
    
    let name: String
    
    var body: some View {
        NumberFieldView(name: "Систолическое", hint: "кПа", binding: $systolicPressure)
        NumberFieldView(name: "Диастолическое", hint: "кПа", binding: $diastolicPressure)
        if let result = getResult() {
            CalculatorResultView(result)
        }
    }
    
    internal func getResult() -> String? {
        guard let systolicPressure = systolicPressure.asPositiveNumber,
              let diastolicPressure = diastolicPressure.asPositiveNumber
        else { return nil }
        var result = 0
        return
            """
            idk
            """
    }
}
