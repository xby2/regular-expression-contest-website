using Autofac;
using Autofac.Integration.WebApi;
using Autofac.Integration.Mvc;
using Autofac.Extras.DynamicProxy2;
using DataAccess.Contract;
using BusinessServices.Contract;
using DataAccess;

namespace xby2.apps.web
{
    public class DependencyConfig
    {
        // This is the Inversion Of Control (IoC) container
        // Example referencing http://chandermani.blogspot.com/2012/12/integrate-mvc-webapi-with-autofac-in-5.html
        public static IContainer GenerateIocContainer()
        {
            var builder = new ContainerBuilder();

            builder.RegisterControllers(typeof(MvcApplication).Assembly);
            builder.RegisterApiControllers(typeof(MvcApplication).Assembly);

            // Scan an assembly for components
            // Data access
            builder.RegisterAssemblyTypes(typeof(IExampleRepository).Assembly)
                .AsImplementedInterfaces();

            // Business logic
            builder.RegisterAssemblyTypes(typeof(IExampleService).Assembly)
                .AsImplementedInterfaces();
 
            //Set application context to open up for each request
            builder.RegisterType<ApplicationContext>()
                .As<ApplicationContext>()
                .InstancePerRequest();

            var container = builder.Build();
            return container;
        }
    }
}
