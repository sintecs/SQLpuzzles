--------------------------------------------------------------------------------
--                                                                            --
-- This function will return which row of the puzzle where this block         --
-- resides.  This function assumes a square puzzle of cols.                   --
-- For a puzzle with 9 blocks, blocks numbered 1, 4 and 7 are in the first    --
-- column, 2, 5 and 8  in are in the second column and 3, 6 and 9 are in the  --
-- third column.                                                              --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION GetBlockCol
(
   @PuzzleSize                    INT
   ,@BlockID                      INT
) RETURNS INT AS
BEGIN

   DECLARE @BlockCol              INT;

   SELECT
      @BlockCol = CASE
                     WHEN (@BlockID % CONVERT(INT, SQRT(@PuzzleSize))) = 0
                     THEN SQRT(@PuzzleSize)
                     ELSE @BlockID % CONVERT(INT, SQRT(@PuzzleSize))
                  END;

   RETURN @BlockCol;
END

GO
