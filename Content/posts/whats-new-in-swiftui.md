---
date: 2026-06-11 12:00
description: A summary of everything new in SwiftUI at WWDC 2026 — refreshed look and feel, document-based app APIs, new interaction primitives, and data flow improvements.
tags: swiftui, wwdc, wwdc26
image: /posts/whats-new-in-swiftui/images/0D3AA5C9-FB6D-435E-B684-F159EAAB7015.png
---

# What's New in SwiftUI

- Refreshed look and feel
- Document based apps
- Presentation and interactions
- Data flow and Performance

## Refreshed Look and Feel

New `appearsActive` environment property to observe whether the window is active, letting you adapt UI when a window loses focus.

![Active appearance](images/7222D2BD-ECD8-4C9A-94C1-6F691D1779AE.png)

iPad and Mac menu bar's default behavior — showing icon with title — has changed to text-only. The existing modifier can override this.

![CommandMenu text-only default](images/782AACCF-D117-4933-8751-72A0D482A712.png)

Xcode SwiftUI previews now have resizability handles.

![Xcode preview resizability handles](images/29E46826-D475-474F-87D8-1CA4107DABDC.png)

These handles hint at foldable iPhone support and surface best practices around adaptive layouts.

![Resizability guidance](images/6C898649-95DB-449D-AD25-D2B1B3444378.png)

New tab role to make a trailing tab bar item stand out — similar to how the search tab already behaves in iOS 26.

![New tab role](images/19D6EFE0-BA80-4C97-B42E-F808E5B987E3.png)

When resizing an app, the OS now auto-hides tab bar items into an **Overflow Menu**. To control which items get hidden last, use the new `.visibilityPriority()` modifier on `ToolbarItemGroup`.

![visibilityPriority modifier](images/547CB4C7-6780-4727-8749-7431DF994225.png)

A new `ToolbarOverflowMenu` container lets you opt specific items *into* the overflow menu explicitly.

![ToolbarOverflowMenu](images/0D3AA5C9-FB6D-435E-B684-F159EAAB7015.png)

For items that should never be hidden regardless of window size, there is a new placement option in the `ToolbarItem` API: `topBarPinnedTrailing`.

![topBarPinnedTrailing placement](images/893491CD-07AE-40A0-95D2-72937C401E2A.png)

New `toolbarMinimizeBehavior` modifier to hide the toolbar on scroll.

![toolbarMinimizeBehavior](images/BE5E04F5-C54A-4AA8-A9AF-C2F9DE15A50C.png)

## Document Based Apps

Multiple new APIs for document-based apps.

![Document app new features overview](images/42398661-F30E-4072-8383-86779037E539.png)

New creation context API to start a document from different starting points.

![Creation context API](images/F6941CBC-5E94-4EA3-8C65-E46EC60F9E04.png)

`WritableDocument` with `DocumentWriter` and `ReadableDocument` with `DocumentReader` protocols provide sensible callbacks to optimize reading and writing based on snapshots — a type you control that represents the document state at a given point in time.

![WritableDocument and ReadableDocument protocols](images/D181E250-912F-4F79-9210-43802552FDBC.png)

## Presentation and Interactions

New `.reorderable` modifier and `.reorderContainer` modifier make it easy to support drag and drop in views beyond just lists.

![reorderable and reorderContainer modifiers](images/6A68DFA9-9706-46EA-8F16-C941D305D5AE.png)

More on these in the dedicated session: **[Code-along: Build powerful drag and drop in SwiftUI](https://developer.apple.com/videos/play/wwdc2026/271/)**

Swipe actions now work on any view container — not just `List` — by combining `.swipeActions` with a `.swipeActionContainer` modifier on the `ForEach` container.

![Swipe actions on any container](images/770882D2-5CD8-4FF1-A2E1-20EA4CF8D6E5.png)

New item-binding based API for confirmation dialogs and alerts: the dialog or alert is shown when the bound item is non-nil.

![Item-binding confirmation dialog API](images/D98813F2-6221-4B0C-A3C2-538D7E58F873.png)

![Item-binding alert API](images/C5474889-E7C4-4DCF-B2D6-0AF1C131C3D1.png)

## Data Flow and Performance

`AsyncImage` now supports HTTP caching via `URLCache` by default, respecting the caching policy set by your server. Pass a custom `URLRequest` to override the cache policy.

![AsyncImage with URLCache](images/416C5BE6-9CAA-4483-9301-B55381C83E0A.png)

You can also swap the underlying `URLSession` to control cache size.

![AsyncImage custom URLSession](images/D2D17DB3-DFF7-4208-A94C-470061448C1D.png)

`@State` has been refactored from a dynamic property into a macro. Previously, `@State`-stored `@Observable` objects were initialized multiple times when a parent view updated, even though the stored object stayed the same and the extra instances were immediately discarded. This is now fixed — and the fix is back-ported to iOS 17.

![Storing Observable in @State — before](images/40EE96ED-7569-41A0-BD62-9EDD425193EF.png)

![Storing Observable in @State — after](images/8CD09830-93E3-4EF3-B3FB-645AF05D86B0.png)

This change can be a **breaking change** when building with Xcode 27: if you have a `@State` property with a default value that you then override in `init`, the compiler will surface an error. The fix is to remove the default value.

![Breaking change example](images/3045F025-96B0-4E18-89CE-6181DF3D6A38.png)

Unified `resultBuilder` for SwiftUI: instead of per-type `@ViewBuilder`, you can now mark vars and functions with `@ContentBuilder`. This lets the compiler eliminate unnecessary code paths, reducing type-checking timeout errors.

![Unified @ContentBuilder](images/107F27F1-97C4-48DA-B474-6EE5D80FFE4F.png)

New agent skills for agentic coding workflows are also available via `xcrun`.

![Agentic coding support](images/86AFF107-CE25-475B-A783-AB2627791A21.png)

![xcrun agent skills export](images/F409E32E-1509-4DE6-A6E4-508A55EE2C45.png)
