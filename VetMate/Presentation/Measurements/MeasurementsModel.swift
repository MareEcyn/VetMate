import QuartzCore

class MeasurementsModel: ObservableObject {
    private var timeDelta = 0.0
    private var lastDropTime: Double?
    private var dropsRates: [Int]?
    @Published var resultVolume = 0
    private var resultVolumes = [Int]()
    private(set) var inProgress = false
    var isStabilized: Bool {
        guard resultVolumes.count >= 5 else { return false }
        let subsequence = resultVolumes.suffix(5)
        let average = (subsequence.reduce(0, +) / subsequence.count)
        let allowableError = Double(average) * 0.02
        let delta = subsequence.max()! - subsequence.min()!
        return Double(delta) <= allowableError ? true : false
    }
    
    /// Update resulted volume with new drop.
    /// - Parameter volume: how many drops in ml.
    func addDrop(withVolume volume: Int) {
        if lastDropTime != nil {
            let currentTime = CACurrentMediaTime()
            timeDelta = currentTime - lastDropTime!
            lastDropTime = currentTime
            let rate = Int(3_600 / timeDelta)
            dropsRates?.append(rate)
            let ratesSum = dropsRates!.reduce(0, +)
            resultVolume = (ratesSum / dropsRates!.count) / volume
            resultVolumes.append(resultVolume)
        } else {
            dropsRates = []
            lastDropTime = CACurrentMediaTime()
        }
        inProgress = true
    }
    
    /// Drop counter state to initial values.
    func resetCounter() {
        timeDelta = 0.0
        lastDropTime = nil
        dropsRates = nil
        resultVolume = 0
        inProgress = false
    }
}
