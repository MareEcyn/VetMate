// swiftlint:disable multiline_literal_brackets
// Due to menu generation implementation

import SwiftUI

struct CalculatorsListView: View {
    var body: some View {
        NavigationView {
            List {
                MenuSectionView(name: "Анестезиология",
                                items: [(name: "Эпидуральная анестезия",
                                         view: AnyView(EpiduralAnesthesiaView())),
                                        (name: "Регионарная анестезия",
                                         view: AnyView(RegionalAnesthesiaView()))])
                MenuSectionView(name: "Инфузионная терапия",
                                items: [(name: "Физиологические потери",
                                         view: AnyView(PhisiologicalLossesView())),
                                        (name: "Complex volume",
                                         view: AnyView(ComplexVolumeView())),
                                        (name: "Дефицит свободной воды",
                                         view: AnyView(FreeWaterDeficitView())),
                                        (name: "Инфузия Калия",
                                         view: AnyView(KInfusionView())),
                                        (name: "Осмоляльность",
                                         view: AnyView(OsmolalityView()))])
                MenuSectionView(name: "Дозировки",
                                items: [(name: "ИПС",
                                         view: AnyView(CRIView())),
                                        (name: "Дозы", // rename
                                         view: AnyView(DosesView())),
                                        (name: "Площадь поверхности тела",
                                         view: AnyView(BodySurfaceAreaView()))])
                MenuSectionView(name: "Гемотрансфузия",
                                items: [(name: "Кровь",
                                         view: AnyView(BloodView())),
                                        (name: "Флеботомия",
                                         view: AnyView(PhlebotomyView())),
                                        (name: "Трансфузия",
                                         view: AnyView(TransfusionView()))])
                MenuSectionView(name: "Газы крови",
                                items: [(name: "Дефицит анионов",
                                         view: AnyView(AnionDeficitView())),
                                        (name: "Дефицит бикарбонатов",
                                         view: AnyView(BicarbonateDeficitView())),
                                        (name: "Aa градиент",
                                         view: AnyView(AaGradientView())),
                                        (name: "Кислотно-щелочной баланс",
                                         view: AnyView(AcidBaseBalanceView()))])
                MenuSectionView(name: "Растворы",
                                items: [(name: "Добавочный объем",
                                         view: AnyView(AddVolumeView())),
                                        (name: "Итоговая концентрация",
                                         view: AnyView(FinalConcentrationView()))])
                MenuSectionView(name: "Кардиология",
                                items: [(name: "Эхокардиография",
                                         view: AnyView(EchocardiographyView())),
                                        (name: "Среднее артериальное давление",
                                         view: AnyView(MeanArterialPressureView()))])
            }
            .navigationTitle("Расчеты")
            Spacer()
        }
    }
}

struct CalculatorsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorsListView()
    }
}

struct MenuSectionView: View {
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
