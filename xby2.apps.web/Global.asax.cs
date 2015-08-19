using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Autofac.Integration.WebApi;
using Autofac.Integration.Mvc;

namespace xby2.apps.web
{
    public class MvcApplication : HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            RegisterIoc();
        }

        protected void RegisterIoc() {

            var container = DependencyConfig.GenerateIocContainer();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container)); 
            GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container); 
        }
 
    }
}
