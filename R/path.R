# Modeled after fs::path()
path <- function(...) {
  dots <- list(...)

  if (!is.null(names(dots)) && any(names(dots) != "")) {
    warning("Arguments must be unnamed", call. = FALSE)
  }

  # Different recycling rules for zero-length vectors
  lengths <- lengths(dots)
  if (any(lengths == 0) && all(lengths %in% 0:1)) {
    return(character())
  }

  # Side effect: check recycling rules
  components <- as.data.frame(dots, stringsAsFactors = FALSE)

  missing <- apply(is.na(components), 1, any)

  out <- do.call(file.path, components)
  out[missing] <- NA_character_
  out
}
