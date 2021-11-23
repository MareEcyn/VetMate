import SwiftUI
import RealmSwift

@main
struct VetMateApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            InitialView()
                .onAppear {
                    loadRealm()
                }
        }
    }
}

extension VetMateApp {
    func loadRealm() {
        let fileManager = FileManager.default
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        if !fileManager.fileExists(atPath: defaultPath!) {
            let bundleRealmURL = Bundle.main.path(forResource: "vetmate", ofType: "realm")!
            try! fileManager.copyItem(atPath: bundleRealmURL, toPath: defaultPath!)
        } else {}
    }
}
