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
        .onAppear {
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().backgroundColor = .white
            UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            UIToolbar.appearance().backgroundColor = .white
            // Apple remake nav-bar appearance in iOS 15 and we need return it's back due to visual issues
            if #available(iOS 15.0, *) {
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithDefaultBackground()
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
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
