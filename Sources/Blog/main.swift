import Foundation
import Publish
import Plot

struct Blog: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    var url = URL(string: "https://dominatorvbn.github.io/blog")!
    var name = "DominatorVbN's Blog"
    var description = "Thoughts on Swift, iOS, and software engineering"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try Blog().publish(withTheme: .foundation)
