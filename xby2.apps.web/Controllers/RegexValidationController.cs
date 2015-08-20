using BusinessServices.Contract;
using System.Web.Http;

namespace xby2.apps.web.Controllers
{

    public class PuzzlesAnswers
    {
        public Answer[] Answers;
        public Puzzle[] Puzzles;
    }

    public class RegexValidationController : ApiController { 
    

        private readonly IRegexValidationService regexValidationService;

        public RegexValidationController(IRegexValidationService regexValidationService)
        {
            this.regexValidationService = regexValidationService;
        }

        public bool ValidateRegex([FromBody]PuzzlesAnswers dataTransferObject)
        {
            Answer[] answers = dataTransferObject.Answers;
            Puzzle[] puzzles = dataTransferObject.Puzzles;

            return regexValidationService.ValidateRegex(puzzles, answers);
        }
    }
}
