using BusinessServices.Contract;
using DataAccess.Contract;
using Models;

namespace BusinessServices
{
    public class ExampleService : IExampleService
    {
        private readonly IExampleRepository exampleRepository;

        public ExampleService(IExampleRepository exampleRepository)
        {
            this.exampleRepository = exampleRepository;
        }

        public void CreatePhone()
        {
            exampleRepository.Insert(new Person()
            {
                Name = "X by 2 Tester",
            });
        }
    }
}
