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
            return regexPuzzleService.GetPuzzle();
        }

        [HttpPost]
        public bool ValidateRegex([FromBody]PuzzleAnswerDTO answers)
        {
            return regexPuzzleService.ValidateRegex(answers);
        }
    }
}