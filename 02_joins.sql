-- =============================================================
-- 02 | JOINs: combining customers, invoices and employees
-- Database: WSDA_Music (SQLite)
-- =============================================================

-- Every invoice with the customer who placed it
SELECT
  c.LastName,
  c.FirstName,
  i.InvoiceId,
  c.CustomerId,
  i.InvoiceDate,
  i.Total
FROM
  Invoice AS i
INNER JOIN
  Customer AS c
  ON i.CustomerId = c.CustomerId
ORDER BY
  c.CustomerId;

-- Top 10 invoices together with the customer and their support rep
-- (three tables joined: Invoice -> Customer -> Employee)
SELECT
  e.FirstName AS EmployeeFirstName,
  e.LastName  AS EmployeeLastName,
  e.EmployeeId,
  c.FirstName AS CustomerFirstName,
  c.LastName  AS CustomerLastName,
  c.SupportRepId,
  i.CustomerId,
  i.Total
FROM
  Invoice AS i
INNER JOIN
  Customer AS c
  ON i.CustomerId = c.CustomerId
INNER JOIN
  Employee AS e
  ON c.SupportRepId = e.EmployeeId
ORDER BY
  i.Total DESC
LIMIT 10;
