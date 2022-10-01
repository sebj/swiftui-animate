import SwiftUI

public struct Animated<Content>: View where Content: View {
    
    private let content: Content
    
    public init(@AnimationBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View { content }
}
