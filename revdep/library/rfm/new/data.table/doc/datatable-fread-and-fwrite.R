## ----echo=FALSE, file='_translation_links.R'----------------------------------
# build a link list of alternative languages (may be character(0))
# idea is to look like 'Other languages: en | fr | de'
.write.translation.links <- function(fmt) {
    url = "https://rdatatable.gitlab.io/data.table/articles"
    path = dirname(knitr::current_input(TRUE))
    if (basename(path) == "vignettes") {
      lang = "en"
    } else {
      lang = basename(path)
      path = dirname(path)
    }
    translation = dir(path,
      recursive = TRUE,
      pattern = glob2rx(knitr::current_input(FALSE))
    )
    transl_lang = ifelse(dirname(translation) == ".", "en", dirname(translation))
    block = if (!all(transl_lang == lang)) {
      linked_transl = sprintf("[%s](%s)", transl_lang, file.path(url, sub("(?i)\\.Rmd$", ".html", translation)))
      linked_transl[transl_lang == lang] = lang
      sprintf(fmt, paste(linked_transl, collapse = " | "))
    } else ""
    knitr::asis_output(block)
}

## ----echo = FALSE, message = FALSE--------------------------------------------
require(data.table)
knitr::opts_chunk$set(
  comment = "#",
    error = FALSE,
     tidy = FALSE,
    cache = FALSE,
 collapse = TRUE)
.old.th = setDTthreads(1)

## -----------------------------------------------------------------------------
# Create a sample file with some unwanted lines
writeLines(
'HEADER: Some metadata
HEADER: More metadata
1 2.0 3.0
2 4.5 6.7
HEADER: Yet more
3 8.9 0.1
4 1.2 3.4',
"example_data.txt")

library(data.table)
fread("grep -v HEADER example_data.txt")

## -----------------------------------------------------------------------------
my_data_string = "colA,colB,colC\n1,apple,TRUE\n2,banana,FALSE\n3,orange,TRUE"
dt_from_text = fread(text = my_data_string)
print(dt_from_text)

## -----------------------------------------------------------------------------
# dt = fread("https://people.sc.fsu.edu/~jburkardt/data/csv/airtravel.csv")
# print(dt)

## -----------------------------------------------------------------------------
# fread's default behavior is to treat large integers as "integer64"; however, this global setting can be changed:
options(datatable.integer64 = "double")   # Example: set globally to "double"
getOption("datatable.integer64") 

## -----------------------------------------------------------------------------
data.table::fread(text='x,y\n"This "quote" is invalid, but fread works anyway",1')

## -----------------------------------------------------------------------------
data.table::fread(text='x,y\nNot"Valid,1')

## -----------------------------------------------------------------------------
dt_quoting_scenario = data.table(
  text_field = c("Contains,a,comma", "Contains \"a quote\"", "Clean_text", "", NA),
  numeric_field = 1:5
)
temp_quote_adv = tempfile(fileext = ".csv")

fwrite(dt_quoting_scenario, temp_quote_adv)
# Note the output: the empty string is quoted (""), but the NA is not.
cat(readLines(temp_quote_adv), sep = "\n")

## -----------------------------------------------------------------------------
dt_timestamps = data.table(
  ts = as.POSIXct("2023-10-26 14:35:45.123456", tz = "GMT"),
  dt = as.Date("2023-11-15")
)
temp_dt_iso = tempfile(fileext = ".csv")
fwrite(dt_timestamps, temp_dt_iso, dateTimeAs = "ISO")
cat(readLines(temp_dt_iso), sep = "\n")
unlink(temp_dt_iso)

## -----------------------------------------------------------------------------
if (requireNamespace("bit64", quietly = TRUE)) {
  dt_i64 = data.table(uid = bit64::as.integer64("1234567890123456789"), val = 100)
  temp_i64_out = tempfile(fileext = ".csv")
  fwrite(dt_i64, temp_i64_out)
  cat(readLines(temp_i64_out), sep = "\n")
  unlink(temp_i64_out)
}

## -----------------------------------------------------------------------------
dt = data.table(A = 1:3, B = 4:6, C = 7:9)

# Write only columns C and A, in that order
fwrite(dt[, .(C, A)], "out.csv")
cat(readLines("out.csv"), sep = "\n")
file.remove("out.csv")

