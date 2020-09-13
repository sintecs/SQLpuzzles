--------------------------------------------------------------------------------
--                                                                            --
-- This function will return a table of rows with one column named rn. This   --
-- table will have @NumRows total rows with each row containing the row       --
-- number as the rn value. Max Rows Returned 65,536                           --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION GenerateRows
(
   @NumRows                     INT
)
RETURNS TABLE AS
RETURN
(
   WITH
      Numbers0 AS (SELECT 1 n UNION SELECT 0 n)
      ,Numbers1 AS (SELECT 1 n FROM Numbers0 n1 CROSS JOIN Numbers0 n2)
      ,Numbers2 AS (SELECT 1 n FROM Numbers1 n1 CROSS JOIN Numbers1 n2)
      ,Numbers3 AS (SELECT 1 n FROM Numbers2 n1 CROSS JOIN Numbers2 n2)
      ,Numbers4 AS (SELECT 1 n FROM Numbers3 n1 CROSS JOIN Numbers3 n2)
   SELECT
      rn
   FROM
      (
         SELECT
            ROW_NUMBER() OVER (ORDER BY n) rn
         FROM
            Numbers4
      ) n
   WHERE
      rn <= @NumRows
);

GO
