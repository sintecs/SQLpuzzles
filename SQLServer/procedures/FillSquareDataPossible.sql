--------------------------------------------------------------------------------
--                                                                            --
-- This function will fill the possibles table with values.  Each cell that   --
-- is not a "given" will have all possible valid values entered as possible.  --
-- This is the first procedure to call to setup a new puzzle for solving.     --
--                                                                            --
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE FillSquareDataPossible
(
   @PuzzleID                      INT
   ,@PuzzleSize                   INT
) AS
BEGIN

   INSERT INTO dbo.SquareDataPossible 
   (
      PuzzleID
      ,BlockID
      ,RowID
      ,ColumnID
      ,PossibleValue
   )
   SELECT
      @PuzzleID
      ,blanks.BlockID
      ,blanks.RowID
      ,blanks.ColumnID
      ,posvals.rn AS PosVal
   FROM
      dbo.GenerateRows(@PuzzleSize) AS posvals
         CROSS JOIN
            (
               SELECT
                  blanks.BlockID
                  ,blanks.RowID
                  ,blanks.ColumnID
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
                  ) AS sd
                     LEFT OUTER JOIN
                        (
                           SELECT
                              blks.rn AS BlockID
                              ,rws.rn AS RowID
                              ,cols.rn AS ColumnID
                           FROM
                              dbo.GenerateRows(@PuzzleSize) AS blks
                                 CROSS JOIN
                                    dbo.GenerateRows(SQRT(@PuzzleSize)) AS rws
                                 CROSS JOIN
                                    dbo.GenerateRows(SQRT(@PuzzleSize)) AS cols
                        ) AS blanks ON
                           blanks.BlockID = sd.BlockID
                           AND blanks.RowID = sd.RowID
                           AND blanks.ColumnID = sd.ColumnID
               WHERE
                  sd.SquareValue IS NULL
            ) AS blanks;

END

GO
