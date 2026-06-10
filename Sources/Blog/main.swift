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

try Blog().publish(
    withTheme: .blog,
    additionalSteps: [
        .step(named: "Set posts section title") { context in
            context.mutateSection(withID: .posts) { section in
                section.title = "Posts"
            }
        }
    ]
)
