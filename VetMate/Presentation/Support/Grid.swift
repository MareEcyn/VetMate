/// Namespace for design grid values.
enum Grid {
    /// Grid's base in points.
    static let base = 8
    
    /// Return grid base multiplied by multiplier.
    static func of(_ multiplier: Int) -> Int { base * multiplier }
}
