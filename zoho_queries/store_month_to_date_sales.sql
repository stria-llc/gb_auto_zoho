SELECT
  "Store Number",
  STR_TO_DATE(CONCAT(MONTH("Date"), '/1/', YEAR("Date")), '%m/%d/%Y') AS 'Invoice Month Start',
  SUM("Day Sales") AS 'Month To Date Sales'
FROM "Store Daily Sales"
GROUP BY
  "Store Number",
  STR_TO_DATE(CONCAT(MONTH("Date"), '/1/', YEAR("Date")), '%m/%d/%Y')
