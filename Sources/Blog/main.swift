import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    var url = URL(string: "https://amitsamant.dev/blog")!
    var name = "Amit Samant"
    var description = "Senior iOS Engineer. Writing about Swift, iOS, and software engineering."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Blog().publish(using: [
    .installPlugin(.resourceImagePaths),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap(),
    .step(named: "Generate llms.txt") { context in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let posts = context.sections[.posts].items.sorted { $0.date > $1.date }
        var lines = [
            "# \(context.site.name)",
            "",
            "> \(context.site.description)",
            "",
            "Amit Samant is a Senior iOS Engineer at Rakuten Viki in Singapore, a WWDC20 Swift",
            "Student Challenge winner, and an organizer of Swift Bengaluru and Swift Bharat.",
            "This site is his blog about Swift, iOS, and software engineering.",
            "",
            "## Posts",
            ""
        ]
        for post in posts {
            let url = context.site.url(for: post)
            lines.append("- [\(post.title)](\(url)) (\(formatter.string(from: post.date))): \(post.description)")
        }
        lines += [
            "",
            "## Links",
            "",
            "- [Portfolio](https://amitsamant.dev)",
            "- [GitHub](https://github.com/DominatorVbN)",
            "- [Twitter / X](https://twitter.com/amitsamant_dev)",
            "- [LinkedIn](https://linkedin.com/in/amitsamant-dev)",
            "- [RSS feed](\(context.site.url)/feed.rss)",
            ""
        ]
        let file = try context.createOutputFile(at: "llms.txt")
        try file.write(lines.joined(separator: "\n"))
    }
])
