import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    var url = URL(string: "https://dominatorvbn.github.io/blog")!
    var name = "Amit Samant"
    var description = "Senior iOS Engineer. Writing about Swift, iOS, and software engineering."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Blog().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .blog),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap()
])
