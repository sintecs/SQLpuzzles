--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will move possible values to solved values when there is    --
-- only one possible location for a value in this column.                     --
--                                                                            --
-- Returns the count of cells that were solved                                --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SolveColumnSoloPossibles 
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   -- Find values where there is only one possible cell in this column and move 
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
   SELECT
      tsd.PuzzleID
      ,tsd.BlockID
      ,tsd.RowID
      ,tsd.ColumnID
      ,tsd.PossibleValue
      ,0
   FROM
      (
         SELECT
            COUNT(*) cnt
            ,dbo.GetBlockCol(@PuzzleSize, solo.BlockID) PuzzleBlockColumn
            ,solo.ColumnID
            ,solo.PossibleValue
            ,solo.PuzzleID
         FROM
            dbo.SquareDataPossible AS solo
         WHERE
            solo.PuzzleID = @PuzzleID
         GROUP BY
            dbo.GetBlockCol(@PuzzleSize, solo.BlockID)
            ,solo.PossibleValue
            ,solo.PuzzleID
            ,solo.ColumnID
      ) solo
         INNER JOIN
            SquareDataPossible AS tsd ON
               PuzzleBlockColumn = dbo.GetBlockCol(@PuzzleSize, tsd.BlockID)
               AND solo.ColumnID = tsd.ColumnID
               AND solo.PuzzleID = tsd.PuzzleID
               AND solo.PossibleValue = tsd.PossibleValue
               AND solo.cnt = 1
               AND NOT EXISTS 
               (
                  SELECT
                     NULL
                  FROM
                     dbo.SquareData AS sd
                  WHERE
                     tsd.PuzzleID = sd.PuzzleID
                     AND tsd.BlockID = sd.BlockID
                     AND tsd.RowID = sd.RowID
                     AND tsd.ColumnID = sd.ColumnID
               );

   SET @x = @@ROWCOUNT;

END

GO
