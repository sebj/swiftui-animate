import SwiftUI

public struct AnimatableValues: Equatable {
    
    var identity = true
    
    public var opacity: Double = 1
    
    public var offsetX: CGFloat = 0
    public var offsetY: CGFloat = 0
    
    public var scale: Scale = .init(1)
}

public extension AnimatableValues {
    
    struct Scale: Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
        
        var x: CGFloat
        var y: CGFloat
        var anchor: UnitPoint
        
        public init(floatLiteral value: Double) {
            self.init(x: value, y: value)
        }
        
        public init(integerLiteral value: Int) {
            self.init(floatLiteral: CGFloat(value))
        }
        
        public init(_ scale: CGFloat, anchor: UnitPoint = .center) {
            self.init(x: scale, y: scale, anchor: anchor)
        }
        
        init(x: CGFloat, y: CGFloat, anchor: UnitPoint = .center) {
            self.x = x
            self.y = y
            self.anchor = anchor
        }
    }
}
