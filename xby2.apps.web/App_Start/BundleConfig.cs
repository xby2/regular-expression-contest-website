using System.Web.Optimization;

namespace xby2.apps.web
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            bundles.Add(
                new ScriptBundle("~/bundles/require")
                .Include("~/Scripts/require.js",
                "~/AngularApp/app/RequireConfig.js"));

            bundles.Add(
                new ScriptBundle("~/bundles/angular")
                    .Include("~/Scripts/angular.js",
                    "~/Scripts/angular-route.js",
                    "~/Scripts/angular-resource.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new ScriptBundle("~/bundles/ckeditor").Include(
                        "~/Scripts/ckeditor/ckeditor.js"));

            bundles.Add(new StyleBundle("~/bundles/css")
                .Include("~/Content/css/*.css",
                    "~/Content/font-awesome.min.css"));
        }
    }
}
