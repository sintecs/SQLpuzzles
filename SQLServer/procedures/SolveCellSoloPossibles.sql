--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will move possible values to solved values when there is    --
-- only one possible value for a cell.                                        --
--                                                                            --
-- Returns how many solo cells were solved                                    --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SolveCellSoloPossibles
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   -- Find cells where there is only one possible value in the cell and move 
   -- those cells into SquareData as a final solution value
   INSERT INTO dbo.SquareData
   (
      PuzzleID
      ,BlockID
      ,RowID
      ,ColumnID
      ,SquareValue
      ,InitialValue
   )
   (
      SELECT
         @PuzzleID
         ,tsd.BlockID
         ,tsd.RowID
         ,tsd.ColumnID
         ,tsd.PossibleValue
         ,0
      FROM
         dbo.SquareDataPossible tsd
            INNER JOIN
               (
                  SELECT
                     COUNT(*) cnt
                     ,BlockID
                     ,RowID
                     ,ColumnID
                     ,PuzzleID
                  FROM
                     dbo.SquareDataPossible AS solo
                  WHERE
                     solo.PuzzleID = @PuzzleID
                  GROUP BY
                     BlockID
                     ,RowID
                     ,ColumnID
                     ,PuzzleID
               ) solo ON
                  tsd.PuzzleID = solo.PuzzleID
                  AND tsd.PuzzleID = @PuzzleID
                  AND tsd.RowID = solo.RowID
                  AND tsd.ColumnID = solo.ColumnID
                  AND tsd.BlockID = solo.BlockID
                  AND solo.cnt = 1
      WHERE
         NOT EXISTS
         (
            SELECT
               NULL
            FROM
               dbo.SquareData sd
            WHERE
               tsd.PuzzleID = sd.PuzzleID
               AND tsd.BlockID = sd.BlockID
               AND tsd.RowID = sd.RowID
               AND tsd.ColumnID = sd.ColumnID
         )
   );

   SET @x = @@ROWCOUNT;

END

GO
