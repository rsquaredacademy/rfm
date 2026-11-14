test_that("numeric segment names preserve first matches and unmatched rows (H5)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5,
                  revenue = (1:5) / 10)
  t <- unclass(rfm_table_customer(x, id, orders, days, revenue, ad))
  expect_equal(rfm_segment(t, "1", 1, 5, 1, 5, 1, 5)$segment, rep("1", 5))
  expect_equal(rfm_segment(t, "01", 1, 5, 1, 5, 1, 5)$segment, rep("01", 5))
  t$rfm$recency_score <- c(5, 4, 3, 2, NA)
  seg <- rfm_segment(t, c("1", "Second"), c(4, 3), c(5, 5),
                     c(1, 1), c(5, 5), c(1, 1), c(5, 5))
  expect_equal(seg$segment, c("1", "1", "Second", "Others", "Others"))
  summary <- rfm_segment_summary(seg)
  first <- summary[summary$segment == "1", ]
  expect_equal(first$customers, 2L)
  expect_equal(first$orders, 3)
  expect_equal(first$revenue, .3)
  expect_equal(first$aov, .1)
})
