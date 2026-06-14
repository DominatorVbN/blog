# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal site + blog. Static-site generator built on [Publish](https://github.com/johnsundell/publish) (bundles Plot for HTML, Ink for Markdown). One executable target, `Blog`; running it generates `Output/`. No app, no tests.

## Commands

- `swift run Blog` — compile + generate `Output/` (also what CI runs).
- In Xcode: run the `Blog` scheme. If CLI `swift build`/`run` fails with a `BuildServerProtocol.framework` dyld error (toolchain mismatch), use Xcode `BuildProject`/`RunProject` or run the built binary at `~/Library/Developer/Xcode/DerivedData/blog-*/Build/Products/Debug/Blog`.

## Architecture

- **`Sources/Blog/main.swift`** — `Blog: Website` (URL, sections, metadata) + ordered publishing steps. Order matters: `installPlugin(.resourceImagePaths)` must precede `addMarkdownFiles()` (it registers an Ink parser modifier). Then `copyResources`, `generateHTML(.blog)`, RSS, sitemap, and a custom step writing `Output/llms.txt`.
- **`Sources/Blog/Theme+Blog.swift`** — all HTML. `BlogHTMLFactory` implements the `make*HTML` methods via Plot's DSL; reusable `Node` extensions (`siteHead`, `itemRow`, `projectCard`, etc.) live here. Home-page content is hard-coded here, not from Content.
- **`Content/` vs `Resources/`**: `Content/` is Markdown only → `posts/foo.md` renders to `Output/posts/foo/index.html`. Publish does **not** copy non-Markdown from `Content/`, so images live in `Resources/` (copied verbatim to `Output/` root); post images at `Resources/posts/<slug>/images/<file>` land beside the page.

## Gotchas

1. **`/blog` subpath** (`url = https://amitsamant.dev/blog`): links/assets must be page-relative or wrapped in `context.site.prefixedPath(...)`; root-absolute paths 404. Follow existing `prefixedPath` usage.
2. **Post image paths**: author them at the real on-disk location, e.g. `![alt](../../Resources/posts/<slug>/images/<file>.png)`, so editors preview them. The `resourceImagePaths` plugin (`Plugin+ResourceImages.swift`) rewrites `<img src=".../images/<file>">` to page-relative `images/<file>` at build; bare `images/<file>` refs are left as-is. The `image:` front-matter (OG meta) is separate and uses an absolute path.

## Commits

Never add a `Co-Authored-By` trailer or any AI/tool attribution.

## Deployment

`.github/workflows/deploy.yml` on push to `main`: `swift run Blog`, then publish `./Output` to `gh-pages` via `peaceiris/actions-gh-pages`. `Output/` is generated.
