import SwiftUI

struct PropertyAnimationViewModifier<Value>: ViewModifier where Value: Equatable {
    
    @State private var values: AnimatableValues
    private let animation: PropertyAnimation<Value>
    
    init(_ animation: PropertyAnimation<Value>) {
        self._values = .init(initialValue: animation.from)
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        ModifiedContent(
            content: content,
            modifier: AnimatableValueModifier(property: animation.property, values: values)
        )
        .onAppear {
            guard animation.property != \.identity, animation.to != animation.from else {
                return
            }

            withAnimation(animation.animation) {
                values = animation.to
            }
        }
    }
}

private struct AnimatableValueModifier<Value>: ViewModifier {

    let property: KeyPath<AnimatableValues, Value>
    let values: AnimatableValues

    func body(content: Content) -> some View {
        switch property {
        case \.offsetX:
            content.offset(x: values[keyPath: \.offsetX])
        case \.offsetY:
            content.offset(y: values[keyPath: \.offsetY])
        case \.scale:
            let scale = values[keyPath: \.scale]
            content.scaleEffect(x: scale.x, y: scale.y, anchor: scale.anchor)
        case \.opacity:
            content.opacity(values[keyPath: \.opacity])
        default:
            content
        }
    }
}
