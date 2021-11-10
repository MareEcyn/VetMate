// swiftlint:disable identifier_name

import Foundation

enum Species: Int {
    case feline
    case canine
}

struct EmergencyModel {
    let drugs = [
        EmergencyDrug(name: "Атропина сульфат",
                      administrationRoute: "ВВ, ВМ",
                      concentration: "0.1",
                      unit: "мл",
                      formulaDescription: "(0.02 * вес) / 1 . http://somereference.meow",
                      formula: { (w, _) in
                        let from = 0.02 * w
                        let to = 0.04 * w
                        return (from, to)
                      }),
        EmergencyDrug(name: "Гликопирролат",
                      administrationRoute: "ВВ или ВМ",
                      concentration: "0.02",
                      unit: "мл",
                      formulaDescription: "meow",
                      formula: { (w, _) in
                        let from = 0.011 * w / 0.2
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Кальция глюконат",
                      administrationRoute: "ВВ медленно",
                      concentration: "10",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 94 * w / 100
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Жидкости х1",
                      administrationRoute: "ВВ",
                      concentration: "",
                      unit: "мл/ч",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = ((30 * w) + 70) / 24
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Жидкости х1.5",
                      administrationRoute: "ВВ",
                      concentration: "",
                      unit: "мл/ч",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = (((30 * w) + 70) * 1.5) / 24
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Жидкости х2",
                      administrationRoute: "ВВ",
                      concentration: "",
                      unit: "мл/ч",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = (((30 * w) + 70) * 2) / 24
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Жидкости - шок",
                      administrationRoute: "ВВ",
                      concentration: "",
                      unit: "мл/ч",
                      formulaDescription: "",
                      formula: { (w, s) in
                        let from = (s == .feline ? 60 : 90) * w
                        return (from, nil)
                      }),
        EmergencyDrug(name: "ГЭК",
                      administrationRoute: "ВВ, макс. 20мл/кг/сут",
                      concentration: "",
                      unit: "мл/ч",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = w <= 10 ? 1 * w : 10
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Дексаметазон",
                      administrationRoute: "ВВ",
                      concentration: "0.4",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.5 * w / 4
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Диазепам",
                      administrationRoute: "ВВ",
                      concentration: "0.5",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.25 * w / 5
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Добутамин",
                      administrationRoute: "ВВ ИПС",
                      concentration: "5.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 60 * w / 50
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Доксапрам",
                      administrationRoute: "ВВ",
                      concentration: "2.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 5 * w / 20
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Допамин",
                      administrationRoute: "ИПС",
                      concentration: "0.5",
                      unit: "мкг/кг/ч",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 5 * 60 * w / 5
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Эпинефрин (low)",
                      administrationRoute: "ВВ к3-5мин",
                      concentration: "0.1",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.01 * w / 1
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Эпинефрин (high)",
                      administrationRoute: "ВВ, ИТ к3-5мин",
                      concentration: "0.1",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.1 * w / 1
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Гипертонический NACL",
                      administrationRoute: "ВВ",
                      concentration: "",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 5 * w
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Лидокаин HCL",
                      administrationRoute: "ВВ медленно болюсами",
                      concentration: "2.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, s) in
                        let from = (s == .feline ? 0.5 : 1) * w / 20
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Амиодарон",
                      administrationRoute: "ВВ",
                      concentration: "5.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 5 * w / 50
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Вазопрессин",
                      administrationRoute: "ВВ",
                      concentration: "2.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.8 * w / 20
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Маннитол",
                      administrationRoute: "ВВ в течении 10-20мин",
                      concentration: "15.0",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.5 * w / 0.15
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Налоксон HCL",
                      administrationRoute: "ВВ, ВМ",
                      concentration: "0.04",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in
                        let from = 0.01 * w / 0.4
                        return (from, nil)
                      }),
        EmergencyDrug(name: "Натрия бикарбонат",
                      administrationRoute: "ВВ",
                      concentration: "8.4",
                      unit: "мл",
                      formulaDescription: "",
                      formula: { (w, _) in (w, nil) }), // Weight of NaHCO3 = 84; prev formula - NaHCO3_weight*weight/84
    ]
    
    subscript(index: Int) -> EmergencyDrug { drugs[index] }
}

struct EmergencyDrug {
    let name: String
    let administrationRoute: String
    let concentration: String
    let unit: String
    let formulaDescription: String
    let formula: (Double, Species) -> (Double, Double?)

    func getDosageFor(weight: String, species: Species, accuracy: Int = 2) -> String {
        guard let weight = Double(weight) else { return "--" }
        let result = formula(weight, species)
        switch result {
        case (let from, nil):
            return String(format: "%.\(accuracy)f", from)
        case let (from, to):
            return String(format: "%.\(accuracy)f", from) + " - " + String(format: "%.\(accuracy)f", to!)
        }
    }
}
