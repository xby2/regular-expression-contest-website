using BusinessServices.Contract;
using DataAccess.Contract;
using Models;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Linq;
using System;

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

        public bool ValidateRegex(PuzzleAnswerDTO puzzleAnswers)
        {

            // Get the puzzles from the repository
            var puzzleDictionary = regexPuzzleRepository.GetRegexPuzzle().ToDictionary(k => k.Id, v => v);


            foreach (var p in puzzleAnswers.Answer) {
                if (!puzzleDictionary.ContainsKey(p.Id)) throw new Exception("Unable to find the puzzle with the id " + p.Id);
                var puzzle = puzzleDictionary[p.Id];

                MatchCollection mc = Regex.Matches(puzzle.Problem,p.Regex, RegexOptions.Multiline);

                var result = "";
                foreach (Match m in mc)
                {
                    result += m.Value;
                    result += Environment.NewLine;
                }

                // Replace \n with \r\n since the puzzle file is using \n for newline where as matched
                // regex uses \r\n
                var goalwithNewline = puzzle.Goal.Replace("\n", Environment.NewLine);

                if (result != goalwithNewline) return false;

            }

            // Submit result
            regexPuzzleRepository.SubmitPuzzleResult(new PuzzleResult {
                Name = puzzleAnswers.Name,
                DateSubmitted = DateTime.Now,
                Email = puzzleAnswers.Email,
                RegexAnswers = string.Join(Environment.NewLine, puzzleAnswers.Answer.Select(a => a.Regex).ToList())
            });

            return true;
        }

    }
}
