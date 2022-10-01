import SwiftUI

public typealias Animate = PropertyAnimation

public struct PropertyAnimation<Value> where Value: Equatable {
    
    let property: WritableKeyPath<AnimatableValues, Value>
    let from: AnimatableValues
    let to: AnimatableValues
    var animation: Animation = .default
    
    public init(
        _ property: WritableKeyPath<AnimatableValues, Value>,
        from: Value,
        to: Value,
        _ animation: Animation = .default
    ) {
        var fromValues = AnimatableValues()
        fromValues[keyPath: property] = from
        
        var toValues = AnimatableValues()
        toValues[keyPath: property] = to
        
        self.init(property, from: fromValues, to: toValues, animation)
    }
    
    fileprivate init(
        _ property: WritableKeyPath<AnimatableValues, Value>,
        from: AnimatableValues,
        to: AnimatableValues,
        _ animation: Animation = .default
    ) {
        self.property = property
        self.from = from
        self.to = to
        self.animation = animation
    }
    
    public func after(_ delay: Double) -> Self {
        .init(property, from: from, to: to, animation.delay(delay))
    }
}

extension PropertyAnimation where Value == Bool {
    static let identity: Self = PropertyAnimation(\.identity, from: true, to: true)
}
