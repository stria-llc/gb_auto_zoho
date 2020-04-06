SELECT
  months."Date" AS 'Invoice Month Start',
  lastYear."CompanyNumber" AS 'Store Number',
  lastYear."StoreSales" AS 'Store Sales',
  lastYear."CarCount" AS 'Cars',
  lastYear."TireUnitSales" AS 'Tires'
FROM "Sales Months" AS months
LEFT JOIN
  "Sales Projections" AS lastYear ON
    MONTH(months."Date") = lastYear."ProjMonth"
    AND YEAR(months."Date") = lastYear."Year" + 1
    AND lastYear."ActualOrBudget" = 'Actual'
