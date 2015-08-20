using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class PuzzleResult
    {
        public DateTime DateSubmitted { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public List<string> RegexAnswers { get; set; }
        public string ResultFile { get { return Email + ".xml"; } }
    }
}
