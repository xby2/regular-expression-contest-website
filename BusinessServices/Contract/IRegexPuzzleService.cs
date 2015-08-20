using Models;
using System.Collections.Generic;

namespace BusinessServices.Contract
{
    public interface IRegexPuzzleService
    {
        List<Puzzle> GetPuzzle();
        string SubmitPuzzleResult(PuzzleResult result);
    }
}
