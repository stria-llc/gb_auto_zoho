SELECT
  projections."CompanyNumber" AS 'Store Number',
  STR_TO_DATE(CONCAT(projections."ProjMonth", '/', 1, '/', projections."Year"), '%m/%d/%Y') AS 'Date',
  projections."StoreSales" AS 'Store Sales',
  projections."CarCount" AS 'Cars',
  projections."ServiceSalesPerCar" AS 'Service Sales per Car',
  projections."GrossProfitDollars" AS 'Gross Profit',
  projections."GrossProfitPercent" AS 'Gross Profit Pct',
  projections."BudgetExpense" AS 'Budget Expense',
  projections."EstimatedProfit" AS 'Estimated Profit'
FROM "Sales Projections" AS projections
WHERE projections."ActualOrBudget" = 'Budget'
