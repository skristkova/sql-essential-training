-- =============================================================
-- 04 | Subqueries, views and data changes (INSERT / UPDATE / DELETE)
-- Database: WSDA_Music (SQLite)
-- =============================================================

-- Invoices below the global average (subquery in WHERE)
SELECT
  InvoiceDate,
  BillingAddress,
  BillingCity,
  Total
FROM
  Invoice
WHERE
  Total < (SELECT AVG(Total) FROM Invoice)
ORDER BY
  Total DESC;

-- City average next to the global average (subquery in SELECT)
SELECT
  BillingCity,
  AVG(Total)                        AS "City Average",
  (SELECT AVG(Total) FROM Invoice)  AS "Global Average"
FROM
  Invoice
GROUP BY
  BillingCity
ORDER BY
  BillingCity;

-- Invoices issued after invoice #251
SELECT
  InvoiceDate,
  BillingAddress,
  BillingCity
FROM
  Invoice
WHERE
  InvoiceDate > (SELECT InvoiceDate FROM Invoice WHERE InvoiceId = 251);

-- Invoices issued on the same days as invoices #251, #252 and #254
SELECT
  InvoiceDate,
  BillingAddress
FROM
  Invoice
WHERE
  InvoiceDate IN (SELECT InvoiceDate FROM Invoice WHERE InvoiceId IN (251, 252, 254));

-- Tracks that were never sold (NOT IN + DISTINCT)
SELECT
  TrackId,
  Composer,
  Name
FROM
  Track
WHERE
  TrackId NOT IN (SELECT DISTINCT TrackId FROM InvoiceLine);

-- View with the average invoice total
DROP VIEW IF EXISTS V_AvgTotal;
CREATE VIEW V_AvgTotal AS
SELECT
  ROUND(AVG(Total), 2) AS "Total Average"
FROM
  Invoice;

-- Data changes: insert, update and delete an artist
INSERT INTO Artist (Name)
VALUES ('Bob Marley');

UPDATE Artist
SET Name = 'Damien Marley'
WHERE ArtistId = 276;

DELETE FROM Artist
WHERE ArtistId = 276;
