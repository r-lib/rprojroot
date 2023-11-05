if (requireNamespace("rlang", quietly = TRUE)) {
  colon_colon <- `::`

  ensym <- rlang::ensym
  inject <- rlang::inject
  as_string <- rlang::as_string

  `::` <- function(x, y) {
    x_sym <- ensym(x)
    y_sym <- ensym(y)
    tryCatch(
      inject(colon_colon(!!x_sym, !!y_sym)),
      packageNotFoundError = function(e) {
        skip_if_not_installed(as_string(x_sym))
      }
    )
  }
}
