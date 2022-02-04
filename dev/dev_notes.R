attachment::att_amend_desc(
  extra.suggests = c("pkgload", "processx", "rlang")
    )

usethis::use_version()

x <- paste0("v", pkgload::pkg_version())
gert::git_tag_create(x, x)
gert::git_tag_push(x)
