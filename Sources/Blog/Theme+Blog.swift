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
                .siteFooter()
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
                .siteFooter()
            )
        )
    }

    func makeItemHTML(for item: Item<Blog>, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .siteHead(for: item, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: item.path.string),
                .main(
                    .article(
                        .div(
                            .class("post-header"),
                            .h1(.text(item.title)),
                            .div(
                                .class("post-meta"),
                                .span(.text(DateFormatter.postDate.string(from: item.date))),
                                .if(!item.tags.isEmpty,
                                    .forEach(item.tags) { tag in
                                        .a(.href(context.site.prefixedPath(context.site.path(for: tag))), .class("tag"), .text(tag.string))
                                    }
                                )
                            )
                        ),
                        .div(.class("post-body"), .contentBody(item.body))
                    )
                ),
                .siteFooter()
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
                .siteFooter()
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
                .siteFooter()
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Blog>) throws -> HTML? {
        let items = context.items(taggedWith: page.tag, sortedBy: \.date, order: .descending)
        return HTML(
            .lang(context.site.language),
            .siteHead(for: page, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: page.path.string),
                .main(
                    .h1(.span(.class("tag"), .text(page.tag.string))),
                    .ul(
                        .class("item-list"),
                        .forEach(items) { item in
                            .li(.itemRow(for: item, on: context.site))
                        }
                    )
                ),
                .siteFooter()
            )
        )
    }
}

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
    static func siteHeader<T: Website>(for context: PublishingContext<T>, currentPath: String) -> Node {
        .header(
            .class("site-header"),
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
                        .href("https://github.com/DominatorVbN"),
                        .text("GitHub")
                    )
                )
            )
        )
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
                    .span(.text(DateFormatter.postDate.string(from: item.date))),
                    .forEach(item.tags) { tag in
                        .a(.href(site.prefixedPath(site.path(for: tag))), .class("tag"), .text(tag.string))
                    }
                ),
                .if(!item.description.isEmpty,
                    .p(.class("item-description"), .text(item.description))
                )
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
            .img(.class("app-icon"), .src(iconURL), .alt(title + " app icon")),
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
    static func siteHead<T: Website>(for location: Location, on site: T) -> Node {
        .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(location.title.isEmpty ? site.name : "\(location.title) · \(site.name)"),
            .description(location.description.isEmpty ? site.description : location.description),
            .twitterCardType(.summary),
            .viewport(.accordingToDevice),
            .link(.rel(.stylesheet), .href(site.prefixedPath("/styles.css")))
        )
    }
}

// MARK: - Helpers

private extension DateFormatter {
    static let postDate: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy"
        return f
    }()
}
