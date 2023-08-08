# 🎞 Animate

### No longer necessary: see the [`keyframeAnimator`](https://developer.apple.com/documentation/swiftui/view/keyframeanimator(initialvalue:trigger:content:keyframes:)) view modifier (and its variants) introduced at WWDC 2023.

---

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsebj%2Fswiftui-animate%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sebj/swiftui-animate)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsebj%2Fswiftui-animate%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sebj/swiftui-animate)
[![MIT License](https://img.shields.io/github/license/sebj/steam?color=lightgray)](LICENSE)

A concept to more easily define simple keyframe / multi-step animations in SwiftUI, without:
* Defining an `@State` value for each property to be animated
* Using [`asyncAfter`](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300100-asyncafter)

The approach has gone through a few very different iterations (see commit history), but there's still room for improvement. [PRs](https://github.com/sebj/animate/pulls) and [discussion](https://github.com/sebj/animate/discussions) are welcome!

## Example Usage

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                // This animation will start as soon as the view appears.
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

## Minimum Requirements

* iOS 15 / macOS 12 / tvOS 15 / watchOS 8
* Swift 5.7 (Xcode 14)

## License

This library is released under the MIT license. See the [LICENSE](LICENSE) file for more information.

## To-Do
- [ ] Improve documentation
- [ ] Support for animation of arbitrary properties (via closure?)

## Notes

* Properties are animated in the order that their view modifiers are applied (see [`AnimationViewModifier.swift`](https://github.com/sebj/animate/blob/main/Sources/animate/AnimationViewModifier.swift#L89-L99))
