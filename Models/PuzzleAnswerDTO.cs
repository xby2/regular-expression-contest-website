using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class PuzzleAnswerDTO
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public List<Answer> Answer { get; set; }
    }
}
