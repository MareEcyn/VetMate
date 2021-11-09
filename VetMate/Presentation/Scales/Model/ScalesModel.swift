import RealmSwift
import Foundation

struct ScalesModel {
    static func getRealmConfiguration() {
//        let url = Bundle.main.url(forResource: "scales", withExtension: "realm")
//        let config = Realm.Configuration(fileURL: url)
        
        let fileManager = FileManager.default
//        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        let correctRealmURL = documentDirectory.appendingPathComponent("scales.realm")
        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        if !fileManager.fileExists(atPath: defaultPath!) {
            let bundleRealmURL = Bundle.main.path(forResource: "scales", ofType: "realm")!
            try! fileManager.copyItem(atPath: bundleRealmURL, toPath: defaultPath!)
        } else {

        }
//        return config
    }
}
