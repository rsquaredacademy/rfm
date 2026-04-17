## ----echo = FALSE, message = FALSE----------------------------------------------------------------
require(data.table)
knitr::opts_chunk$set(
  comment = "#",
    error = FALSE,
     tidy = FALSE,
    cache = FALSE,
 collapse = TRUE
)

## ----echo=FALSE, file='_translation_links.R'------------------------------------------------------
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

## ----define_products------------------------------------------------------------------------------
Products = rowwiseDT(
  id=,        name=, price=,   unit=, type=,
   1L,     "banana",   0.63,  "unit", "natural",
   2L,    "carrots",   0.89,    "lb", "natural",
   3L,    "popcorn",   2.99,  "unit", "processed",
   4L,       "soda",   1.49, "ounce", "processed",
   NA, "toothpaste",   2.99,  "unit", "processed"
)

## ----define_new_tax-------------------------------------------------------------------------------
NewTax = data.table(
  unit = c("unit", "ounce"),
  type = "processed",
  tax_prop = c(0.65, 0.20)
)

NewTax

## ----define_product_received----------------------------------------------------------------------
set.seed(2156)

# NB: Jan 8, 2024 is a Monday.
receipt_dates = seq(from=as.IDate("2024-01-08"), length.out=10L, by="week")

ProductReceived = data.table(
  id=1:10, # unique identifier for an supply transaction
  date=receipt_dates,
  product_id=sample(c(NA, 1:3, 6L), size=10L, replace=TRUE), # NB: product '6' is not recorded in Products above.
  count=sample(c(50L, 100L, 150L), size=10L, replace=TRUE)
)

ProductReceived

## ----define_product_sales-------------------------------------------------------------------------
set.seed(5415)

# Monday-Friday (4 days later) for each of the weeks present in ProductReceived
possible_weekdays <- as.IDate(sapply(receipt_dates, `+`, 0:4))

ProductSales = data.table(
  id = 1:10,
  date = sort(sample(possible_weekdays, 10L)),
  product_id = sample(c(1:3, 7L), size = 10L, replace = TRUE), # NB: product '7' is in neither Products nor ProductReceived.
  count = sample(c(50L, 100L, 150L), size = 10L, replace = TRUE)
)

ProductSales

## -------------------------------------------------------------------------------------------------
Products[ProductReceived,
         on = c(id = "product_id")]

## ----eval=FALSE-----------------------------------------------------------------------------------
# Products[ProductReceived,
#          on = list(id = product_id)]

## ----eval=FALSE-----------------------------------------------------------------------------------
# Products[ProductReceived,
#          on = .(id = product_id)]

## -------------------------------------------------------------------------------------------------
ProductsChangedName = setnames(copy(Products), "id", "product_id")
ProductsChangedName

ProductsChangedName[ProductReceived, on = .NATURAL]

## -------------------------------------------------------------------------------------------------
ProductsKeyed = setkey(copy(Products), id)
key(ProductsKeyed)

ProductReceivedKeyed = setkey(copy(ProductReceived), product_id)
key(ProductReceivedKeyed)

ProductsKeyed[ProductReceivedKeyed]

## -------------------------------------------------------------------------------------------------
Products[
  ProductReceived,
  on = c("id" = "product_id"),
  j = .(product_id = x.id,
        name = x.name,
        price,
        received_id = i.id,
        date = i.date,
        count,
        total_value = price * count)
]

## -------------------------------------------------------------------------------------------------
dt1 = ProductReceived[
  Products,
  on = c("product_id" = "id"),
  by = .EACHI,
  j = .(total_value_received  = sum(price * count))
]

# alternative using multiple [] queries
dt2 = ProductReceived[
  Products,
  on = c("product_id" = "id"),
][, .(total_value_received  = sum(price * count)),
  by = "product_id"
]

identical(dt1, dt2)

## -------------------------------------------------------------------------------------------------
NewTax[Products, on = c("unit", "type")]

## -------------------------------------------------------------------------------------------------
# First Table
Products[ProductReceived,
         on = c("id" = "product_id"),
         nomatch = NULL]

# Second Table
ProductReceived[Products,
                on = .(product_id = id),
                nomatch = NULL]

## -------------------------------------------------------------------------------------------------
Products[!ProductReceived,
         on = c("id" = "product_id")]

## -------------------------------------------------------------------------------------------------
ProductReceived[!Products,
                on = c("product_id" = "id")]

## -------------------------------------------------------------------------------------------------
SubSetRows = Products[
  ProductReceived,
  on = .(id = product_id),
  nomatch = NULL,
  which = TRUE
]

SubSetRows

## -------------------------------------------------------------------------------------------------
SubSetRowsSorted = sort(unique(SubSetRows))

SubSetRowsSorted

## -------------------------------------------------------------------------------------------------
Products[SubSetRowsSorted]

## -------------------------------------------------------------------------------------------------
ProductReceived[Products,
                on = list(product_id = id)]

## -------------------------------------------------------------------------------------------------
NewTax[Products,
       on = c("unit", "type")
][, ProductReceived[.SD,
                    on = list(product_id = id)],
  .SDcols = !c("unit", "type")]

## -------------------------------------------------------------------------------------------------
ProductReceived[product_id == 1L]

## -------------------------------------------------------------------------------------------------
ProductSales[product_id == 1L]

## -------------------------------------------------------------------------------------------------
ProductReceived[ProductSales[list(1L),
                             on = "product_id",
                             nomatch = NULL],
                on = "product_id",
                allow.cartesian = TRUE]

## -------------------------------------------------------------------------------------------------
ProductReceived[ProductSales,
                on = "product_id",
                allow.cartesian = TRUE]

## -------------------------------------------------------------------------------------------------
ProductReceived[ProductSales[product_id == 1L],
                on = .(product_id),
                allow.cartesian = TRUE,
                mult = "first"]

## -------------------------------------------------------------------------------------------------
ProductReceived[ProductSales[product_id == 1L],
                on = .(product_id),
                allow.cartesian = TRUE,
                mult = "last"]

## -------------------------------------------------------------------------------------------------
ProductsTempId = copy(Products)[, temp_id := 1L]

## -------------------------------------------------------------------------------------------------
AllProductsMix =
  ProductsTempId[ProductsTempId,
                 on = "temp_id",
                 allow.cartesian = TRUE]

AllProductsMix[, temp_id := NULL]

# Removing type to make easier to see the result when printing the table
AllProductsMix[, !c("type", "i.type")]

## -------------------------------------------------------------------------------------------------
merge(x = Products,
      y = ProductReceived,
      by.x = "id",
      by.y = "product_id",
      all = TRUE,
      sort = FALSE)

## -------------------------------------------------------------------------------------------------
ProductSalesProd2 = ProductSales[product_id == 2L]
ProductReceivedProd2 = ProductReceived[product_id == 2L]

## -------------------------------------------------------------------------------------------------
ProductReceivedProd2[ProductSalesProd2,
                     on = "product_id",
                     allow.cartesian = TRUE
][date < i.date]

## -------------------------------------------------------------------------------------------------
ProductReceivedProd2[ProductSalesProd2,
                     on = list(product_id, date < date)]

## -------------------------------------------------------------------------------------------------
ProductReceivedProd2[ProductSalesProd2,
                     on = list(product_id, date < date),
                     nomatch = NULL]

## ----non_equi_join_example------------------------------------------------------------------------
x <- data.table(x_int = 2:4, lower = letters[1:3])
i <- data.table(i_int = c(2L, 4L, 5L), UPPER = LETTERS[1:3])
x[i, on = .(x_int >= i_int)]

## ----retain_i_column------------------------------------------------------------------------------
x[i, on = .(x_int >= i_int), .(i_int = i.i_int, x_int = x.x_int, lower, UPPER)]

## ----retain_i_column_inner_join-------------------------------------------------------------------
x[i, on = .(x_int >= i_int), .(i_int = i.i_int, x_int = x.x_int, lower, UPPER), nomatch = NULL]

## -------------------------------------------------------------------------------------------------
ProductPriceHistory = data.table(
  product_id = rep(1:2, each = 3),
  date = rep(as.IDate(c("2024-01-01", "2024-02-01", "2024-03-01")), 2),
  price = c(0.59, 0.63, 0.65,  # Banana prices
            0.79, 0.89, 0.99)  # Carrot prices
)

ProductPriceHistory

## -------------------------------------------------------------------------------------------------
ProductPriceHistory[ProductSales,
                    on = .(product_id, date),
                    roll = TRUE,
                    j = .(product_id, date, count, price)]

## -------------------------------------------------------------------------------------------------
ProductPriceHistory[ProductSales,
                    on = .(product_id, date),
                    roll = TRUE,
                    nomatch = NULL,
                    j = .(product_id, date, count, price)]

## -------------------------------------------------------------------------------------------------
ProductReceived[list(c(1L, 3L), 100L),
                on = c("product_id", "count")]

## -------------------------------------------------------------------------------------------------
ProductReceived[list(c(1L, 3L), 100L),
                on = c("product_id", "count"),
                nomatch = NULL]

## -------------------------------------------------------------------------------------------------
ProductReceived[!list(c(1L, 3L), 100L),
                on = c("product_id", "count")]

## -------------------------------------------------------------------------------------------------
Products[c("banana","popcorn"),
         on = "name",
         nomatch = NULL]

Products[!"popcorn",
         on = "name"]

## -------------------------------------------------------------------------------------------------
Products[ProductPriceHistory, 
         on = .(id = product_id), 
         price := i.price]

Products

## ----Updating_with_the_Latest_Record--------------------------------------------------------------
Products[ProductPriceHistory,
         on = .(id = product_id),
         `:=`(price = last(i.price), last_updated = last(i.date)),
         by = .EACHI]

Products

## -------------------------------------------------------------------------------------------------
cols <- setdiff(names(Products), "id")
ProductPriceHistory[, (cols) := 
  Products[.SD, on = .(id = product_id), .SD, .SDcols = cols]]
setnafill(ProductPriceHistory, fill=0, cols="price") # Handle missing values

ProductPriceHistory

