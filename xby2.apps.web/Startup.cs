using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(xby2.apps.web.Startup))]
namespace xby2.apps.web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
        }
    }
}
