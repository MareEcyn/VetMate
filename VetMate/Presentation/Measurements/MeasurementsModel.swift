import QuartzCore

class MeasurementsModel: ObservableObject {
    private var timeDelta = 0.0
    private var lastDropTime: Double?
    private var dropsRates: [Int]?
    @Published var resultVolume = 0
    private(set) var inProgress = false
    
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
