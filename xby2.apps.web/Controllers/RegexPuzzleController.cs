using BusinessServices.Contract;
using Models;
using System;
using System.Collections.Generic;
using System.Web.Http;

namespace xby2.apps.web.Controllers
{

    public class RegexPuzzleController : ApiController
    {
        private readonly IRegexPuzzleService regexPuzzleService;

        public RegexPuzzleController(IRegexPuzzleService regexPuzzleService)
        {
            this.regexPuzzleService = regexPuzzleService;
        }

        // GET api/<controller>/get
        public List<Puzzle> Get()
        {

            regexPuzzleService.SubmitPuzzleResult(new PuzzleResult
            {
                DateSubmitted = DateTime.Now,
                Name = "Bill sun",
                Email = "bsun@xby2.com",
                RegexAnswers = new List<String>
                {
                    "asfasdf",
                    ""
                }

            });
            return regexPuzzleService.GetPuzzle();
           
        }

        [HttpPost]
        public bool ValidateRegex([FromBody]PuzzleAnswerDTO answers)
        {
            return regexPuzzleService.ValidateRegex(answers);
        }
    }
}