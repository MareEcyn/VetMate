// swiftlint:disable multiline_literal_brackets

import SwiftUI

struct CalculatorsListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: FavoritesView()) {
                    Text("Избранное")
                        .font(.body)
                }
                CalculatorsSectionView(name: "Инфузионная терапия",
                                items: [(name: "Физиологические потери",
                                         view: AnyView(CalculatorContainerView(PhisiologicalLossesView(name: "Физиологические потери")))),
                                        (name: "Complex volume",
                                         view: AnyView(CalculatorContainerView(ComplexVolumeView(name: "Complex volume"))))
//                                        (name: "Дефицит свободной воды",
//                                         view: CalculatorContainerView(FreeWaterDeficitView())),
//                                        (name: "Инфузия Калия",
//                                         view: CalculatorContainerView(KInfusionView())),
//                                        (name: "Осмоляльность",
//                                         view: CalculatorContainerView(OsmolalityView()))
                                       ])
//                CalculatorsSectionView(name: "Дозировки",
//                                items: [(name: "ИПС",
//                                         view: CalculatorContainerView(CRIView())),
//                                        (name: "Дозы",
//                                         view: CalculatorContainerView(DosesView())),
//                                        (name: "Площадь поверхности тела",
//                                         view: CalculatorContainerView(BodySurfaceAreaView()))])
//                CalculatorsSectionView(name: "Гемотрансфузия",
//                                items: [(name: "Кровь",
//                                         view: CalculatorContainerView(BloodView())),
//                                        (name: "Флеботомия",
//                                         view: CalculatorContainerView(PhlebotomyView())),
//                                        (name: "Трансфузия",
//                                         view: CalculatorContainerView(TransfusionView()))])
//                CalculatorsSectionView(name: "Газы крови",
//                                items: [(name: "Дефицит анионов",
//                                         view: CalculatorContainerView(AnionDeficitView())),
//                                        (name: "Дефицит бикарбонатов",
//                                         view: CalculatorContainerView(BicarbonateDeficitView())),
//                                        (name: "Aa градиент",
//                                         view: CalculatorContainerView(AaGradientView())),
//                                        (name: "Кислотно-щелочной баланс",
//                                         view: CalculatorContainerView(AcidBaseBalanceView()))])
//                CalculatorsSectionView(name: "Растворы",
//                                items: [(name: "Добавочный объем",
//                                         view: CalculatorContainerView(AddVolumeView())),
//                                        (name: "Итоговая концентрация",
//                                         view: CalculatorContainerView(FinalConcentrationView()))])
//                CalculatorsSectionView(name: "Кардиология",
//                                items: [(name: "Эхокардиография",
//                                         view: CalculatorContainerView(EchocardiographyView())),
//                                        (name: "Среднее артериальное давление",
//                                         view: CalculatorContainerView(MeanArterialPressureView()))])
            }
            .navigationTitle("Расчеты")
            .listStyle(.inset)
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
                        .font(.body)
                }
            }
        }
        .font(.headline)
    }
}
