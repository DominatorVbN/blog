import Publish
import Plot

extension Theme where Site == Blog {
    static var blog: Self {
        Theme(
            htmlFactory: BlogHTMLFactory(),
            resourcePaths: ["Resources/styles.css"]
        )
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
                        .span(.class("badge"), .text("Senior iOS Engineer · Rakuten Viki")),
                        .h1(.text("Hey, I'm Amit Samant")),
                        .p(.class("tagline"), .text("I build iOS apps and Swift tools. WWDC20 Swift Student Challenge winner.")),
                        .p(.text("I've been writing Swift since 2018 — mostly iOS, some macOS, and wherever else Swift will run. I care about clean architecture, pixel-perfect UI, and developer tooling that actually saves time.")),
                        .p(.text("Currently a Senior iOS Engineer at Rakuten Viki in Singapore. Previously spread across Bengaluru, Hyderabad, Gurugram, and Indore.")),
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
                                .p(.a(.href("/posts"), .text("View all posts →")))
                            )
                        )
                    ),
                    .div(
                        .p(.class("section-title"), .text("Selected Projects")),
                        .div(
                            .class("projects-grid"),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/DeeplinkScout",
                                title: "DeeplinkScout",
                                description: "macOS utility for testing deeplinks across iOS simulators and real devices"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/ElegantAPI",
                                title: "ElegantAPI",
                                description: "URLSession wrapper with async/await and Combine support"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/TranslucentWindowStyle",
                                title: "TranslucentWindowStyle",
                                description: "SwiftUI package for blurred translucent macOS windows"
                            ),
                            .projectCard(
                                href: "https://github.com/DominatorVbN/Swift-Student-Challenge-Resources",
                                title: "WWDC Resources",
                                description: "Curated guide for Apple WWDC Swift Student Challenge applicants"
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
                                        .a(.href(context.site.path(for: tag)), .class("tag"), .text(tag.string))
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
                            .a(.href(context.site.path(for: tag)), .text(tag.string))
                        }
                    )
                ),
                .siteFooter()
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Blog>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .siteHead(for: page, on: context.site),
            .body(
                .siteHeader(for: context, currentPath: page.path.string),
                .main(
                    .h1(.span(.class("tag"), .text(page.tag.string))),
                    .ul(
                        .class("item-list"),
                        .forEach(page.items) { item in
                            .li(.itemRow(for: item, on: context.site))
                        }
                    )
                ),
                .siteFooter()
            )
        )
    }
}

// MARK: - Shared nodes

private extension Node where Context == HTML.BodyContext {
    static func siteHeader<T: Website>(for context: PublishingContext<T>, currentPath: String) -> Node {
        .header(
            .class("site-header"),
            .div(
                .class("inner"),
                .a(.href("/"), .class("site-name"), .text(context.site.name)),
                .nav(
                    .a(
                        .href("/posts"),
                        .class(currentPath.hasPrefix("/posts") ? "selected" : ""),
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
            .a(.href(item.path), .class("item-title"), .text(item.title)),
            .div(
                .class("item-meta"),
                .span(.text(DateFormatter.postDate.string(from: item.date))),
                .forEach(item.tags) { tag in
                    .a(.href(site.path(for: tag)), .class("tag"), .text(tag.string))
                }
            ),
            .if(!item.description.isEmpty,
                .p(.class("item-description"), .text(item.description))
            )
        )
    }

    static func projectCard(href: String, title: String, description: String) -> Node {
        .a(
            .href(href),
            .class("project-card"),
            .h3(.text(title)),
            .p(.text(description))
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
            .link(.rel(.stylesheet), .href("/styles.css"))
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
