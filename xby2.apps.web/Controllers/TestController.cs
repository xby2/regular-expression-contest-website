using BusinessServices.Contract;
using System.Web.Http;

namespace xby2.apps.web.Controllers
{
    public class TestController : ApiController
    {
        private readonly IExampleService exampleService;

        public TestController(IExampleService exampleService)
        {
            this.exampleService = exampleService;
        }

        // GET api/<controller>/get
        public string Get()
        {
            return "value";
        }

        // POST api/<controller>/PostPhone
        public object PostPhone()
        {
            exampleService.CreatePhone();

            return "Success";
        }

        // PUT api/<controller>/put/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/delete/5
        public void Delete(int id)
        {
        }
    }
}