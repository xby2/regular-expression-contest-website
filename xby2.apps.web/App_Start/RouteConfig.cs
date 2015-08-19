using System.Web.Mvc;
using System.Web.Routing;

namespace xby2.apps.web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{filename}",
                defaults: new { controller = "StartSpa", action = "Index", filename = UrlParameter.Optional }
            );
        }
    }
}
