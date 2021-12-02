// swiftlint:disable multiline_literal_brackets

import SwiftUI

struct CalculatorsListView: View {
    var body: some View {
        NavigationView {
            List {
                CalculatorsSectionView(name: "Инфузионная терапия",
                                       items: [(name: PhisiologicalLossesView.name,
                                         view: AnyView(CalculatorContainerView(PhisiologicalLossesView()))),
                                               (name: ComplexVolumeView.name,
                                         view: AnyView(CalculatorContainerView(ComplexVolumeView()))),
                                               (name: FreeWaterDeficitView.name,
                                         view: AnyView(CalculatorContainerView(FreeWaterDeficitView()))),
                                               (name: KInfusionView.name,
                                         view: AnyView(CalculatorContainerView(KInfusionView()))),
                                               (name: OsmolalityView.name,
                                         view: AnyView(CalculatorContainerView(OsmolalityView())))
                                       ])
                CalculatorsSectionView(name: "Дозировки",
                                items: [
                                    (name: CRIView.name,
                                         view: AnyView(CalculatorContainerView(CRIView()))),
                                    (name: DosesView.name,
                                         view: AnyView(CalculatorContainerView(DosesView()))),
                                    (name: BodySurfaceAreaView.name,
                                         view: AnyView(CalculatorContainerView(BodySurfaceAreaView())))
                                        ])
                CalculatorsSectionView(name: "Гемотрансфузия",
                                       items: [(name: BloodVolumeView.name,
                                         view: AnyView(CalculatorContainerView(BloodVolumeView())))
//                                        (name: "Флеботомия",
//                                         view: CalculatorContainerView(PhlebotomyView())),
//                                        (name: "Трансфузия",
//                                         view: CalculatorContainerView(TransfusionView()))
                                       ])
                CalculatorsSectionView(name: "Газы крови",
                                       items: [(name: AnionDeficitView.name,
                                         view: AnyView(CalculatorContainerView(AnionDeficitView()))),
                                               (name: BicarbonateDeficitView.name,
                                         view: AnyView(CalculatorContainerView(BicarbonateDeficitView()))),
                                               (name: AaGradientView.name,
                                         view: AnyView(CalculatorContainerView(AaGradientView()))),
                                               (name: AcidBaseBalanceView.name,
                                         view: AnyView(CalculatorContainerView(AcidBaseBalanceView())))
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
                                    (name: MeanArterialPressureView.name,
                                         view: AnyView(CalculatorContainerView(MeanArterialPressureView())))
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
