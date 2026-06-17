/*
 * Read Later + Continue Reading — entirely client side.
 *
 * The site is statically generated, so there is no server to remember a
 * reader's state. Instead we keep two small maps in localStorage:
 *
 *   blog:readLater         url -> { url, title, date, description, savedAt }
 *   blog:readingProgress   url -> { url, title, date, description,
 *                                   progress, scrollY, updatedAt }
 *
 * Article pages measure how far the reader has scrolled through the post body
 * and persist that progress. The home page reads both maps back and renders the
 * "Continue Reading" and "Read Later" lists. Articles keyed by their page path
 * (the same value the bookmark buttons and cards carry in data-url), so a card,
 * an article page, and a stored entry all agree on one key.
 */
(function () {
  'use strict';

  var READ_LATER_KEY = 'blog:readLater';
  var PROGRESS_KEY = 'blog:readingProgress';

  // Below this fraction we treat the post as "not really started" and don't
  // record it; at or above the finished mark we drop it from Continue Reading.
  var STARTED_AT = 0.04;
  var FINISHED_AT = 0.95;

  function available() {
    try {
      var k = '__blog_test__';
      window.localStorage.setItem(k, '1');
      window.localStorage.removeItem(k);
      return true;
    } catch (e) {
      return false;
    }
  }
  var canStore = available();

  function load(key) {
    if (!canStore) return {};
    try {
      return JSON.parse(window.localStorage.getItem(key)) || {};
    } catch (e) {
      return {};
    }
  }
  function save(key, obj) {
    if (!canStore) return;
    try {
      window.localStorage.setItem(key, JSON.stringify(obj));
    } catch (e) {}
  }

  // ── Read Later ──────────────────────────────────────────────────────────
  function isSaved(url) {
    return !!load(READ_LATER_KEY)[url];
  }

  function toggleSaved(meta) {
    var data = load(READ_LATER_KEY);
    if (data[meta.url]) {
      delete data[meta.url];
    } else {
      data[meta.url] = {
        url: meta.url,
        title: meta.title,
        date: meta.date || '',
        description: meta.description || '',
        savedAt: Date.now()
      };
    }
    save(READ_LATER_KEY, data);
  }

  function metaFromButton(btn) {
    return {
      url: btn.getAttribute('data-url'),
      title: btn.getAttribute('data-title'),
      date: btn.getAttribute('data-date'),
      description: btn.getAttribute('data-description')
    };
  }

  // Mirror saved state onto every bookmark button on the page (there may be
  // several pointing at the same article: a card and the article header).
  function reflectBookmarks() {
    var btns = document.querySelectorAll('.bookmark-btn');
    Array.prototype.forEach.call(btns, function (btn) {
      var saved = isSaved(btn.getAttribute('data-url'));
      btn.classList.toggle('is-saved', saved);
      btn.setAttribute('aria-pressed', String(saved));
      btn.setAttribute('aria-label', saved ? 'Saved for later' : 'Save for later');
      btn.setAttribute('title', saved ? 'Remove from Read Later' : 'Read later');
      var label = btn.querySelector('.bookmark-label');
      if (label) label.textContent = saved ? 'Saved' : 'Read later';
    });
  }

  // ── Continue Reading entries ────────────────────────────────────────────
  function dismissProgress(url) {
    var data = load(PROGRESS_KEY);
    if (data[url]) {
      delete data[url];
      save(PROGRESS_KEY, data);
    }
  }

  function continueEntries() {
    var data = load(PROGRESS_KEY);
    return Object.keys(data)
      .map(function (k) { return data[k]; })
      .filter(function (e) {
        return e && e.progress >= STARTED_AT && e.progress < FINISHED_AT;
      })
      .sort(function (a, b) { return (b.updatedAt || 0) - (a.updatedAt || 0); });
  }

  function readLaterEntries() {
    var data = load(READ_LATER_KEY);
    return Object.keys(data)
      .map(function (k) { return data[k]; })
      .sort(function (a, b) { return (b.savedAt || 0) - (a.savedAt || 0); });
  }

  // ── Card construction (home page lists) ─────────────────────────────────
  function makeBookmarkButton(entry) {
    var b = document.createElement('button');
    b.type = 'button';
    b.className = 'bookmark-btn';
    b.setAttribute('data-url', entry.url);
    b.setAttribute('data-title', entry.title);
    b.setAttribute('data-date', entry.date || '');
    b.setAttribute('data-description', entry.description || '');
    var icon = document.createElement('span');
    icon.className = 'bookmark-icon';
    b.appendChild(icon);
    return b;
  }

  function buildCard(entry, kind) {
    var li = document.createElement('li');

    var body = document.createElement('div');
    body.className = 'item-body';

    var title = document.createElement('a');
    title.className = 'item-title';
    // Arriving via Continue Reading restores the saved scroll offset. A hash
    // (not a query param) is used so it survives GitHub Pages' redirect that
    // adds the trailing slash to the article URL.
    title.href = kind === 'continue' ? entry.url + '#resume' : entry.url;
    title.textContent = entry.title;
    body.appendChild(title);

    var meta = document.createElement('div');
    meta.className = 'item-meta';
    if (entry.date) {
      var time = document.createElement('time');
      time.textContent = entry.date;
      meta.appendChild(time);
    }
    if (kind === 'continue') {
      var pct = document.createElement('span');
      pct.className = 'progress-label';
      pct.textContent = Math.round((entry.progress || 0) * 100) + '% read';
      meta.appendChild(pct);
    }
    body.appendChild(meta);

    if (kind === 'continue') {
      var bar = document.createElement('div');
      bar.className = 'item-progress';
      var fill = document.createElement('div');
      fill.className = 'item-progress-fill';
      fill.style.width = Math.round((entry.progress || 0) * 100) + '%';
      bar.appendChild(fill);
      body.appendChild(bar);
    } else if (entry.description) {
      var desc = document.createElement('p');
      desc.className = 'item-description';
      desc.textContent = entry.description;
      body.appendChild(desc);
    }

    li.appendChild(body);

    var actions = document.createElement('div');
    actions.className = 'item-actions';
    actions.appendChild(makeBookmarkButton(entry));
    if (kind === 'continue') {
      var dismiss = document.createElement('button');
      dismiss.type = 'button';
      dismiss.className = 'continue-dismiss';
      dismiss.setAttribute('data-url', entry.url);
      dismiss.setAttribute('aria-label', 'Remove from Continue Reading');
      dismiss.setAttribute('title', 'Dismiss');
      dismiss.textContent = '×';
      actions.appendChild(dismiss);
    }
    li.appendChild(actions);

    return li;
  }

  function renderList(name, entries, kind) {
    var section = document.getElementById(name + '-section');
    var list = document.getElementById(name + '-list');
    if (!section || !list) return;
    list.innerHTML = '';
    if (!entries.length) {
      section.hidden = true;
      return;
    }
    section.hidden = false;
    entries.forEach(function (entry) {
      list.appendChild(buildCard(entry, kind));
    });
  }

  function renderHome() {
    if (!document.getElementById('continue-reading-section') &&
        !document.getElementById('read-later-section')) {
      return;
    }
    renderList('continue-reading', continueEntries(), 'continue');
    renderList('read-later', readLaterEntries(), 'readlater');
    reflectBookmarks();
  }

  // ── Article reading-progress tracking ───────────────────────────────────
  function initProgress() {
    var article = document.querySelector('article');
    var postBody = document.querySelector('.post-body');
    var headerBtn = document.querySelector('.post-header .bookmark-btn');
    if (!article || !postBody || !headerBtn) return;

    var meta = metaFromButton(headerBtn);
    var key = meta.url;

    // Thin progress indicator pinned to the very top of the viewport.
    var track = document.createElement('div');
    track.className = 'reading-progress';
    var fill = document.createElement('div');
    fill.className = 'reading-progress-fill';
    track.appendChild(fill);
    document.body.appendChild(track);

    // Fraction of the post body that has scrolled above the bottom of the
    // viewport: 0 with the body's top at the viewport bottom, 1 once the body's
    // bottom reaches the viewport bottom.
    function computeProgress() {
      var rect = postBody.getBoundingClientRect();
      var bodyTop = rect.top + window.pageYOffset;
      var bodyHeight = postBody.offsetHeight;
      if (bodyHeight <= 0) return 0;
      var read = window.pageYOffset + window.innerHeight - bodyTop;
      return Math.max(0, Math.min(1, read / bodyHeight));
    }

    function paint(p) {
      fill.style.transform = 'scaleX(' + p + ')';
    }

    var hasScrolled = false;

    function persist() {
      if (!hasScrolled) return;
      var p = computeProgress();
      var data = load(PROGRESS_KEY);
      if (p >= FINISHED_AT) {
        if (data[key]) {
          delete data[key];
          save(PROGRESS_KEY, data);
        }
        return;
      }
      if (p < STARTED_AT) {
        if (data[key]) {
          delete data[key];
          save(PROGRESS_KEY, data);
        }
        return;
      }
      data[key] = {
        url: key,
        title: meta.title,
        date: meta.date || '',
        description: meta.description || '',
        progress: p,
        scrollY: Math.round(window.pageYOffset),
        updatedAt: Date.now()
      };
      save(PROGRESS_KEY, data);
    }

    var ticking = false;
    var lastSave = 0;
    function onScroll() {
      hasScrolled = true;
      if (!ticking) {
        ticking = true;
        window.requestAnimationFrame(function () {
          paint(computeProgress());
          ticking = false;
        });
      }
      var now = Date.now();
      if (now - lastSave > 400) {
        lastSave = now;
        persist();
      }
    }

    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('pagehide', persist);
    document.addEventListener('visibilitychange', function () {
      if (document.visibilityState === 'hidden') persist();
    });

    paint(computeProgress());

    // Restore the saved offset only when the reader followed a Continue Reading
    // link (#resume) — a normal visit starts at the top.
    function maybeResume() {
      if (window.location.hash !== '#resume') return;
      var saved = load(PROGRESS_KEY)[key];
      if (saved && typeof saved.scrollY === 'number') {
        var html = document.documentElement;
        var prev = html.style.scrollBehavior;
        html.style.scrollBehavior = 'auto'; // jump, don't smooth-scroll
        window.scrollTo(0, saved.scrollY);
        html.style.scrollBehavior = prev;
        paint(computeProgress());
      }
      // Drop the hash so a reload/share doesn't keep resuming.
      window.history.replaceState(null, '', window.location.pathname + window.location.search);
    }

    if (document.readyState === 'complete') {
      maybeResume();
    } else {
      window.addEventListener('load', maybeResume);
    }
  }

  // ── Wiring ──────────────────────────────────────────────────────────────
  // Delegated so dynamically built cards work without per-button listeners.
  function onClick(e) {
    var target = e.target;
    if (!target || !target.closest) return;

    var bookmark = target.closest('.bookmark-btn');
    if (bookmark) {
      e.preventDefault();
      e.stopPropagation();
      toggleSaved(metaFromButton(bookmark));
      reflectBookmarks();
      renderHome();
      return;
    }

    var dismiss = target.closest('.continue-dismiss');
    if (dismiss) {
      e.preventDefault();
      e.stopPropagation();
      dismissProgress(dismiss.getAttribute('data-url'));
      renderHome();
    }
  }

  function init() {
    document.addEventListener('click', onClick);
    reflectBookmarks();
    initProgress();
    renderHome();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
