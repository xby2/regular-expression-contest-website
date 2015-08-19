using Models;
using System.Collections.Generic;
    
namespace DataAccess
{
    
    public partial class ApplicationContext
    {
        public ApplicationContext()
        {
            
        }

        public virtual List<Person> People { get; set; }
    }
}
