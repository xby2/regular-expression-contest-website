using DataAccess.Contract;
using Models;

namespace DataAccess
{
    public class ExampleRepository : Repository<Person>, IExampleRepository
    {
        public ExampleRepository(ApplicationContext context) :
            base(context)
        {
        }
    }
}
