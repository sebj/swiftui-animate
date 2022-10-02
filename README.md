# Animate

A concept to more easily define keyframe / multi-step animations in SwiftUI, without:
* Defining an `@State` value for each property to be animated
* Resorting to [`asyncAfter`](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter)

The approach has been iterated on, with each iteration in a separate commit.

### Example

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .animate(
                    .start {
                        $0.opacity = 0.5
                    },
                    .at(2) {
                        $0.opacity = 1
                        $0.offsetY = 50
                        $0.scale = 1.5
                    }
                )
        }
    }
}
```

### To-Do:
- [ ] Write documentation
- [ ] Support for animation of arbitrary properties (via closure?)