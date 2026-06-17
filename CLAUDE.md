# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal site + blog. Static-site generator built on [Publish](https://github.com/johnsundell/publish) (bundles Plot for HTML, Ink for Markdown). One executable target, `Blog`; running it generates `Output/`. No app, no tests.

## Commands

- `swift run Blog` — compile + generate `Output/` (also what CI runs).
- In Xcode: run the `Blog` scheme. If CLI `swift build`/`run` fails with a `BuildServerProtocol.framework` dyld error (toolchain mismatch), use Xcode `BuildProject`/`RunProject` or run the built binary at `~/Library/Developer/Xcode/DerivedData/blog-*/Build/Products/Debug/Blog`.

## Local preview

After any UI change (HTML in `Theme+Blog.swift`, `styles.css`, or other resources), regenerate and show a live local preview, then point the user at the URL:

1. Regenerate `Output/` (build via Xcode `BuildProject`, then run the binary from the repo root so it finds `Content/`/`Resources/`: `cd <repo> && ~/Library/Developer/Xcode/DerivedData/blog-*/Build/Products/Debug/Blog`).
2. The site lives under the `/blog` subpath, so serve it under a matching path via a symlink:
   - `mkdir -p /tmp/blogpreview && ln -sf <repo>/Output /tmp/blogpreview/blog`
   - `cd /tmp/blogpreview && python3 -m http.server 8000 --bind 127.0.0.1` (run in background).
3. Open / share `http://127.0.0.1:8000/blog/...` (e.g. a post page). Tell the user to hard-refresh (⌘⇧R) since CSS/JS may be cached.

Serving `Output/` directly at `/` would 404 — the `/blog`-prefixed asset and link paths require the `blog/` path segment.

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
