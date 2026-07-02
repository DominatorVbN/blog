import Foundation
import Publish
import Plot

extension Theme where Site == Blog {
    static var blog: Self {
        Theme(htmlFactory: BlogHTMLFactory())
    }
}

private struct BlogHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .siteHead(for: index, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: "/"),
                .main(
                    .div(
                        .class("intro"),
                        .span(.class("badge"), .text("Senior iOS Engineer")),
                        .h1(.text("Hey, I'm Amit Samant")),
                        .p(.class("tagline"), .text("I build iOS apps and Swift tools. WWDC20 Swift Student Challenge winner.")),
                        .p(.text("I've been writing Swift since 2018 — mostly iOS, some macOS, and wherever else Swift will run. I care about clean architecture, pixel-perfect UI, and developer tooling that actually saves time.")),
                        .div(
                            .class("links-row"),
                            .a(.href("https://github.com/DominatorVbN"), .class("link-pill"), .text("GitHub")),
                            .a(.href("https://twitter.com/amitsamant_dev"), .class("link-pill"), .text("Twitter / X")),
                            .a(.href("https://linkedin.com/in/amitsamant-dev"), .class("link-pill"), .text("LinkedIn"))
                        )
                    ),
                    .readingSections(),
                    .if(!context.sections[.posts].items.isEmpty,
                        .div(
                            .p(.class("section-title"), .text("Recent Posts")),
                            .ul(
                                .class("item-list"),
                                .forEach(context.sections[.posts].items.prefix(5)) { item in
                                    .li(.itemRow(for: item, on: context.site))
                                }
                            ),
                            .if(context.sections[.posts].items.count > 5,
                                .p(.a(.href(context.site.prefixedPath("/posts")), .text("View all posts →")))
                            )
                        )
                    ),
                    .div(
                        .p(.class("section-title"), .text("Top Repositories")),
                        .div(
                            .class("projects-grid"),
                            .projectCard(
                                href: "https://github.com/gojek/StorageToolKit-iOS",
                                title: "StorageToolKit",
                                description: "StorageCleaner, StorageAnalyser, and friends — disk-usage tooling for iOS, open sourced at Gojek"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/TranslucentWindowStyle",
                                title: "TranslucentWindowStyle",
                                description: "SwiftUI package for blurred translucent macOS windows"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/ElegantAPI",
                                title: "ElegantAPI",
                                description: "API management for URLSession, inspired by Moya"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/DiskSpaceProvider",
                                title: "DiskSpaceProvider",
                                description: "Micro-library with simple APIs to check disk storage capacity"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/SlideUpPanel",
                                title: "SlideUpPanel",
                                description: "Google Maps–style slide-up panel control for UIKit"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/Swift-Student-Challenge-Resources",
                                title: "WWDC Resources",
                                description: "Curated guide for Apple WWDC Swift Student Challenge applicants"
                            )
                        )
                    ),
                    .div(
                        .p(.class("section-title"), .text("Live Apps")),
                        .div(
                            .class("projects-grid"),
                            .appCard(
                                href: "https://dominatorvbn.github.io/DeeplinkScoutDocs/",
                                title: "DeeplinkScout",
                                description: "Test, organize, and launch deeplinks across iOS simulators and devices from your Mac.",
                                iconURL: "https://dominatorvbn.github.io/DeeplinkScoutDocs/assets/app-icon.png",
                                linkLabel: "Visit website"
                            ),
                            .appCard(
                                href: "https://apps.apple.com/us/app/notifyhub-push-notification/id6472355827",
                                title: "NotifyHub",
                                description: "Server-less push notification testing on iPhone, iPad, Mac, and Apple Vision Pro.",
                                iconURL: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/e0/a2/31/e0a231a7-8b91-25d9-921c-bbe1b0da438b/AppIcon-0-0-1x_U007epad-0-85-220.png/512x512bb.jpg",
                                linkLabel: "View on the App Store"
                            )
                        )
                    ),
                    .div(
                        .p(.class("section-title"), .text("Community Outreach")),
                        .div(
                            .class("community-grid"),
                            .communityCard(
                                title: "Swift Bengaluru",
                                detail: "Organized monthly iOS meetups in Bengaluru, and guided and mentored sister communities in Hyderabad, Surat, Pune, Kozhikode, and Mumbai to organize in their own cities.",
                                photo: context.site.prefixedPath("/images/community/swift-bengaluru.jpg")
                            ),
                            .communityCard(
                                title: "WWDC Watch Party",
                                detail: "Hosted WWDC-week watch parties joined by 100+ engineers in Bengaluru.",
                                photo: context.site.prefixedPath("/images/community/wwdc-watch-party.jpg")
                            ),
                            .communityCard(
                                title: "Swift Bharat",
                                detail: "Helped build and connect Swift and iOS communities across India.",
                                photo: context.site.prefixedPath("/images/community/swift-bharat.jpg")
                            ),
                            .communityCard(
                                title: "Speaking",
                                detail: "Talks at Swift India, Swift Anytime, and community meetups.",
                                photo: context.site.prefixedPath("/images/community/speaking.jpg")
                            )
                        )
                    ),
                    .div(
                        .p(.class("section-title"), .text("Career")),
                        .div(
                            .class("timeline"),
                            .timelineEntry(
                                period: "Oct 2024 — Present",
                                title: "Senior Software Engineer (iOS) · Rakuten Viki",
                                detail: "Building the Viki streaming app for iOS and tvOS in Singapore — release management, Xcode 16 CI upgrades for iOS 18/tvOS 18, and raising test coverage from 24% to 32%."
                            ),
                            .timelineEntry(
                                period: "Dec 2021 — Oct 2024",
                                title: "Senior Software Engineer (iOS) · Gojek, DevX Platform",
                                detail: "Platform engineering for the Gojek super-app — built AppAuditSDK tracking page performance across 100% of screens, cut app size and disk usage, and shipped app-health dashboards."
                            ),
                            .timelineEntry(
                                period: "Jun — Dec 2021",
                                title: "Product Engineer (iOS) · Zomato",
                                detail: "Built the Pro Plus membership experience with an 82.7% subscription rate among invited members, and cut build times 90% by moving to precompiled XCFrameworks."
                            ),
                            .timelineEntry(
                                period: "Aug 2020 — May 2021",
                                title: "Product Engineer (iOS) · Loyalty Juggernaut",
                                detail: "Built the MUSE app from scratch and the GravtySDK that powers 10+ loyalty apps, distributed via CocoaPods, Carthage, and SPM."
                            ),
                            .timelineEntry(
                                period: "2020",
                                title: "WWDC20 Swift Student Challenge Winner",
                                detail: "Recognized by Apple in my final year of college, top among 350+ submissions worldwide."
                            ),
                            .timelineEntry(
                                period: "2018 — 2020",
                                title: "Internships & first apps",
                                detail: "Shipped my first iOS apps at SBNRI, EngineerBabu, MMF Infotech, and Natraj Infotech while studying Computer Science in Indore."
                            )
                        )
                    )
                ),
                .siteFooter(),
                .liquidGlassScripts(on: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Blog>, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .siteHead(for: section, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: section.path.string),
                .main(
                    .h1(.text(section.title.isEmpty ? "Posts" : section.title)),
                    .if(section.items.isEmpty,
                        .p(.class("text-muted"), .text("No posts yet — check back soon."))
                    ),
                    .ul(
                        .class("item-list"),
                        .forEach(section.items) { item in
                            .li(.itemRow(for: item, on: context.site))
                        }
                    )
                ),
                .siteFooter(),
                .liquidGlassScripts(on: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Blog>, context: PublishingContext<Blog>) throws -> HTML {
        // Inject anchor ids into the rendered headings and collect a table of
        // contents from them, so the floating index can link into the page.
        let toc = TableOfContents(html: item.body.html)
        return HTML(
            .lang(context.site.language),
            .siteHead(for: item, on: context.site, item: item),
            .body(
                .siteHeader(for: context, currentPath: item.path.string),
                .tableOfContents(toc.entries),
                .main(
                    .article(
                        .div(
                            .class("post-header"),
                            .h1(.text(item.title)),
                            .div(
                                .class("post-meta"),
                                .element(named: "time", nodes: [
                                    .attribute(named: "datetime", value: ISO8601DateFormatter.shared.string(from: item.date)),
                                    .text(DateFormatter.postDate.string(from: item.date))
                                ]),
                                .if(!item.tags.isEmpty,
                                    .forEach(item.tags) { tag in
                                        .a(.href(context.site.prefixedPath(context.site.path(for: tag))), .class("tag"), .text(tag.string))
                                    }
                                )
                            ),
                            .bookmarkButton(for: item, on: context.site, labeled: true)
                        ),
                        .div(.class("post-body"), .raw(toc.anchoredHTML))
                    )
                ),
                .siteFooter(),
                .tableOfContentsScript(toc.entries),
                .liquidGlassScripts(on: context.site)
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .siteHead(for: page, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: page.path.string),
                .main(
                    .div(.class("post-body"), .contentBody(page.body))
                ),
                .siteFooter(),
                .liquidGlassScripts(on: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Blog>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .siteHead(for: page, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: page.path.string),
                .main(
                    .h1(.text("Tags")),
                    .div(
                        .class("tag-list"),
                        .forEach(page.tags.sorted()) { tag in
                            .a(.href(context.site.prefixedPath(context.site.path(for: tag))), .text(tag.string))
                        }
                    )
                ),
                .siteFooter(),
                .liquidGlassScripts(on: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Blog>) throws -> HTML? {
        let items = context.items(taggedWith: page.tag, sortedBy: \.date, order: .descending)
        let description = tagDescriptions[page.tag.string]
        return HTML(
            .lang(context.site.language),
            .siteHead(for: page, on: context.site, descriptionOverride: description),
            .body(
                .siteHeader(for: context, currentPath: page.path.string),
                .main(
                    .h1(.span(.class("tag"), .text(page.tag.string))),
                    .unwrap(description) { description in
                        .p(.class("tag-description"), .text(description))
                    },
                    .ul(
                        .class("item-list"),
                        .forEach(items) { item in
                            .li(.itemRow(for: item, on: context.site))
                        }
                    )
                ),
                .siteFooter(),
                .liquidGlassScripts(on: context.site)
            )
        )
    }
}

// MARK: - Tag descriptions

// One-liner intros shown on a tag's detail page (and used as its meta
// description). Keyed by the exact tag string. Tags without an entry simply
// render without a description.
private let tagDescriptions: [String: String] = [
    "WWDC26 Notes": "Notes I prepared for myself while watching the WWDC26 videos.",
]

// MARK: - Path handling

// The site is hosted as a GitHub Pages project site under the "/blog"
// subpath, so root-relative links like "/styles.css" would resolve outside
// the site. Prefix every internal link with the path component of site.url.
private extension Website {
    var pathPrefix: String {
        var prefix = url.path
        while prefix.hasSuffix("/") { prefix.removeLast() }
        return prefix
    }

    func prefixedPath(_ path: Path) -> String {
        pathPrefix + path.absoluteString
        
    }

    func prefixedPath(_ path: String) -> String {
        prefixedPath(Path(path))
    }
}

// MARK: - Shared nodes


private extension Node where Context == HTML.BodyContext {
    // The header is a liquidGL lens: the WebGL canvas refracts the page
    // beneath it. liquidGL clears the lens element's own background, so the
    // readable tint lives on the .glass-nav-content wrapper above the canvas.
    static func siteHeader<T: Website>(for context: PublishingContext<T>, currentPath: String) -> Node {
        .header(
            .class("site-header liquid-glass"),
            .div(
                .class("glass-nav-content"),
                .div(
                    .class("inner"),
                    .a(.href(context.site.prefixedPath("/")), .class("site-name"), .text(context.site.name)),
                    .nav(
                        .a(
                            .href(context.site.prefixedPath("/posts")),
                            .class(currentPath.drop(while: { $0 == "/" }).hasPrefix("posts") ? "selected" : ""),
                            .text("Posts")
                        ),
                        .a(
                            .href(context.site.prefixedPath("/feed.rss")),
                            .text("RSS")
                        )
                    )
                )
            )
        )
    }

    // Vendored liquid-glass scripts, loaded at the end of <body> in this
    // exact order (html2canvas → liquidGL → init).
    static func liquidGlassScripts<T: Website>(on site: T) -> Node {
        .group(
            .script(.attribute(named: "src", value: site.prefixedPath("/js/html2canvas.min.js"))),
            .script(.attribute(named: "src", value: site.prefixedPath("/js/liquidGL.js"))),
            .script(.attribute(named: "src", value: site.prefixedPath("/js/liquid-glass-init.js")))
        )
    }

    // Floating "Contents" index pinned to the top-right of the page. Rendered
    // expanded so it works (and stays open) without any JavaScript; the script
    // adds the spring morph, the scroll-driven collapse, and the toggle. Renders
    // nothing unless there are at least two headings.
    static func tableOfContents(_ entries: [TableOfContents.Entry]) -> Node {
        guard entries.count >= 2 else { return .empty }
        return .div(
            .class("toc"),
            .button(
                .type(.button),
                .class("toc-toggle"),
                .attribute(named: "aria-expanded", value: "true"),
                .attribute(named: "aria-controls", value: "toc-nav"),
                .span(.class("toc-icon")),
                .span(.class("toc-label"), .text("Contents")),
                .span(.class("toc-chevron"))
            ),
            .div(
                .class("toc-body"),
                .nav(
                    .class("toc-nav"),
                    .id("toc-nav"),
                    .ul(
                        .forEach(entries) { entry in
                            .li(
                                .class("toc-level-\(entry.level)"),
                                .a(.href("#\(entry.id)"), .raw(entry.title))
                            )
                        }
                    )
                )
            )
        )
    }

    // Drives the floating index: a scroll-spy that highlights the section in
    // view, plus a spring-morph that keeps the index expanded at the top of the
    // page and collapses it to a pill once the reader scrolls (re-expanding at
    // the top, until they toggle it by hand). Pure DOM, no dependencies; renders
    // nothing unless there are at least two headings to track.
    static func tableOfContentsScript(_ entries: [TableOfContents.Entry]) -> Node {
        guard entries.count >= 2 else { return .empty }
        return .script(.raw(#"""
        (function () {
          var toc = document.querySelector('.toc');
          var toggle = toc && toc.querySelector('.toc-toggle');
          if (toc && toggle) {
            var userToggled = false;
            var threshold = 24;
            function setCollapsed(collapsed) {
              if (toc.classList.contains('collapsed') === collapsed) return;
              toc.classList.toggle('collapsed', collapsed);
              toggle.setAttribute('aria-expanded', String(!collapsed));
            }
            toggle.addEventListener('click', function () {
              userToggled = true;
              setCollapsed(!toc.classList.contains('collapsed'));
            });

            // A jump triggered from the index itself shouldn't auto-collapse it.
            // Hold the expanded state until that programmatic scroll settles;
            // manual scrolling afterwards collapses as usual.
            var programmatic = false;
            var settleTimer;
            function holdExpanded() {
              setCollapsed(false);
              programmatic = true;
              clearTimeout(settleTimer);
              settleTimer = window.setTimeout(function () { programmatic = false; }, 700);
            }
            Array.prototype.slice.call(toc.querySelectorAll('.toc-nav a'))
              .forEach(function (a) { a.addEventListener('click', holdExpanded); });
            window.addEventListener('scrollend', function () { programmatic = false; });

            var ticking = false;
            function onScroll() {
              if (userToggled || programmatic || ticking) return;
              ticking = true;
              window.requestAnimationFrame(function () {
                setCollapsed(window.pageYOffset > threshold);
                ticking = false;
              });
            }
            window.addEventListener('scroll', onScroll, { passive: true });
            onScroll();
          }

          var links = Array.prototype.slice.call(document.querySelectorAll('.toc-nav a'));
          if (!links.length) return;
          var map = {};
          links.forEach(function (a) {
            map[decodeURIComponent(a.getAttribute('href').slice(1))] = a;
          });
          var headings = links
            .map(function (a) { return document.getElementById(decodeURIComponent(a.getAttribute('href').slice(1))); })
            .filter(Boolean);
          if (!headings.length) return;

          var active = null;
          function setActive(a) {
            if (active === a) return;
            if (active) active.classList.remove('active');
            active = a;
            if (active) active.classList.add('active');
          }

          var visible = {};
          var observer = new IntersectionObserver(function (records) {
            records.forEach(function (r) {
              if (r.isIntersecting) visible[r.target.id] = true;
              else delete visible[r.target.id];
            });
            // Prefer the first in-view heading (document order)…
            for (var i = 0; i < headings.length; i++) {
              if (visible[headings[i].id]) { setActive(map[headings[i].id]); return; }
            }
            // …otherwise fall back to the last heading scrolled past.
            var above = null;
            headings.forEach(function (h) {
              if (h.getBoundingClientRect().top < 80) above = h;
            });
            if (above) setActive(map[above.id]);
          }, { rootMargin: '-72px 0px -55% 0px', threshold: 0 });

          headings.forEach(function (h) { observer.observe(h); });
        })();
        """#))
    }

    static func siteFooter() -> Node {
        .footer(
            .class("site-footer"),
            .text("Built with "),
            .a(.href("https://github.com/johnsundell/publish"), .text("Publish")),
            .text(" · "),
            .a(.href("https://github.com/DominatorVbN/blog"), .text("Source on GitHub"))
        )
    }

    static func itemRow(for item: Item<Blog>, on site: Blog) -> Node {
        .group(
            .unwrap(item.imagePath) { imagePath in
                .a(
                    .href(site.prefixedPath(item.path)),
                    .class("item-thumb-link"),
                    .img(.class("item-thumb"), .src(site.prefixedPath(imagePath)), .alt(item.title))
                )
            },
            .div(
                .class("item-body"),
                .a(.href(site.prefixedPath(item.path)), .class("item-title"), .text(item.title)),
                .div(
                    .class("item-meta"),
                    .element(named: "time", nodes: [
                        .attribute(named: "datetime", value: ISO8601DateFormatter.shared.string(from: item.date)),
                        .text(DateFormatter.postDate.string(from: item.date))
                    ]),
                    .forEach(item.tags) { tag in
                        .a(.href(site.prefixedPath(site.path(for: tag))), .class("tag"), .text(tag.string))
                    }
                ),
                .if(!item.description.isEmpty,
                    .p(.class("item-description"), .text(item.description))
                )
            ),
            .div(.class("item-actions"), .bookmarkButton(for: item, on: site))
        )
    }

    // A "Read Later" toggle. The button only carries the article's metadata in
    // data-* attributes; reading.js reads it, toggles localStorage, and reflects
    // the saved state. The `labeled` variant adds visible text for the article
    // header; list cards use the icon-only form.
    static func bookmarkButton(for item: Item<Blog>, on site: Blog, labeled: Bool = false) -> Node {
        .button(
            .type(.button),
            .class(labeled ? "bookmark-btn bookmark-btn-labeled" : "bookmark-btn"),
            .attribute(named: "aria-pressed", value: "false"),
            .attribute(named: "aria-label", value: "Save for later"),
            .attribute(named: "title", value: "Read later"),
            .attribute(named: "data-url", value: site.prefixedPath(item.path)),
            .attribute(named: "data-title", value: item.title),
            .attribute(named: "data-date", value: DateFormatter.postDate.string(from: item.date)),
            .attribute(named: "data-description", value: item.description),
            .span(.class("bookmark-icon")),
            .if(labeled, .span(.class("bookmark-label"), .text("Read later")))
        )
    }

    // Empty placeholders for the home page's "Continue Reading" and "Read Later"
    // lists. They stay hidden until reading.js finds matching localStorage
    // entries and fills them in (and re-hides them when emptied).
    static func readingSections() -> Node {
        .group(
            .div(
                .class("reading-section"),
                .id("continue-reading-section"),
                .attribute(named: "hidden", value: "hidden"),
                .p(.class("section-title"), .text("Continue Reading")),
                .ul(.class("item-list"), .id("continue-reading-list"))
            ),
            .div(
                .class("reading-section"),
                .id("read-later-section"),
                .attribute(named: "hidden", value: "hidden"),
                .p(.class("section-title"), .text("Read Later")),
                .ul(.class("item-list"), .id("read-later-list"))
            )
        )
    }

    static func timelineEntry(period: String, title: String, detail: String) -> Node {
        .div(
            .class("timeline-entry"),
            .p(.class("timeline-period"), .text(period)),
            .h3(.class("timeline-title"), .text(title)),
            .p(.class("timeline-detail"), .text(detail))
        )
    }

    static func projectCard(href: String, title: String, description: String) -> Node {
        .a(
            .href(href),
            .class("project-card repo-card"),
            .h3(.text(title)),
            .p(.text(description))
        )
    }

    static func appCard(href: String, title: String, description: String, iconURL: String, linkLabel: String) -> Node {
        .a(
            .href(href),
            .class("project-card app-card"),
            // Cross-origin icons stall html2canvas's snapshot (CORS re-fetch
            // until its image timeout); keep them out of the glass refraction.
            .img(.class("app-icon"), .src(iconURL), .alt(title + " app icon"), .attribute(named: "data-liquid-ignore", value: "")),
            .h3(.text(title)),
            .p(.text(description)),
            .span(.class("card-link-label"), .text(linkLabel))
        )
    }

    static func communityCard(title: String, detail: String, photo: String? = nil) -> Node {
        .div(
            .class("community-card"),
            .unwrap(photo) { url in
                .img(.class("community-photo"), .src(url), .alt(title))
            },
            .div(
                .class("community-card-body"),
                .h3(.text(title)),
                .p(.text(detail))
            )
        )
    }
}

// MARK: - <head>

private extension Node where Context == HTML.DocumentContext {
    static func siteHead(for location: Location, on site: Blog, item: Item<Blog>? = nil, descriptionOverride: String? = nil) -> Node {
        let pageURL = site.url(for: location)
        let title: String
        if location is Index {
            title = "\(site.name) — Swift & iOS Engineering"
        } else if location.title.isEmpty {
            title = site.name
        } else {
            title = "\(location.title) · \(site.name)"
        }
        let description = descriptionOverride ?? (location.description.isEmpty ? site.description : location.description)
        let imagePath = item?.imagePath ?? Path("/images/og-default.png")
        let imageURL = site.url(for: imagePath).absoluteString

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(pageURL),
            .title(title),
            .description(description),
            .twitterCardType(.summaryLargeImage),
            .meta(
                .attribute(named: "name", value: "viewport"),
                .attribute(named: "content", value: "width=device-width, initial-scale=1, viewport-fit=cover")
            ),
            // Safari tints the status bar / browser chrome area with theme-color;
            // CSS cannot reach that region in a regular browser tab.
            .meta(
                .attribute(named: "name", value: "theme-color"),
                .attribute(named: "content", value: "#fbfbfd"),
                .attribute(named: "media", value: "(prefers-color-scheme: light)")
            ),
            .meta(
                .attribute(named: "name", value: "theme-color"),
                .attribute(named: "content", value: "#161617"),
                .attribute(named: "media", value: "(prefers-color-scheme: dark)")
            ),
            .meta(
                .attribute(named: "name", value: "author"),
                .attribute(named: "content", value: "Amit Samant")
            ),
            .meta(
                .attribute(named: "property", value: "og:type"),
                .attribute(named: "content", value: item == nil ? "website" : "article")
            ),
            .meta(
                .attribute(named: "property", value: "og:locale"),
                .attribute(named: "content", value: "en_US")
            ),
            .meta(
                .attribute(named: "name", value: "twitter:site"),
                .attribute(named: "content", value: "@amitsamant_dev")
            ),
            .meta(
                .attribute(named: "name", value: "twitter:creator"),
                .attribute(named: "content", value: "@amitsamant_dev")
            ),
            .meta(
                .attribute(named: "property", value: "og:image"),
                .attribute(named: "content", value: imageURL)
            ),
            .meta(
                .attribute(named: "name", value: "twitter:image"),
                .attribute(named: "content", value: imageURL)
            ),
            .unwrap(item) { item in
                .group(
                    .meta(
                        .attribute(named: "property", value: "article:published_time"),
                        .attribute(named: "content", value: ISO8601DateFormatter.shared.string(from: item.date))
                    ),
                    .meta(
                        .attribute(named: "property", value: "article:modified_time"),
                        .attribute(named: "content", value: ISO8601DateFormatter.shared.string(from: item.lastModified))
                    ),
                    .forEach(item.tags) { tag in
                        .meta(
                            .attribute(named: "property", value: "article:tag"),
                            .attribute(named: "content", value: tag.string)
                        )
                    }
                )
            },
            .link(
                .attribute(named: "rel", value: "alternate"),
                .attribute(named: "type", value: "application/rss+xml"),
                .attribute(named: "title", value: site.name),
                .attribute(named: "href", value: site.prefixedPath("/feed.rss"))
            ),
            .link(
                .attribute(named: "rel", value: "icon"),
                .attribute(named: "type", value: "image/svg+xml"),
                .attribute(named: "href", value: site.prefixedPath("/favicon.svg"))
            ),
            .link(
                .attribute(named: "rel", value: "icon"),
                .attribute(named: "type", value: "image/png"),
                .attribute(named: "sizes", value: "32x32"),
                .attribute(named: "href", value: site.prefixedPath("/favicon-32.png"))
            ),
            .link(
                .attribute(named: "rel", value: "apple-touch-icon"),
                .attribute(named: "href", value: site.prefixedPath("/apple-touch-icon.png"))
            ),
            .link(.rel(.stylesheet), .href(site.prefixedPath("/styles.css"))),
            .script(
                .attribute(named: "src", value: site.prefixedPath("/reading.js")),
                .attribute(named: "defer", value: "")
            ),
            .script(
                .attribute(named: "type", value: "application/ld+json"),
                .raw(structuredData(for: location, on: site, item: item))
            )
        )
    }
}

// MARK: - Structured data (schema.org JSON-LD)

private let personSchema: [String: Any] = [
    "@type": "Person",
    "name": "Amit Samant",
    "jobTitle": "Senior iOS Engineer",
    "url": "https://amitsamant.dev",
    "sameAs": [
        "https://github.com/DominatorVbN",
        "https://twitter.com/amitsamant_dev",
        "https://linkedin.com/in/amitsamant-dev",
    ],
]

private func structuredData(for location: Location, on site: Blog, item: Item<Blog>?) -> String {
    var object: [String: Any]
    if let item = item {
        let url = site.url(for: item).absoluteString
        object = [
            "@context": "https://schema.org",
            "@type": "BlogPosting",
            "headline": item.title,
            "description": item.description,
            "url": url,
            "mainEntityOfPage": url,
            "datePublished": ISO8601DateFormatter.shared.string(from: item.date),
            "dateModified": ISO8601DateFormatter.shared.string(from: item.lastModified),
            "keywords": item.tags.map { $0.string }.joined(separator: ", "),
            "author": personSchema,
            "publisher": personSchema,
        ]
        if let imagePath = item.imagePath {
            object["image"] = site.url(for: imagePath).absoluteString
        }
    } else {
        object = [
            "@context": "https://schema.org",
            "@type": "Blog",
            "name": site.name,
            "url": site.url.absoluteString,
            "description": site.description,
            "author": personSchema,
        ]
    }
    let data = (try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys])) ?? Data()
    return String(data: data, encoding: .utf8) ?? "{}"
}

// MARK: - Table of contents

// Parses the rendered post HTML, injects slug `id`s into its headings, and
// collects an ordered list of entries the floating index links to. Both the
// rewritten HTML and the entries are derived in a single pass.
struct TableOfContents {
    struct Entry {
        let level: Int
        /// Inner heading HTML (tags stripped, entities preserved) for display.
        let title: String
        let id: String
    }

    let anchoredHTML: String
    let entries: [Entry]

    init(html: String) {
        guard let regex = try? NSRegularExpression(
            pattern: "<h([1-4])>([\\s\\S]*?)</h\\1>"
        ) else {
            self.anchoredHTML = html
            self.entries = []
            return
        }

        let source = html as NSString
        let matches = regex.matches(in: html, range: NSRange(location: 0, length: source.length))
        let result = NSMutableString(string: html)
        var entries: [Entry] = []
        var usedIDs: Set<String> = []

        // Walk matches in reverse so earlier ranges stay valid as we splice.
        for match in matches.reversed() {
            let level = Int(source.substring(with: match.range(at: 1))) ?? 2
            let inner = source.substring(with: match.range(at: 2))
            let title = TableOfContents.stripTags(inner)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            guard !title.isEmpty else { continue }

            let slug = TableOfContents.slugify(title)
            var unique = slug.isEmpty ? "section" : slug
            var suffix = 2
            while usedIDs.contains(unique) {
                unique = "\(slug.isEmpty ? "section" : slug)-\(suffix)"
                suffix += 1
            }
            usedIDs.insert(unique)
            entries.insert(Entry(level: level, title: title, id: unique), at: 0)

            // The opening tag is always four characters, e.g. "<h2>".
            result.replaceCharacters(
                in: NSRange(location: match.range.location, length: 4),
                with: "<h\(level) id=\"\(unique)\">"
            )
        }

        self.anchoredHTML = result as String
        self.entries = entries
    }

    private static func stripTags(_ html: String) -> String {
        html.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }

    private static func slugify(_ text: String) -> String {
        // Drop HTML entities, then keep alphanumerics and collapse the rest to
        // single hyphens.
        let withoutEntities = text.replacingOccurrences(
            of: "&[^;]+;",
            with: "",
            options: .regularExpression
        )
        var slug = ""
        var lastWasHyphen = false
        for scalar in withoutEntities.lowercased().unicodeScalars {
            if CharacterSet.alphanumerics.contains(scalar) {
                slug.unicodeScalars.append(scalar)
                lastWasHyphen = false
            } else if !lastWasHyphen {
                slug.append("-")
                lastWasHyphen = true
            }
        }
        return slug.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }
}

// MARK: - Helpers

private extension ISO8601DateFormatter {
    static let shared = ISO8601DateFormatter()
}

private extension DateFormatter {
    static let postDate: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy"
        return f
    }()
}
