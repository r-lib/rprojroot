# Adapted from fs
describe("path", {
  it("returns paths UTF-8 encoded", {
    skip_on_os("solaris")
    expect_equal(Encoding(path("föö")), "UTF-8")
  })

  it("returns paths UTF-8 encoded 2", {
    skip_on_os("solaris")
    skip_on_os("windows")
    expect_equal(Encoding(path("\U4F60\U597D.R")), "UTF-8")
  })

  it("returns empty strings for empty inputs", {
    expect_equal(path(""), "")
    expect_equal(path(character()), character())
    expect_equal(path("foo", character(), "bar"), character())
  })

  it("propagates NA strings", {
    expect_equal(path(NA_character_), NA_character_)
    expect_equal(path("foo", NA_character_), NA_character_)
    expect_equal(path(c("foo", "bar"), c("baz", NA_character_)), c("foo/baz", NA_character_))
  })

  it("does not double paths", {
    expect_equal(path("", "foo"), "/foo")

    # This could be a UNC path, so we keep the doubled path.
    expect_equal(path("//foo", "bar"), "//foo/bar")
  })

  it("errors on paths which are too long", {
    expect_error(path(paste(rep("a", 100000), collapse = "")))
  })

  it("follows recycling rules", {
    expect_equal(path("foo", character()), character())
    expect_equal(path("foo", "bar"), "foo/bar")
    expect_equal(path("foo", c("bar", "baz")), c("foo/bar", "foo/baz"))
    expect_equal(path(c("foo", "qux"), c("bar", "baz")), c("foo/bar", "qux/baz"))

    expect_error(path(c("foo", "qux", "foo2"), c("bar", "baz")))
  })
})
