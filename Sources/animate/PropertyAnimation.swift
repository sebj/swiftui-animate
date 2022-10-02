import SwiftUI

public struct KeyFrame {
    let time: Double
    var from = AnimatableValues()
    var to = AnimatableValues()
    public var animation = Animation.default
    
    public func after(_ delay: Double) -> Self {
        .init(time: time + delay, from: from, to: to, animation: animation)
    }
}

public extension KeyFrame {
    
    private mutating func animate<Value>(keyPath: WritableKeyPath<AnimatableValues, Value>, from: Value, to: Value) {
        self.from[keyPath: keyPath] = from
        self.to[keyPath: keyPath] = to
    }
    
    mutating func opacity(from: Double, to: Double) {
        animate(keyPath: \.opacity, from: from, to: to)
    }
    
    mutating func offsetX(from: CGFloat, to: CGFloat) {
        animate(keyPath: \.offsetX, from: from, to: to)
    }
    
    mutating func offsetY(from: CGFloat, to: CGFloat) {
        animate(keyPath: \.offsetY, from: from, to: to)
    }
    
    mutating func scale(from: AnimatableValues.Scale = 1, to: AnimatableValues.Scale) {
        animate(keyPath: \.scale, from: from, to: to)
    }
}

public extension View {
    
    func keyFrame(at time: Double = 0.0, makeKeyFrame: (inout KeyFrame) -> Void) -> some View {
        var keyFrame = KeyFrame(time: time)
        makeKeyFrame(&keyFrame)
        return ModifiedContent(content: self, modifier: PropertyAnimationViewModifier(keyFrame))
    }
}
