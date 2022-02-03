attachment::att_amend_desc(
  extra.suggests = c("pkgload", "processx", "rlang", "glue")
    )

usethis::use_version()

x <- "v0.1.0"
gert::git_tag_create(x, x)
gert::git_tag_push(x)
