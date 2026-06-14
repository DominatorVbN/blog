import Publish
import Ink

extension Plugin {
    /// Lets posts reference images by their real on-disk location in
    /// `Resources/.../images/...` (so editors can preview them while writing),
    /// while the built HTML keeps the page-relative `images/...` path that
    /// actually ships under the deployed `/blog` subpath.
    ///
    /// Any `<img>` whose `src` ends in `.../images/<file>` is collapsed down to
    /// `images/<file>`. References that are already page-relative (`images/X.png`)
    /// have no leading path segment and are left untouched.
    static var resourceImagePaths: Self {
        Plugin(name: "Resolve Resources image paths") { context in
            context.markdownParser.addModifier(Modifier(target: .images) { html, _ in
                html.replacingOccurrences(
                    of: #"src="[^"]*/(images/[^"]+)""#,
                    with: #"src="$1""#,
                    options: .regularExpression
                )
            })
        }
    }
}
