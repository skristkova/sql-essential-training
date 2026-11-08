-- =============================================================
-- 03 | Functions & aggregates: strings, dates, SUM/AVG, GROUP BY, HAVING
-- Database: WSDA_Music (SQLite)
-- =============================================================

-- String functions: mailing address, postal code clean-up, upper/lower case
SELECT
  FirstName,
  LastName,
  Address,
  FirstName || ' ' || LastName || ' ' || Address || ', ' || City || ' ' || State || ' ' || PostalCode AS "Mailing Address",
  LENGTH(PostalCode)        AS "Postal Code Length",
  SUBSTR(PostalCode, 1, 5)  AS "5 digits postal code",
  UPPER(FirstName)          AS "First Name ALL caps",
  LOWER(LastName)           AS "Last Name ALL lower"
FROM
  Customer
WHERE
  Country = 'USA';

-- Date functions: birth date without time and employee age
SELECT
  LastName,
  FirstName,
  BirthDate,
  STRFTIME('%Y-%m-%d', BirthDate) AS "BirthDate No Timecode",
  STRFTIME('%Y-%m-%d', 'now') - STRFTIME('%Y-%m-%d', BirthDate) AS Age
FROM
  Employee;

-- Aggregate functions over all invoices
SELECT
  SUM(Total)            AS "Total Sales",
  ROUND(AVG(Total), 2)  AS "Average Total",
  MAX(Total)            AS "Max Total",
  MIN(Total)            AS "Min Total",
  COUNT(*)              AS "Invoice Count"
FROM
  Invoice;

-- Average invoice per country and city, only where the average is above 5
SELECT
  BillingCountry,
  BillingCity,
  ROUND(AVG(Total), 2) AS "Average Total"
FROM
  Invoice
GROUP BY
  BillingCountry,
  BillingCity
HAVING
  AVG(Total) > 5
ORDER BY
  BillingCountry;
