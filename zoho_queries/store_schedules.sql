SELECT
  stores."Chain" AS 'Chain',
  stores."Store Number" AS 'Store Number',
  stores."Store Name" AS 'Store Name',
  STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y') AS 'Invoice Month Start',
  ADDDATE(ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), -1) AS 'Invoice Month End',
  IF_CASE(stores."Weekends", '0000000', BUSINESS_DAYS(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), '0000000'), /* Else */ BUSINESS_DAYS(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), ADDDATE(ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), -1), '1000000')) AS 'Business Days In Month',
  IF_CASE(stores."Weekends", '0000000', BUSINESS_DAYS(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), IF(MONTH(months."Date") = MONTH(TODAY()), TODAY(), ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1)), '0000000'), /* Else */ BUSINESS_DAYS(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), ADDDATE(ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), -1), '1000000')) AS 'Business Days So Far',
  IF(TODAY() > ADDDATE(ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), -1), 0, 1) * IF_CASE(stores."Weekends", '0000000', BUSINESS_DAYS(TODAY(), ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), '0000000'), /* Else */ BUSINESS_DAYS(months."Date", ADDDATE(ADDMONTH(STR_TO_DATE(CONCAT(MONTH(months."Date"), '/', 1, '/', YEAR(months."Date")), '%m/%d/%Y'), 1), -1), '1000000')) AS 'Business Days To Go'
FROM "Sales Months" AS months
JOIN "Stores" AS stores
