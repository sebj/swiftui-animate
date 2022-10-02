import Foundation
import SwiftUI

struct PropertyAnimationViewModifier: ViewModifier {
    
    @State private var values: AnimatableValues = .init()
    private let keyFrame: KeyFrame
    
    init(_ keyFrame: KeyFrame) {
        // self._values = .init(initialValue: keyFrame.from)
        self.keyFrame = keyFrame
    }
    
    func body(content: Content) -> some View {
        let scale = values[keyPath: \.scale]
        
        content
            .offset(
                x: values[keyPath: \.offsetX],
                y: values[keyPath: \.offsetY]
            )
            .scaleEffect(x: scale.x, y: scale.y, anchor: scale.anchor)
            .opacity(values[keyPath: \.opacity])
            .onAppear {
                guard keyFrame.from != keyFrame.to else {
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(keyFrame.time * 1000))) {
                    values = keyFrame.from
                    
                    withAnimation(keyFrame.animation) {
                        values = keyFrame.to
                    }
                }
            }
    }
}

extension AnimatableValues {
    
    enum Property {
        case opacity
        case offsetX
        case offsetY
        case scale
        case identity
    }
    
    func propertyChanged(from: Self) -> Property {
        if (from.opacity != self.opacity) {
            return .opacity
        } else if (from.offsetX != self.offsetX) {
            return .offsetX
        } else if (from.offsetY != self.offsetY) {
            return .offsetY
        } else if (from.scale != self.scale) {
            return .scale
        }
        
        return .identity
    }
}
