# Animate

A concept to more easily define keyframe / multi-step animations in SwiftUI, without:
* Defining an `@State` value for each property to be animated
* Resorting to [`asyncAfter`](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter)

### Example

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .keyFrame {
                    // These properties will be animated when the `Image` appears.
                    $0.opacity(from: 0, to: 1)
                    $0.offsetY(from: 0, to: 50)
                    $0.scale(from: 1, to: 1.5)
                }
                .keyFrame(at: 2) {
                    // X-offset will be animated 2 seconds later.
                    $0.offsetX(from: 0, to: 50)
                }
        }
    }
}
```

### To-Do:
- [ ] Write documentation
- [ ] Support for animation of arbitrary properties (via closure?)
- [ ] Support for animation from 'last' value, without having to specify `from`