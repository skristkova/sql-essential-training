-- =============================================================
-- 01 | SELECT basics: aliases, ORDER BY, LIMIT, CASE, WHERE
-- Database: WSDA_Music (SQLite)
-- =============================================================

-- Customer list with column aliases, sorted by first and last name
SELECT
  FirstName AS [Customer First Name],
  LastName  AS "Customer Last Name",
  Email     AS EMAIL
FROM
  Customer
ORDER BY
  FirstName ASC,
  LastName DESC
LIMIT 10;

-- Invoice segmentation with CASE: only the "Top Performer" purchases
SELECT
  InvoiceDate,
  BillingAddress,
  BillingCity,
  Total,
  CASE
    WHEN Total < 2.00                 THEN 'Baseline Purchase'
    WHEN Total BETWEEN 2.00 AND 6.99  THEN 'Low Purchase'
    WHEN Total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
    ELSE 'Top Performer'
  END AS PurchaseType
FROM
  Invoice
WHERE
  PurchaseType = 'Top Performer'
ORDER BY
  InvoiceDate;
