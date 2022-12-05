/// Kotlin-like .apply and .let function
public protocol ApplyProtocol {}

public extension ApplyProtocol {

    /// Applies `block` to some `object` and returns `object`.
    /// Block receives `object` as its first parameter.
    /// - Parameter block: block which is applied to self
    /// - Returns: self
    ///
    /// # Example
    /// ```
    /// let view = UIView().apply {
    ///    $0.backgroundColor = .red
    ///    $0.translatesAutoresizingMaskIntoConstraints = false
    ///    // implicitly returns modified UIView
    /// }
    /// ```
    @inlinable
    @discardableResult
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

    /// Applies `block` to some `object` and returns block result.
    /// Block receives `object` as its first parameter.
    /// - Parameter block: block which is applied to self
    /// - Returns: block return value
    ///
    /// # Example
    /// ```
    /// let xFromFrameOriginWithAddition = UIView(frame: .zero).let {
    ///    // do something with new UIView here
    ///    return $0.frame.origin.x + 200
    /// }
    /// XCTAssertEqual(xFromFrameOriginWithAddition, 200)
    /// ```
    @inlinable
    func `let`<R>(block: (Self) -> R) -> R {
        return block(self)
    }
}

