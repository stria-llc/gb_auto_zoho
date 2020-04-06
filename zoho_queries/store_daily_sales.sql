SELECT
  vast."Company_Number" AS 'Store Number',
  stores."Store Name" AS 'Store Name',
  vast."INVOICE_DATE" AS 'Date',
  SUM(vast."Selling_Price") AS 'Day Sales'
FROM "VAST_History" AS vast
LEFT JOIN "Stores" AS stores ON vast."Company_Number" = stores."Store Number"
WHERE
  vast."DECLINED" = 0
  AND vast."CUSTOMER_TYPE" NOT IN ( 2 , 3 )
  AND vast."STATUS" != 'T'
  AND vast."Tax_Description" != 'Wholesale'
  AND vast."CLASS" not in ( 54 , 58 , 59 , 64 )
GROUP BY
  vast."Company_Number",
  stores."Store Name",
  vast."INVOICE_DATE"
