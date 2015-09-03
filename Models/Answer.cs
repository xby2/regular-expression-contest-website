using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Models
{
    public class Answer
    {
        public int Id { get; set; }
        public string Regex { get; set; }
        public string Substitute { get { return "$1"; } }
    }
}
