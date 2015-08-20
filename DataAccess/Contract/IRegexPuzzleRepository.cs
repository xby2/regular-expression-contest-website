using Models;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Contract
{
    public interface IRegexPuzzleRepository {
        List<Puzzle> GetRegexPuzzle();
        string SubmitPuzzleResult(PuzzleResult result);
    }
}
