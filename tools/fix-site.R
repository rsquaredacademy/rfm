#!/usr/bin/env Rscript
# Post-build fixes for the rfm pkgdown site.
#
# pkgdown 2.x has no option to emit <link rel="canonical"> tags and its
# sitemap is built from every *.html file that happens to sit in docs/,
# so it picks up 404.html, the Search Console verification file and any
# admin page pkgdown renders from a root *.md file. This script closes
# those gaps after `pkgdown::build_site()`:
#
#   1. deletes stale admin pages that should not be part of the site
#      (AGENTS.* and ISSUE_TEMPLATE.*);
#   2. inserts exactly one self-referencing canonical link into every
#      docs/**/*.html page (index.html -> site root "/");
#   3. rewrites docs/sitemap.xml so it only lists reader-facing pages
#      that really exist, dropping 404.html, google*.html, AGENTS.html,
#      ISSUE_TEMPLATE.html and CONDUCT.html.
#
# It is idempotent: running it twice produces the same output.
#
# Usage (from the package root, after pkgdown::build_site()):
#
#   Rscript tools/fix-site.R
#
# See tools/README.md for why this is a post-build step and not an
# in_header template include.

site_url <- "https://rfm.rsquaredacademy.com"
docs_dir <- "docs"

if (!dir.exists(docs_dir)) {
  stop("docs/ not found; run pkgdown::build_site() first", call. = FALSE)
}

# -- 1. admin pages that must not be published -------------------------

# pkgdown renders every *.md file in the package root (and .github/),
# so e.g. AGENTS.md becomes docs/AGENTS.html on every build. AGENTS.md
# has to stay at the repo root for agent tooling, and moving it to
# .github/ does not help because pkgdown renders .github/*.md too, so
# the rendered output is removed here instead.
stale <- c(
  "AGENTS.html", "AGENTS.md",
  "ISSUE_TEMPLATE.html", "ISSUE_TEMPLATE.md"
)
stale <- file.path(docs_dir, stale)
removed <- stale[file.exists(stale)]
if (length(removed) > 0) {
  file.remove(removed)
  message("Removed stale admin files: ", paste(basename(removed), collapse = ", "))
}

# -- 2. canonical links ------------------------------------------------

# The Search Console verification file is a bare text file, not a page.
skip_canonical <- function(path) {
  grepl("^google[0-9a-f]+\\.html$", basename(path), ignore.case = TRUE)
}

canonical_for <- function(path) {
  rel <- sub(paste0("^", docs_dir, "/"), "", path)
  rel <- gsub("\\\\", "/", rel)
  if (rel == "index.html") {
    paste0(site_url, "/")
  } else {
    paste0(site_url, "/", rel)
  }
}

html_files <- list.files(
  docs_dir,
  pattern = "\\.html$",
  recursive = TRUE,
  full.names = TRUE
)
html_files <- html_files[!skip_canonical(html_files)]

# pkgdown writes redirect stubs for function aliases (and other renamed
# topics): a page with <meta http-equiv="refresh"> and meta robots
# noindex that pkgdown also leaves out of the sitemap. For those the
# canonical URL is the redirect target, not the stub itself.
redirect_target <- function(lines) {
  hit <- grep('http-equiv="refresh"', lines, value = TRUE, fixed = TRUE)
  if (length(hit) == 0) {
    return(NULL)
  }
  url <- sub('.*URL=([^"]+)".*', "\\1", hit[1])
  if (identical(url, hit[1])) NULL else url
}

added <- 0L
stubs <- 0L
for (path in html_files) {
  # encoding = "bytes": read/write the file verbatim even if it contains
  # characters that are not representable in the native locale (Windows)
  lines <- readLines(path, warn = FALSE, encoding = "bytes")
  # drop any canonical link we inserted on an earlier run
  lines <- lines[!grepl("rel=[\"']canonical[\"']", lines)]
  head_end <- grep("</head>", lines, ignore.case = TRUE)
  if (length(head_end) == 0) {
    warning("No </head> in ", path, "; skipped", call. = FALSE)
    next
  }
  target <- redirect_target(lines)
  href <- if (is.null(target)) canonical_for(path) else target
  if (!is.null(target)) {
    stubs <- stubs + 1L
  }
  tag <- sprintf('<link rel="canonical" href="%s">', href)
  lines <- append(lines, tag, after = head_end[1] - 1L)
  writeLines(lines, path, useBytes = TRUE)
  added <- added + 1L
}
message(
  "Inserted canonical links into ", added, " HTML pages (",
  stubs, " redirect stubs point at their target)"
)

# -- 3. sitemap.xml ----------------------------------------------------

sitemap_path <- file.path(docs_dir, "sitemap.xml")
if (!file.exists(sitemap_path)) {
  stop("docs/sitemap.xml not found; run pkgdown::build_site() first", call. = FALSE)
}

# pages that are either not for readers or not real pages
excluded <- c(
  "404.html",
  "AGENTS.html",
  "ISSUE_TEMPLATE.html",
  "CONDUCT.html"
)

sitemap <- paste(readLines(sitemap_path, warn = FALSE), collapse = "\n")
entries <- regmatches(
  sitemap,
  gregexpr("<url><loc>[^<]+</loc></url>", sitemap)
)[[1]]

locs <- sub("^<url><loc>", "", entries)
locs <- sub("</loc></url>$", "", locs)
rel <- sub(paste0("^", site_url, "/?"), "", locs)

keep <- !(rel %in% excluded) &
  !grepl("^google[0-9a-f]+\\.html$", rel, ignore.case = TRUE) &
  file.exists(file.path(docs_dir, rel))

new_sitemap <- paste0(
  "<urlset xmlns = 'http://www.sitemaps.org/schemas/sitemap/0.9'>\n",
  paste0("<url><loc>", locs[keep], "</loc></url>\n", collapse = ""),
  "</urlset>\n"
)
writeLines(new_sitemap, sitemap_path, useBytes = TRUE)
message(
  "Sitemap: kept ", sum(keep), " of ", length(locs), " URLs (",
  length(locs) - sum(keep), " dropped)"
)

# -- 4. sanity check ---------------------------------------------------

canonical_counts <- vapply(
  html_files,
  function(path) {
    sum(grepl(
      "<link rel=\"canonical\"",
      readLines(path, warn = FALSE, encoding = "bytes"),
      fixed = TRUE
    ))
  },
  integer(1)
)
if (any(canonical_counts != 1L)) {
  stop(
    "Expected exactly one canonical link per page; problems: ",
    paste(names(canonical_counts)[canonical_counts != 1L], collapse = ", "),
    call. = FALSE
  )
}
message("OK: one canonical link on each of ", length(canonical_counts), " pages")
