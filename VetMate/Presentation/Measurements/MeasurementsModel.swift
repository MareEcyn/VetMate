import QuartzCore

class MeasurementsModel: ObservableObject {
    /// Time interval between drops in seconds.
    private var timeDelta = 0.0
    /// Time of last drop in seconds.
    private var lastDropTime: Double?
    /// Array of rate values (drops in hour).
    private var dropsRates: [Int]?
    /// Array of calculated average volumes. Need for define if sequence has been stabilized.
    private var resultVolumes = [Int]()
    /// Represent current calculation session (takes the model new drops or not)
    private(set) var inProgress = false
    
    /// Calculated average volume at given rates in milliliters.
    @Published var resultVolume = 0
    /// Represent drop rates stabilization status.
    var isStabilized: Bool {
        guard resultVolumes.count >= 5 else { return false }
        let subsequence = resultVolumes.suffix(8) // because of duck
        let average = (subsequence.reduce(0, +) / subsequence.count)
        let allowableError = Double(average) * 0.02
        let delta = subsequence.max()! - subsequence.min()!
        return Double(delta) <= allowableError ? true : false
    }
    
    /// Update model with new drop.
    /// - Parameter quantity: how many drops in ml.
    func addDrop(quantity: Int) {
        if lastDropTime != nil {
            let currentTime = CACurrentMediaTime()
            timeDelta = currentTime - lastDropTime!
            lastDropTime = currentTime
            let rate = Int(3_600 / timeDelta)
            dropsRates?.append(rate)
            let ratesSum = dropsRates!.reduce(0, +)
            resultVolume = (ratesSum / dropsRates!.count) / quantity
            resultVolumes.append(resultVolume)
        } else {
            dropsRates = []
            lastDropTime = CACurrentMediaTime()
        }
        inProgress = true
    }
    
    /// Set counter to initial state.
    func resetCounter() {
        timeDelta = 0.0
        lastDropTime = nil
        dropsRates = nil
        resultVolume = 0
        inProgress = false
    }
}
