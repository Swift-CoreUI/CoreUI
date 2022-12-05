/*
 
/// Extension for `Optional` to use as `someOptionalVar.let { ... }`
/// No actual need for this in real life, we can always use `someOptionalVar?.let { ... }`.
/// Keeping it here for future reference.
///
extension Optional where Wrapped: ApplyProtocol {
    /// Applies `block` to some optional `object` and returns block result or `nil`.
    /// If `object` is non-nil, block receives `object` as its first parameter.
    /// - Parameter block: block receiving Self as its first parameter and returning
    /// - Returns: block return value
    ///
    /// # Example
    /// ```
    /// var optionalValue: SomeClass? = nil
    /// let propertyOrNil = optionalValue.let {
    ///    return $0.someProperty
    /// }
    /// XCAssertNil(propertyOrNil)
    ///
    /// optionalValue = SomeClass()
    ///
    /// ```
    @inlinable
    func `let`<R>(block: (Wrapped) -> R?) -> R? {
        guard let `self` = self else { return nil }
        return block(self)
    }
}

*/
