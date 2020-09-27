--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will move possible values to solved values when there is    --
-- only one possible location for a value in this block.                      --
--                                                                            --
-- Returns the count of cells that were solved                                --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SolveBlockSoloPossibles
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   -- Find values where there is only one possible cell in this block and move 
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
                  ,PossibleValue
                  ,PuzzleID
               FROM
                  dbo.SquareDataPossible AS solo
               WHERE
                  solo.PuzzleID = @PuzzleID
               GROUP BY
                  BlockID
                  ,PossibleValue
                  ,PuzzleID
            ) solo ON
               tsd.PuzzleID = solo.PuzzleID
               AND tsd.PuzzleID = @PuzzleID
               AND tsd.BlockID = solo.BlockID
               AND tsd.PossibleValue = solo.PossibleValue
               AND solo.cnt = 1
   WHERE
      NOT EXISTS
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
   
   SELECT @x = @@ROWCOUNT;

END

GO
