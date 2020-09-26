--------------------------------------------------------------------------------
--                                                                            --
-- This procedure will remove possible values when there is a known value     --
-- (given or found) already in this row in another block                      --
--                                                                            --
-- Returns how many values were removed from all cells due to knowns          --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE RemoveRowKnowns
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
   ,@x                            INT OUT
) AS
BEGIN

   DELETE
   FROM 
      dbo.SquareDataPossible
   WHERE
      SquareDataPossible.PuzzleID = @PuzzleID
      AND EXISTS
      (
         SELECT
            NULL
         FROM
            dbo.SquareData AS taken_vals
         WHERE
            taken_vals.PuzzleID = SquareDataPossible.PuzzleID
            AND dbo.GetBlockRow(@PuzzleSize, SquareDataPossible.BlockID) = dbo.GetBlockRow(@PuzzleSize, taken_vals.BlockID)
            AND taken_vals.RowID = SquareDataPossible.RowID
            AND taken_vals.SquareValue IS NOT NULL
            AND taken_vals.SquareValue = SquareDataPossible.PossibleValue
      );

   SET @x = @@ROWCOUNT

END

GO
