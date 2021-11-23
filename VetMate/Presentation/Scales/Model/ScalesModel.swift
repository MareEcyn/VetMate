import RealmSwift
import Foundation

struct ScalesModel {
    static func getRealmConfiguration() {
        let fileManager = FileManager.default
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        if !fileManager.fileExists(atPath: defaultPath!) {
            let bundleRealmURL = Bundle.main.path(forResource: "vetmate", ofType: "realm")!
            try! fileManager.copyItem(atPath: bundleRealmURL, toPath: defaultPath!)
        } else {}
    }
}
