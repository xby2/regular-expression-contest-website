using Models;

namespace BusinessServices.Contract
{
    public interface IRegexValidationService
    {
        /// <summary>
        /// Validates all answers are correct for their corresponding puzzle.
        /// Assuming puzzles[i] corresponds to answers[i]
        /// </summary>
        /// <param name="puzzles">array of puzzles</param>
        /// <param name="answers">array of answers</param>
        /// <returns>Returns true if all answers' regex returns the goal string in puzzles</returns>
        bool ValidateRegex(Puzzle[] puzzles, Answer[] answers);
    }
}
