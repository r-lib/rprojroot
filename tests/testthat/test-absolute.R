# From fs
describe("is_absolute_path", {
  it("detects windows absolute paths", {
    expect_true(is_absolute_path("c:\\"))
    expect_true(is_absolute_path("c:/"))
    expect_true(is_absolute_path("P:/"))
    expect_true(is_absolute_path("P:\\"))
    expect_true(is_absolute_path("\\\\server\\mountpoint\\"))
    expect_true(is_absolute_path("\\foo"))
    expect_true(is_absolute_path("\\foo\\bar"))
  })
  it("detects posix absolute paths", {
    expect_false(is_absolute_path(""))
    expect_false(is_absolute_path("foo/bar"))
    expect_false(is_absolute_path("./foo/bar"))
    expect_false(is_absolute_path("../foo/bar"))

    expect_true(is_absolute_path("/"))
    expect_true(is_absolute_path("/foo"))
    expect_true(is_absolute_path("/foo/bar"))
    expect_true(is_absolute_path("~/foo/bar"))
  })
})

