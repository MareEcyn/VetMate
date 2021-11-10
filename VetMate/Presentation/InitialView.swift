import SwiftUI

struct InitialView: View {
    var body: some View {
        TabView {
            EmergencyView(model: EmergencyModel())
                .tabItem {
                    TabItem(name: "Скорая помощь", image: "bolt.heart.fill")
                }
            CalculatorsView()
                .tabItem {
                    TabItem(name: "Расчеты", image: "x.squareroot")
                }
            ScalesView()
                .tabItem {
                    TabItem(name: "Шкалы", image: "list.triangle")
                }
            MeasurmentsView()
                .tabItem {
                    TabItem(name: "Счетчики", image: "drop")
                }
        }
    }
}

// MARK: - Embedded views

struct TabItem: View {
    let name: String
    let image: String

    var body: some View {
        Image(systemName: image)
        Text(name)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
