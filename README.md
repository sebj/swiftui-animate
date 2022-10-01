# Animate

A concept to more easily define keyframe / multi-step animations in SwiftUI, without:
* Defining an `@State` value for each property to be animated
* Resorting to [`asyncAfter`](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter)

### Example

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Animated {
                Image(systemName: "globe")
                
                Animate(\.opacity, from: 0, to: 1)
                Animate(\.scale, from: 1.0, to: 1.5)
                Animate(\.offsetY, from: 0, to: 50)

                Animate(\.scale, from: 1.5, to: 1).after(1.5)
            }
        }
    }
}
```

### To-Do:
- [ ] Provide a more ergonomic way to delay a group of animations (could require result builder changes)
    ```swift
    Animated {
        Image(systemName: "globe")
        
        After(0.5) {
            Animate(\.opacity, from: 0, to: 1)
        }
    }
    ```
- [ ] Write documentation
- [ ] Support animation of arbitrary properties (via closure?)