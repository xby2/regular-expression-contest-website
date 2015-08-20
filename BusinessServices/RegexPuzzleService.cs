using BusinessServices.Contract;
using DataAccess.Contract;
using Models;
using System.Collections.Generic;

namespace BusinessServices
{
    public class RegexPuzzleservice : IRegexPuzzleService
    {
        private readonly IRegexPuzzleRepository regexPuzzleRepository;

        public RegexPuzzleservice(IRegexPuzzleRepository regexPuzzleRepository)
        {
            this.regexPuzzleRepository = regexPuzzleRepository;
        }

        public List<Puzzle> GetPuzzle()
        {
            return regexPuzzleRepository.GetRegexPuzzle();
        }

        public string SubmitPuzzleResult(PuzzleResult result)
        {
            return regexPuzzleRepository.SubmitPuzzleResult(result);
        }

 
    }
}
