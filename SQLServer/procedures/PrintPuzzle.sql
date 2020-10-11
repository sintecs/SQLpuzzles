--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will generate a table that displays the current puzzle      --
-- values for the passed in PuzzleID                                          --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE PrintPuzzle
(
   @PuzzleID                      INT
   ,@EmptyValues                  INT
) AS

DECLARE @PuzzleSize               INT;

BEGIN

   SELECT
      @PuzzleSize = s.NumberOfBlocks
   FROM
      dbo.Puzzle AS p
         INNER JOIN
            dbo.Size AS s ON
               p.SizeID = s.SizeID
   WHERE
      p.PuzzleID = @PuzzleID;

   WITH output_grid AS
   (
      SELECT
         c.rn AS ColumnID
         ,r.rn AS RowID
      FROM
         dbo.GenerateRows (SQRT(@PuzzleSize)) AS c
            CROSS JOIN
               dbo.GenerateRows (SQRT(@PuzzleSize)) AS r
   )
   ,current_values AS
   (
      SELECT
         fb.BlockID
         ,fb.RowID
         ,fb.ColumnID
         ,fb.SquareValue
      FROM
         dbo.FillBlanks(@PuzzleID, @EmptyValues) AS fb
      UNION ALL
      SELECT
         sd.BlockID
         ,sd.RowID
         ,sd.ColumnID
         ,sd.SquareValue
      FROM
         dbo.SquareData AS sd
      WHERE
         sd.PuzzleID = @PuzzleID
   )
   ,pre_pivot AS
   (
      SELECT
         cv.BlockID
         ,cv.RowID
         ,cv.ColumnID
         ,cv.SquareValue
         ,ROW_NUMBER() OVER (ORDER BY dbo.GetBlockRow(@PuzzleSize, cv.BlockID), cv.RowID, dbo.GetBlockCol(@PuzzleSize, cv.BlockID), cv.ColumnID) - 1 AS rn
      FROM
         current_values AS cv
   )
   ,final_values AS
   (
      SELECT
         p.SquareValue
         ,((p.rn % @PuzzleSize) + 1) AS OutputColumnID
         ,((p.rn / @PuzzleSize) + 1) AS OutputRowID
      FROM
         pre_pivot AS p
   )
   SELECT
      AVG(CASE WHEN fv.OutputColumnID = 1 THEN fv.SquareValue ELSE NULL END) AS "1"
      ,AVG(CASE WHEN fv.OutputColumnID = 2 THEN fv.SquareValue ELSE NULL END) AS "2"
      ,AVG(CASE WHEN fv.OutputColumnID = 3 THEN fv.SquareValue ELSE NULL END) AS "3"
      ,AVG(CASE WHEN fv.OutputColumnID = 4 THEN fv.SquareValue ELSE NULL END) AS "4"
      ,AVG(CASE WHEN fv.OutputColumnID = 5 THEN fv.SquareValue ELSE NULL END) AS "5"
      ,AVG(CASE WHEN fv.OutputColumnID = 6 THEN fv.SquareValue ELSE NULL END) AS "6"
      ,AVG(CASE WHEN fv.OutputColumnID = 7 THEN fv.SquareValue ELSE NULL END) AS "7"
      ,AVG(CASE WHEN fv.OutputColumnID = 8 THEN fv.SquareValue ELSE NULL END) AS "8"
      ,AVG(CASE WHEN fv.OutputColumnID = 9 THEN fv.SquareValue ELSE NULL END) AS "9"
   FROM
      final_values AS fv
   GROUP BY
      fv.OutputRowID
   ORDER BY
      fv.OutputRowID;

END;
