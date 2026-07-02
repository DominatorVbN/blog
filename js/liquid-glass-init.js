/*
 * Initialises the liquidGL "liquid glass" lens on the site chrome.
 * Load order matters: html2canvas.min.js, then liquidGL.js, then this file.
 *
 * liquidGL self-detects missing WebGL and falls back to a plain CSS
 * backdrop-filter frost on its own; the `liquidgl-on` class is only added
 * when the WebGL renderer is actually running, so the stylesheet keeps the
 * regular frosted-nav look in every other case (no JS, no WebGL).
 */
(function () {
  function init() {
    if (!window.liquidGL || !document.querySelector(".liquid-glass")) return;

    var result = window.liquidGL({
      target: ".liquid-glass",
      snapshot: "body",
      // Blog pages are long and image-heavy; keep the snapshot texture
      // small on phones to stay under mobile GPU texture limits.
      resolution: window.innerWidth < 768 ? 1.0 : 1.5,
      refraction: 0.012,
      bevelDepth: 0.09,
      bevelWidth: 0.16,
      frost: 3,
      shadow: true,
      specular: true,
      reveal: "fade",
      tilt: false,
      magnify: 1,
    });

    if (result && !window.__liquidGLNoWebGL__) {
      document.documentElement.classList.add("liquidgl-on");
    }

    // liquidGL keeps lens elements at opacity 0 until its snapshot succeeds
    // (reveal: "fade"). If snapshotting stalls or fails, the nav must not
    // stay invisible — force it visible; the tint wrapper still provides a
    // readable frosted bar over the (possibly blank) lens.
    setTimeout(function () {
      document.querySelectorAll(".liquid-glass").forEach(function (el) {
        if (getComputedStyle(el).opacity === "0") el.style.opacity = "1";
      });
    }, 8000);
  }

  // Snapshot after images/fonts have loaded so html2canvas captures them.
  if (document.readyState === "complete") {
    init();
  } else {
    window.addEventListener("load", init);
  }
})();
