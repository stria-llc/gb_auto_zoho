SELECT
  schedules."Chain" AS 'Chain',
  schedules."Store Number" AS 'Store Number',
  schedules."Store Name" AS 'Store Name',
  schedules."Invoice Month Start" AS 'Month Start',
  schedules."Invoice Month End" AS 'Month End',
  schedules."Business Days In Month" AS 'Business Days In Month',
  IF(schedules."Business Days To Go" < 0, 0, schedules."Business Days To Go") AS 'Business Days To Go',
  budgets."Store Sales" / schedules."Business Days In Month" AS 'Daily Budget',
  budgets."Store Sales" AS 'Current Month Budget',
  dailySales."Day Sales" AS 'Yesterday Sales',
  mtdSales."Month To Date Sales" AS 'Month To Date Sales',
  mtdSales."Month To Date Sales" / schedules."Business Days So Far" * schedules."Business Days In Month" AS 'Current Month Projection',
  previousYear."Store Sales" AS 'Previous Year Sales',
  100 * ((mtdSales."Month To Date Sales" / schedules."Business Days So Far" * schedules."Business Days In Month") -previousYear."Store Sales") / previousYear."Store Sales" AS 'Projected Over-Under % vs Last Year',
  (mtdSales."Month To Date Sales" / schedules."Business Days So Far" * schedules."Business Days In Month") -previousYear."Store Sales" AS 'Projected Over-Under $ vs Last Year'
FROM
  "Store Schedules" AS schedules
  LEFT JOIN "Previous Year Metrics" AS previousYear ON
    schedules."Invoice Month Start" = previousYear."Invoice Month Start"
    AND previousYear."Store Number" = schedules."Store Number"
  LEFT JOIN "Store Budgets" AS budgets ON
    schedules."Store Number" = budgets."Store Number"
    AND schedules."Invoice Month Start" = budgets."Date"
  LEFT JOIN "Store Daily Sales" AS dailySales ON
    dailySales."Store Number" = schedules."Store Number"
    AND dailySales."Date" = ADDDATE(TODAY(), -1)
  LEFT JOIN "Store Month To Date Sales" AS mtdSales ON
    mtdSales."Store Number" = schedules."Store Number"
    AND mtdSales."Invoice Month Start" = schedules."Invoice Month Start"
  ORDER BY
    schedules."Invoice Month Start" DESC,
    schedules."Chain",
    (mtdSales."Month To Date Sales" / schedules."Business Days So Far" * schedules."Business Days In Month") DESC
