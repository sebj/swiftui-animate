import SwiftUI

@resultBuilder
public enum AnimationBuilder {
    
    public struct Component<Content, Value>: View where Content: View, Value: Equatable {

        fileprivate let content: Content
        fileprivate var animation: PropertyAnimation<Value>

        public var body: some View {
            ModifiedContent(
                content: content,
                modifier: PropertyAnimationViewModifier(animation)
            )
        }
    }
    
    public static func buildPartialBlock(first: some View) -> Component<some View, some Equatable> {
        Component(content: first, animation: .identity)
    }
    
    public static func buildPartialBlock(
        first: PropertyAnimation<some Equatable>
    ) -> Component<EmptyView, some Equatable> {
        Component(content: EmptyView(), animation: first)
    }

    public static func buildPartialBlock(
        accumulated: some View,
        next: PropertyAnimation<some Equatable>
    ) -> Component<some View, some Equatable> {
        Component(content: accumulated, animation: next)
    }
    
    public static func buildFinalResult(_ component: Component<some View, some Equatable>) -> some View {
        component
    }
}
