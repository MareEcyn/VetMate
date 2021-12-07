extension String {
    var asPositiveNumber: Double? {
        guard let value = Double(self), value > 0 else { return nil }
        return value
    }
}

extension Double {
    /// Return self with specified number of decimal places.
    /// - Parameter value: number of decimal places
    /// - Returns: truncated self
    func accuracy(_ value: Int) -> Self {
        return Double(String(format: "%.\(value)f", self))!
    }
}
