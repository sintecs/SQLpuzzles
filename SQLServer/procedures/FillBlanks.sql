--------------------------------------------------------------------------------
--                                                                            --
-- This procedure takes a PuzzleID and an integer value considered a "blank"  --
-- and populates all blocks/rows/columns that were not a given for the puzzle --
-- with the "blank" value.  Givens are the initial values in the puzzle that  --
-- are filled in before starting.                                             --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE FillBlanks
(
   @PuzzleID                      INT
   ,@BlankValue                   INT
) AS

DECLARE
   @PuzzleSize                    INT;

BEGIN

   SELECT
      @PuzzleSize = s.NumberOfBlocks
   FROM
      dbo.Puzzle AS p
         INNER JOIN
            dbo.Size AS s ON
               p.SizeID = s.SizeID
               AND p.PuzzleID = @PuzzleID;

   INSERT INTO dbo.SquareData 
   (
      PuzzleID
      ,BlockID
      ,RowID
      ,ColumnID
      ,SquareValue
   )
   SELECT
      @PuzzleID
      ,blanks.BlockID
      ,blanks.RowID
      ,blanks.ColumnID
      ,@BlankValue
   FROM
      (
         SELECT
            sd.BlockID
            ,sd.RowID
            ,sd.ColumnID
            ,sd.SquareValue
         FROM
            dbo.SquareData AS sd
         WHERE
            sd.PuzzleID = @PuzzleID
            AND sd.InitialValue IS NULL
      ) sd
         LEFT OUTER JOIN
            (
               SELECT
                  blks.rn AS BlockID
                  ,rws.rn AS RowID
                  ,cols.rn AS ColumnID
               FROM
                  dbo.GenerateRows(SQRT(@PuzzleSize)) cols
                     CROSS JOIN
                        dbo.GenerateRows(@PuzzleSize) blks
                     CROSS JOIN
                        dbo.GenerateRows(SQRT(@PuzzleSize)) rws
            ) blanks ON
               blanks.BlockID = sd.BlockID
               AND blanks.RowID = sd.RowID
               AND blanks.ColumnID = sd.ColumnID

END

GO
