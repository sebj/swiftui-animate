import SwiftUI

public struct KeyFrame {
    let time: Double
    public var animation = Animation.default
    
    public var opacity: Double?
    
    public var offsetX: CGFloat?
    public var offsetY: CGFloat?
    
    public var scale: Scale?
    public var rotation: Rotation?
    
    public struct Rotation: Equatable {
        
        var angle: Angle
        var anchor: UnitPoint
        
        public init(_ angle: Angle, anchor: UnitPoint = .center) {
            self.angle = angle
            self.anchor = anchor
        }
    }
    
    public struct Scale: Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
        
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

// MARK: - 

public extension KeyFrame {
    
    static func start(_ configure: (inout Self) -> Void) -> Self {
        .at(0, configure)
    }
    
    static func at(_ time: Double, _ configure: (inout Self) -> Void) -> Self {
        precondition(time >= 0, "Time must be now, or in the future.")
        
        var keyFrame = KeyFrame(time: time)
        configure(&keyFrame)
        return keyFrame
    }
}
