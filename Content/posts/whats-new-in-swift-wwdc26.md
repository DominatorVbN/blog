---
title: What's New in Swift WWDC26
date: 2026-06-18 12:00
description: A summary of everything new in Swift at WWDC 2026 — everyday ergonomics, library updates, full-stack Swift, performance ergonomics, and open source development.
tags: swift, wwdc, wwdc26, WWDC26 Notes
image: /posts/whats-new-in-swift-wwdc26/images/85CEBBBC-4D9A-44A2-9BD4-7B6C46045EB8.png
---

- Everyday Ergonomics
- Libraries
- Full-stack Swift
- Performance Ergonomics
- Open source development

## Everyday Ergonomics

In Swift 5.6 you needed parentheses to make a protocol type optional with `any` or `some`. That limitation has now been lifted.

| Before | After |
| --- | --- |
| ![Optional any/some — before](../../Resources/posts/whats-new-in-swift-wwdc26/images/85CEBBBC-4D9A-44A2-9BD4-7B6C46045EB8.png) | ![Optional any/some — after](../../Resources/posts/whats-new-in-swift-wwdc26/images/B8A3239F-24A3-4193-8382-7005CEFFE794.png) |

There is a new warning when an error goes unhandled inside a `Task`.

![Unhandled error warning in Task](../../Resources/posts/whats-new-in-swift-wwdc26/images/88534D14-830E-4AFB-BBC4-91951DCCA53E.png)

The restriction on calling asynchronous functions inside `defer` blocks has been lifted.

| Before | After |
| --- | --- |
| ![Async in defer — before](../../Resources/posts/whats-new-in-swift-wwdc26/images/60743C44-5ED4-4F24-9FD2-A1E00C60472F.png) | ![Async in defer — after](../../Resources/posts/whats-new-in-swift-wwdc26/images/CE363029-1A0E-4B3D-A1AC-D9213C92B4A3.png) |

In your codebase you have probably seen the `weak var` pattern where `var` wasn't actually needed (a `let` would have done) but was used only so you could mark it `weak`. In Swift 6.2 Apple finally lets us write `weak let` — and doing so also allows the type to conform to `Sendable`. Two birds with one stone.

![weak let](../../Resources/posts/whats-new-in-swift-wwdc26/images/E3F242AC-BAFB-4D70-ADDB-980933833D40.png)

There is new syntax to opt *out* of a protocol or type — a way to say "not this type". The example below says "not Sendable".

![Opting out of a protocol](../../Resources/posts/whats-new-in-swift-wwdc26/images/0261D835-F32D-4B8D-8657-F003F43A2F91.png)

Marking a subclass as not conforming to a protocol does not stop its own child classes from conforming to that protocol.

![Child classes can still conform](../../Resources/posts/whats-new-in-swift-wwdc26/images/B2C8FA21-5FC2-4C82-BF3A-10BFDE721E67.png)

Previously, for types that had both internal and private properties, you had to write a private initializer and an internal initializer yourself. Now the Swift compiler generates both for you.

![Compiler-generated initializers](../../Resources/posts/whats-new-in-swift-wwdc26/images/BE496C4F-ECDD-4D9A-BD2D-A0A443F460B1.png)

There is a new availability marker, `anyAppleOS`, for specifying version availability across all Apple platforms at once in your availability checks.

| Before | After |
| --- | --- |
| ![anyAppleOS — before](../../Resources/posts/whats-new-in-swift-wwdc26/images/275A9CB4-E255-44F7-8C0E-84FEF85713FD.png) | ![anyAppleOS — after](../../Resources/posts/whats-new-in-swift-wwdc26/images/67E5009A-C5A7-4C44-A13A-9A66DBC611D3.png) |

On top of this default you can add exclusions by marking any of the platforms unavailable, or giving it a different version constraint.

![Adding platform exclusions](../../Resources/posts/whats-new-in-swift-wwdc26/images/BBD13B94-7D0F-4A03-A421-74033C847A36.png)

This also applies to `#`-guarded code, to exclude code from compiling entirely.

![Excluding code with #if](../../Resources/posts/whats-new-in-swift-wwdc26/images/F5D8BC0B-8003-4838-A7D2-F214BFE67BCE.png)

There is a new `@diagnostic` declaration attribute that lets you silence or adjust compiler warnings gradually. It is quite useful — you can read more about it in the proposal: [Source Warning Control](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0522-source-warning-control.md).

Silencing warnings

![Silencing warnings](../../Resources/posts/whats-new-in-swift-wwdc26/images/AFA61C40-8AA8-40BB-894F-3B4F0E8D5980.png)

Enabling a Swift concurrency feature for specific functions

![Enabling concurrency for a function](../../Resources/posts/whats-new-in-swift-wwdc26/images/E28B2896-CA31-4F52-A6E3-0623123D85FC.png)

![Enabling concurrency for a function](../../Resources/posts/whats-new-in-swift-wwdc26/images/5BF14125-C2AB-4D58-845E-5C4D4D41EDDC.png)

There is a new module operator, similar to C. Previously you wrote `Module.Type`; you can now write `Module::Type`. This is especially useful when there is a type with the same name as a module and the compiler can't tell where to resolve the type from — in general, the dot syntax could mean either a type nested in another type or a module member.

![Module operator](../../Resources/posts/whats-new-in-swift-wwdc26/images/DFF42429-1D6E-407C-8B69-90040BC4FFA4.png)

![Module operator](../../Resources/posts/whats-new-in-swift-wwdc26/images/861280CB-8BB4-45B1-BDFC-C1703E099BAC.png)

```swift
import Rocket
import GiftShopToys

let rocket2 = Rocket.SaturnV()   // ambiguous — prefers Rocket module's Rocket.SaturnV
let rocket3 = Rocket::SaturnV()  // unambiguous — definitely Rocket module's SaturnV
```

There is a new task-cancellation shield block, `withTaskCancellationShield`, to perform an operation you want to run even when the task is being cancelled — for example, closing a connection to a database.

![withTaskCancellationShield](../../Resources/posts/whats-new-in-swift-wwdc26/images/C2A78585-7770-4CF8-A862-EE31439C1580.png)

There is a new map-over-key-value function on dictionaries, to map over a dictionary and form a new one.

| Before | After |
| --- | --- |
| ![Mapping over a dictionary — before](../../Resources/posts/whats-new-in-swift-wwdc26/images/68E72E0A-3DCB-4418-8146-28C3E0428CB9.png) | ![Mapping over a dictionary — after](../../Resources/posts/whats-new-in-swift-wwdc26/images/28819304-B6D2-48A9-BC01-03FA20130A2B.png) |

There is also a unified file path that works across platforms.

![Unified cross-platform file path](../../Resources/posts/whats-new-in-swift-wwdc26/images/6A2A6B01-5879-4FE3-800A-1458D88F53C0.png)

### Improvements to Swift Testing

You can now define the severity of an issue, rather than treating everything as a failure — test issues can be marked as warnings too.

![Issue severity in Swift Testing](../../Resources/posts/whats-new-in-swift-wwdc26/images/C37FA002-28B4-4443-B6DE-3A056928CF5C.png)

You can also cancel a test midway, which is helpful for skipping a test for certain parameters.

![Cancelling a test midway](../../Resources/posts/whats-new-in-swift-wwdc26/images/7FFD02E8-12D4-402D-ADB9-193CC6E3F6E7.png)

There are new arguments on the `swift test` command to repeat a test.

![Repeating a test](../../Resources/posts/whats-new-in-swift-wwdc26/images/FF380988-49D6-4E21-BDBF-0A2E8B585C7F.png)

### XCTest and Swift Testing interoperability

XCTest assertions now surface as Swift Testing issues when run from `swift test`.

![XCTest assertions as Swift Testing issues](../../Resources/posts/whats-new-in-swift-wwdc26/images/2AABC9B7-B4DA-43FD-AF99-EDD673D9ABE1.png)

`#expect` now works inside XCTest class-based test functions.

![#expect in XCTest](../../Resources/posts/whats-new-in-swift-wwdc26/images/5672E996-93A2-46EA-A615-798EEC0CE700.png)

You need to opt in for these behaviors.

![Opting in](../../Resources/posts/whats-new-in-swift-wwdc26/images/72D2F021-BBD3-49CC-8B24-2982BDBD3EF8.png)

There is more on migrating from XCTest to Swift Testing in the session: **[Migrate to Swift Testing](https://developer.apple.com/videos/play/wwdc2026/267)**.

### Subprocess

The [Subprocess](https://github.com/swiftlang/swift-subprocess) Swift package, open sourced in 2025, has been bumped to version 1.9 with new features.

![Subprocess 1.9](../../Resources/posts/whats-new-in-swift-wwdc26/images/A32DE879-FF86-4399-9BA5-61DE217F952E.png)

It can stream process output using `AsyncStream`.

![Streaming process output with AsyncStream](../../Resources/posts/whats-new-in-swift-wwdc26/images/3474A84B-F575-4FAB-AD41-7F18CAA41209.png)

### Updates to the Foundation library

Foundation adds `ProgressManager`, a native solution for progress tracking and observation.

Reporting progress

![Reporting progress](../../Resources/posts/whats-new-in-swift-wwdc26/images/0CE736C4-BC00-425C-9253-03CCD80D9E08.png)

Observing progress

![Observing progress](../../Resources/posts/whats-new-in-swift-wwdc26/images/C824E425-65FA-40C3-A196-7970A1BC0F57.png)

It can also attach additional metadata (such as `deltaV`) to a Subprocess in a type-safe way.

![Attaching type-safe metadata](../../Resources/posts/whats-new-in-swift-wwdc26/images/F862088C-C356-4B24-B019-23C5F69CA477.png)

Foundation is faster now, thanks to optimizations to sequences, using `Span` in for loops, reduced bridging between `NSData` and `Data`, and `NSURL` and `CFURL` now sharing the same implementation.

## Full-stack Swift

You can now expose Swift functions to C and call them using `@c`, similar to `@objc`.

![@c interop](../../Resources/posts/whats-new-in-swift-wwdc26/images/A437457A-E6B9-46AA-AF43-99D9FFF28E76.png)

There is new Swift–Java interoperability using the [swift-java](https://github.com/swiftlang/swift-java) package.

![swift-java](../../Resources/posts/whats-new-in-swift-wwdc26/images/43721722-EBB9-4A73-BAE1-E86192E712BD.png)

A demo of calling Swift functions from Kotlin using swift-java:

![Calling Swift from Kotlin](../../Resources/posts/whats-new-in-swift-wwdc26/images/94AF1371-0A2E-49CA-8892-7D3B703D7D26.png)

There is also a new [Swift SDK for Android](https://www.swift.org/documentation/articles/swift-sdk-for-android-getting-started.html).

### Updates to the VS Code Swift extension

It now works with the `swiftly` CLI, letting you choose a toolchain right from VS Code.

![Choosing a toolchain with swiftly](../../Resources/posts/whats-new-in-swift-wwdc26/images/87F81BD6-44C4-4EC2-B5E4-849E4CD13E75.png)

It also supports previewing DocC documentation in VS Code.

![Previewing DocC in VS Code](../../Resources/posts/whats-new-in-swift-wwdc26/images/2765A4E6-F266-4E5F-A804-018AA0206776.png)

There is [WASM support in Swift](https://www.swift.org/documentation/articles/wasm-getting-started.html), along with updates to [JavaScript interoperability](https://github.com/swiftwasm/javascriptkit).

There was also a mention of Goodnotes, a Singapore startup that built their entire app — iOS, Android, web, and even the backend — in Swift. For the web UI they used WASM.

![Goodnotes built on Swift](../../Resources/posts/whats-new-in-swift-wwdc26/images/7E7C3230-9CD9-4F2C-9000-E323D420AC4C.png)

For updates to embedded Swift, watch from this timestamp: **[Embedded Swift](https://developer.apple.com/videos/play/wwdc2026/262?time=1107)**.

## Performance Ergonomics

You get more control over compiler inlining. (To learn more about inlining, read [Inlining and outlining in Swift](https://medium.com/ios-ic-weekly/inlining-and-outlining-in-swift-e0e128123ce9).)

![Control over inlining](../../Resources/posts/whats-new-in-swift-wwdc26/images/AE2CD7FC-B1B9-4AF9-BC3A-15AC51856BB1.png)

There is also explicit specialization. In simple terms, you ask the compiler to generate a typed version of your generic function. The compiler already does this a lot of the time when it has visibility into the codebase, but for libraries you may want to add `@specialized` to a generic function for the types you know it is most used with — this removes the overhead of the witness table. (To understand this better, read the proposal: [Specialized](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0460-specialized.md).)

![Explicit specialization](../../Resources/posts/whats-new-in-swift-wwdc26/images/5175DFDC-81D4-4274-9D7A-C47815D244F7.png)

There is a replacement for the `UnsafePointer` approach to sharing storage and avoiding unnecessary copies, with the introduction of `sending` and `borrowing`. (Read more in the proposal: [Parameter ownership modifiers](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0377-parameter-ownership-modifiers.md). I also liked [this article](https://sabatsachin.medium.com/understanding-copyable-borrowing-and-consuming-in-swift-2fba56a07313), which explains the concept with examples.)

![sending and borrowing](../../Resources/posts/whats-new-in-swift-wwdc26/images/B61C2A1F-D6A0-4C63-90BA-D3DD54DD4560.png)

One great point from the Swift team, worth re-iterating: Swift makes it **easy** to write good, performant code, and makes it **possible** to write the most performant code.

![Easy and possible](../../Resources/posts/whats-new-in-swift-wwdc26/images/D1FF297C-D6C7-479D-9690-CFBED6E08152.png)

The `Equatable`, `Comparable`, and `Hashable` protocols can now be used on noncopyable and nonescapable types.

![Protocols on noncopyable types](../../Resources/posts/whats-new-in-swift-wwdc26/images/EB0003B6-BD9A-4DF4-B9AB-CDA554DBAA78.png)

![Protocols on noncopyable types](../../Resources/posts/whats-new-in-swift-wwdc26/images/C19454CC-DB89-4493-8E62-1D763016BBBA.png)

Associated types can now be noncopyable or nonescapable too.

![Noncopyable associated types](../../Resources/posts/whats-new-in-swift-wwdc26/images/F87A8C2D-686C-4E2C-B70F-C720988E0A6B.png)

In Swift 6.4, the `for` loop uses the same `Iterable` protocol mentioned above in place of the previous `Sequence` protocol.

![for loop using Iterable](../../Resources/posts/whats-new-in-swift-wwdc26/images/79DE1C32-F7F7-45B3-ABDF-C27AD67F329E.png)

The new `Iterable` accesses elements in batches of a `Span` rather than one by one, which improves the `for` loop in Swift 6.4.

![Iterating in batches of Span](../../Resources/posts/whats-new-in-swift-wwdc26/images/9C88EAD7-1F0C-4AC3-9490-F831C10E33B0.png)

There is also a new set of safe replacements for unsafe APIs.

![Safe replacements for unsafe APIs](../../Resources/posts/whats-new-in-swift-wwdc26/images/0B93E5C8-E22C-4011-B7FB-19D1C333E6D5.png)

## Open source development

There is a new open source build system, [Swift Build](https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/swiftbuildpreview/), that will power both Xcode and SwiftPM.

![Swift Build](../../Resources/posts/whats-new-in-swift-wwdc26/images/B7C3C4FA-1C0C-47F4-92E3-A7F588A66EA9.png)

There are also new Swift workgroups for making open source contributions to the Swift language:

- [Build and Packaging Workgroup](https://www.swift.org/build-and-packaging-workgroup/)
- [Networking Workgroup](https://www.swift.org/blog/announcing-networking-workgroup/)
- [Windows Workgroup](https://www.swift.org/windows-workgroup/)
- [Android Workgroup](https://www.swift.org/android-workgroup/)
