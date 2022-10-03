import SwiftUI

public extension View {
    
    /// Adds a key frame animation to perform when this view appears.
    @ViewBuilder
    func animate(_ keyFrames: KeyFrame...) -> some View {
        if keyFrames.count >= 2 {
            AnimationView(keyFrames: keyFrames, content: self)
        } else {
            self.onAppear {
                runtimeWarning("Animation will not be performed. At least 2 key frames are required.")
            }
        }
    }
}

// MARK: -

/// A view that performs a key frame animation when its content appears.
private struct AnimationView<Content>: View where Content: View {
    
    private let keyFrames: [KeyFrame]
    private let timelineDates: [Date]
    private let content: Content
    
    init(keyFrames: [KeyFrame], content: Content) {
        let sortedKeyFrames = keyFrames.sorted(by: { $0.time < $1.time })
        let sortedKeyFrameTimes = sortedKeyFrames.map(\.time)
        if Array(Set(sortedKeyFrameTimes)) != sortedKeyFrameTimes {
            runtimeWarning("Multiple key frames occur at the same time. Behavior is undefined.")
        }
        
        // I've lost track of why this is necessary
        if keyFrames[0].time == 0 {
            self.keyFrames = sortedKeyFrames + [.empty]
        } else {
            self.keyFrames = [.empty] + sortedKeyFrames + [.empty]
        }
        
        self.timelineDates = self.keyFrames.map { Date(timeIntervalSinceNow: $0.time) }
        self.content = content
    }
    
    var body: some View {
        TimelineView(.explicit(timelineDates)) { timeline in
            AnimatorView(frames: keyFrames, date: timeline.date) {
                content
            }
        }
    }
}

// MARK: -

/// A view that animates between multiple key frames, whenever `date` changes.
private struct AnimatorView<Content>: View where Content: View {
    
    let frames: [KeyFrame]
    let date: Date
    @ViewBuilder let content: () -> Content
    
    @State private var currentFrameIndex = 0
    
    var body: some View {
        content()
            .modifier(
                FrameModifier(
                    previous: currentFrameIndex == 0 ? nil : frames[currentFrameIndex - 1],
                    current: frames[currentFrameIndex]
                )
            )
            .animation(frames[currentFrameIndex].animation, value: currentFrameIndex)
            .onChange(of: date) { _ in
                currentFrameIndex += 1
            }
    }
}

/// A view modifier that applies key frame values to a `View`.
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

private extension KeyFrame {
    static var empty: Self { .init(time: 0) }
}
