import SwiftUI

@main
struct VetMateApp: App {
    var body: some Scene {
        WindowGroup {
            InitialView()
                .onAppear {
                    ScalesModel.getRealmConfiguration()
                }
        }
    }
}
