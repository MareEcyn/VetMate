import SwiftUI

struct InitialView: View {
    var body: some View {
        TabView {
            EmergencyView(model: EmergencyModel())
                .tabItem {
                    TabItem(tabName: "Скорая помощь", imageName: "bolt.heart.fill")
                }
            CalculatorsListView()
                .tabItem {
                    TabItem(tabName: "Расчеты", imageName: "x.squareroot")
                }
            ScalesView()
                .tabItem {
                    TabItem(tabName: "Шкалы", imageName: "list.triangle")
                }
//                .environment(\.realmConfiguration, ScalesModel.getRealmConfiguration())
            MeasurmentsView()
                .tabItem {
                    TabItem(tabName: "Счетчики", imageName: "drop")
                }
        }
        .onAppear(perform: {
            ScalesModel.getRealmConfiguration()
        })
    }
}

struct TabItem: View {
    let tabName: String
    let imageName: String

    var body: some View {
        Image(systemName: imageName)
        Text(tabName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
