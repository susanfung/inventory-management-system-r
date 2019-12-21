# Indicates mandatory fields.
fieldsMandatory <- c("Name", "Location")

# Add an asterisk to an input label.
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

# Formatting.
appCSS <-
  ".mandatory_star { color: red; }
   #error { color: red; }"

# Collects all fields to be saved.
fieldsAll <- c("Barcode", "Name", "Location", "Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8")

# Directory where responses get stored.
responsesDir <- file.path("responses")

# Get current Epoch time
epochTime <- function() {
  as.integer(Sys.time())
}

# Get a formatted string of the timestamp (exclude colons as they are invalid characters in Windows filenames).
humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

# Load all responses into a data.frame.
loadData <- function() {
  files <- list.files(file.path(responsesDir), full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  data <- dplyr::bind_rows(InventoryList$Inventory, data)
  data
}