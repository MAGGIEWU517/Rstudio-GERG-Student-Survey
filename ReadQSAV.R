# Decode Qualtrics survey data

#' Test for missing values
#' Treats "", NA, NULL or zero-length as empty
#'
#' @param v Vector to test
#' @return TRUE for each element of v with no meaningful data
#' @export
#' @examples
#' isEmpty(c(0, NA, ""))
#' isEmpty(logical(0))
#' isEmpty()
isEmpty <- function(v=NULL) {
  isE <- function(x){
    if (is.na(x[1])) return(TRUE)
    if ((typeof(x[1])=="character") && (nchar(x) == 0)) return(TRUE)
    FALSE
  }
  if (is.null(v)) return(TRUE)
  if (length(v) == 0) return(TRUE)
  vapply(v, isE, FUN.VALUE = FALSE)
}
install.packages("haven")
#' Load Qualtrics survey download in .SAV file format, extracting stem and items
#'
#' Uses haven package, then cleans variable names and labels,
#' identifies timing items, empties to NA, fixes numbers as characters,
#' types system dates, adds Duration_in_seconds,
#' adds description and wording attributes to questions.
#' @param file Filename of SPSS .SAV file; can be compressed or online
#' @return List of two dataframes: data and items
#' @export
#' @examples
#' tmp <- ReadSPSSsurvey("download.SAV")
#' Data <- tmp[[1]]
#' Items <- tmp[[2]]
ReadQualtricsSAV <- function(file) {
  require("haven") # from the tidyverse
  options(stringsAsFactors = FALSE)
  Data <- read_spss(file, user_na = TRUE) # keep SPSS labels
  if (nrow(Data) == 0)
    warning("No data! Try read/save in SPSS or PSPP")
  Data <- zap_formats(Data) # don't need SPSS formatting
  for (col in 1:length(Data)) {
    nam <- names(Data)[col]
    atts <- attributes(Data[[col]])
    Data[[col]] <- ifelse(isEmpty(Data[[col]])|is.nan(Data[[col]]),NA, Data[[col]])
    if (!isEmpty(atts[['label']])) {
      if (grepl("Timing - ", atts[['label']])) { # is timing item
        atts$timing <- TRUE
        atts[['label']] <- sub("Timing - ", "", atts[['label']])
        Data[[col]][Data[[col]] == 0] <- NA # remove zeroes
      }
      atts[['label']] <- sub(" - \\[Field-[0-9]*]", "", atts[['label']]) # remove from label
      atts$wording <- atts[['label']] # Qualtrics doesn't give both
    }
    names(Data)[col] <- nam
    attributes(Data[[col]]) <- atts
  }
  names(Data)[names(Data)=="Duration__in_seconds_"] <- "Duration_in_seconds"
  # build item data frame
  Items <- data.frame(ColName=names(Data), row.names = names(Data))
  attr(Items, "source") <- attr(Data, "source")
  for (col in names(Data)) {
    atts <- attributes(Data[, col][[1]])
    if (!is.null(atts$labels))
      Items[col, "Type"] <- "Factor" # categorical variable
    else if (!is.null(atts$timing))
      Items[col, "Type"] <- "Timing"
    else {Items[col, "Type"] <- NA} # other item types?
    if (!is.null(atts$description))
      Items[col, "Stem"] <- atts$description
    if (!is.null(atts$prompt))
      Items[col, "Prompt"] <- atts$prompt
    if (!is.null(atts$wording))
      Items[col, "Wording"] <- atts$wording
    else if (!is.null(atts[['label']]))
      Items[col, "Wording"] <- atts[['label']]
    if (!is.null(atts$labels)) {
      Items[col, "Values"] <- paste(atts$labels, collapse=",")
      Items[col, "Value Names"] <- paste(trimws(names(atts$labels)), collapse=";")
    }
    if (!is.null(Items[col, "Wording"])) { # only if item comes from a survey question
      Wording <- strsplit(Items[col, "Wording"], " - ", fixed = TRUE) # Qualtrics combines stem and prompt
      lw <- length(Wording[[1]]) # number of splits
      if (lw > 1) { # assume this is Qualtrics combination, so split
        Items[col, "Wording"] <- Wording[[1]][lw] # keep last as wording
        Items[col, "Stem"] <- paste(Wording[[1]][1:(lw-1)], collapse = " - ") # reconstitute stem
      } else { # only simple stem
        Items[col, "Wording"] <- NA
        Items[col, "Stem"] <- Wording[[1]][1]
      }
    }
  }
  list(Data, Items)
}
MydataID1 <- ReadQualtricsSAV("AnonIDGSS.sav")
DataID1 <- MydataID1[[1]]
ItemsID1 <- MydataID1[[2]]
write.csv(DataID1, file = "DataID1.csv")
write.csv(ItemsID1, file = "ItemsID1.csv")

MydataID2 <- ReadQualtricsSAV("AnonIDGSS2.sav")
DataID2 <- MydataID2[[1]]
ItemsID2 <- MydataID2[[2]]

write.csv(DataID2, file = "DataID2.csv")
write.csv(ItemsID2, file = "ItemsID2.csv")



