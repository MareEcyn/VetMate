// swiftlint:disable multiline_literal_brackets

import SwiftUI

struct CalculatorsListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: FavoritesView()) {
                    Text("Избранное")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.favorite)
                }
                CalculatorsSectionView(name: "Инфузионная терапия",
                                items: [(name: "Физиологические потери",
                                         view: AnyView(CalculatorContainerView(PhisiologicalLossesView(name: "Физиологические потери")))),
                                        (name: "Complex volume",
                                         view: AnyView(CalculatorContainerView(ComplexVolumeView(name: "Complex volume")))),
                                        (name: "Дефицит свободной воды",
                                         view: AnyView(CalculatorContainerView(FreeWaterDeficitView(name: "Дефицит свободной воды")))),
                                        (name: "Инфузия K+",
                                         view: AnyView(CalculatorContainerView(KInfusionView(name: "Инфузия K+")))),
                                        (name: "Осмоляльность",
                                         view: AnyView(CalculatorContainerView(OsmolalityView(name: "Осмоляльность"))))
                                       ])
                CalculatorsSectionView(name: "Дозировки",
                                items: [
                                    (name: "ИПС",
                                         view: AnyView(CalculatorContainerView(CRIView(name: "ИПС")))),
                                        (name: "Дозы",
                                         view: AnyView(CalculatorContainerView(DosesView(name: "Дозы")))),
                                        (name: "Площадь поверхности тела",
                                         view: AnyView(CalculatorContainerView(BodySurfaceAreaView(name: "Площадь поверхности тела"))))
                                        ])
                CalculatorsSectionView(name: "Гемотрансфузия",
                                items: [(name: "ОЦК",
                                         view: AnyView(CalculatorContainerView(BloodVolumeView(name: "ОЦК"))))
//                                        (name: "Флеботомия",
//                                         view: CalculatorContainerView(PhlebotomyView())),
//                                        (name: "Трансфузия",
//                                         view: CalculatorContainerView(TransfusionView()))
                                       ])
                CalculatorsSectionView(name: "Газы крови",
                                items: [(name: "Дефицит анионов",
                                         view: AnyView(CalculatorContainerView(AnionDeficitView(name: "Дефицит анионов")))),
                                        (name: "Дефицит бикарбонатов",
                                         view: AnyView(CalculatorContainerView(BicarbonateDeficitView(name: "Дефицит бикарбонатов")))),
                                        (name: "Aa градиент",
                                         view: AnyView(CalculatorContainerView(AaGradientView(name: "Aa градиент")))),
                                        (name: "Кислотно-щелочной баланс",
                                         view: AnyView(CalculatorContainerView(AcidBaseBalanceView(name: "Кислотно-щелочной баланс"))))
                                       ])
//                CalculatorsSectionView(name: "Растворы",
//                                items: [(name: "Добавочный объем",
//                                         view: CalculatorContainerView(AddVolumeView())),
//                                        (name: "Итоговая концентрация",
//                                         view: CalculatorContainerView(FinalConcentrationView()))])
                CalculatorsSectionView(name: "Кардиология",
                                items: [
//                                    (name: "Эхокардиография",
//                                         view: CalculatorContainerView(EchocardiographyView())),
                                        (name: "Среднее артериальное давление",
                                         view: AnyView(CalculatorContainerView(MeanArterialPressureView(name: "Среднее артериальное давление"))))
                                ])
            }
            .navigationTitle("Расчеты")
            .listStyle(.inset)
            .padding(.top)
        }
    }
}

struct CalculatorsListView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorsListView()
    }
}

struct CalculatorsSectionView: View {
    let name: String
    let items: [(name: String, view: AnyView)]

    var body: some View {
        DisclosureGroup(name) {
            ForEach(0..<items.count) { index in
                NavigationLink(destination: items[index].view) {
                    Text(items[index].name)
                        .font(.subheadline)
                }
            }
        }
        .font(.body)
    }
}
