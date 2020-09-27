--------------------------------------------------------------------------------
--                                                                            --
-- This function takes a PuzzleID and an integer value considered a "blank"   --
-- and returns all blocks/rows/columns that do not have a value for the       --
-- puzzle with the supplied "blank" value.                                    --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION FillBlanks
(
   @PuzzleID                      INT
   ,@BlankValue                   INT
) RETURNS @Output TABLE 
(
   PuzzleID                       INT
   ,BlockID                       INT
   ,RowID                         INT
   ,ColumnID                      INT
   ,SquareValue                   INT
) AS

BEGIN

   DECLARE @PuzzleSize            INT;
   
   SELECT
      @PuzzleSize = s.NumberOfBlocks
   FROM
      dbo.Puzzle AS p
         INNER JOIN
            dbo.Size AS s ON
               p.SizeID = s.SizeID
   WHERE
      p.PuzzleID = @PuzzleID;

   INSERT INTO @Output 
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
            blks.rn AS BlockID
            ,rws.rn AS RowID
            ,cols.rn AS ColumnID
         FROM
            dbo.GenerateRows(@PuzzleSize) blks
               CROSS JOIN
                  dbo.GenerateRows(SQRT(@PuzzleSize)) cols
               CROSS JOIN
                  dbo.GenerateRows(SQRT(@PuzzleSize)) rws
      ) blanks
   WHERE
      NOT EXISTS
         (
            SELECT
               NULL
            FROM
               dbo.SquareData AS sd
            WHERE
               sd.PuzzleID = @PuzzleID
               AND blanks.BlockID = sd.BlockID
               AND blanks.RowID = sd.RowID
               AND blanks.ColumnID = sd.ColumnID
         );

   RETURN;

END
