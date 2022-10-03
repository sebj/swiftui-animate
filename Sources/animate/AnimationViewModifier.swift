import SwiftUI

public extension View {
    
    /// Adds a key frame animation to perform when this view appears.
    @ViewBuilder
    func animate(_ keyFrames: KeyFrame...) -> some View {
        if keyFrames.count >= 2 {
            AnimationViewModifier(keyFrames: keyFrames) { self }
        } else {
            self.onAppear {
                print("[Animate]: Animation will not be performed. At least 2 key frames are required.")
            }
        }
    }
}

private struct AnimationViewModifier<Content>: View where Content: View {
    
    let keyFrames: [KeyFrame]
    let content: Content
    
    init(keyFrames: [KeyFrame], @ViewBuilder content: () -> Content) {
        // I've lost track of why this is necessary, but when I last checked, it worked
        if keyFrames[0].time == 0 {
            self.keyFrames = keyFrames + [.at(0) { _ in }]
        } else {
            self.keyFrames = [.at(0) { _ in }] + keyFrames + [.at(0) { _ in }]
        }
        
        self.content = content()
    }
    
    var body: some View {
        TimelineView(.explicit(keyFrames.map { Date(timeIntervalSinceNow: $0.time) })) { timeline in
            AnimatorView(frames: keyFrames, date: timeline.date) {
                content
            }
        }
    }
}

// MARK: -

private struct AnimatorView<Content>: View where Content: View {
    
    let frames: [KeyFrame]
    let date: Date
    @ViewBuilder let content: () -> Content
    
    @State private var frameIndex = 0
    
    var body: some View {
        content()
            .modifier(
                FrameModifier(
                    previous: frameIndex == 0 ? nil : frames[frameIndex - 1],
                    current: frames[frameIndex]
                )
            )
            .animation(frames[frameIndex].animation, value: frameIndex)
            .onChange(of: date) { _ in
                frameIndex += 1
            }
    }
}

private struct FrameModifier: ViewModifier {
    
    let previous: KeyFrame?
    let current: KeyFrame
    
    func body(content: Content) -> some View {
        let scale = current.scale ?? previous?.scale ?? 1
        
        content
            .offset(
                x: current.offsetX ?? previous?.offsetX ?? 0,
                y: current.offsetY ?? previous?.offsetY ?? 0
            )
            .scaleEffect(x: scale.x, y: scale.y, anchor: scale.anchor)
            .rotationEffect(
                current.rotation?.angle ?? previous?.rotation?.angle ?? .degrees(0),
                anchor: current.rotation?.anchor ?? previous?.rotation?.anchor ?? .center
            )
            .opacity(current.opacity ?? previous?.opacity ?? 1)
    }
}
