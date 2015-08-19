//Directive to attach an ng-model to ckeditor
define(["angular"], function () {

    var ckEditor = function() {
        return {
            require: "?ngModel",
            link: function(scope, element, attributes, controller) {
                //check if ckEditor already exists
                var toReplace = element[0].id;
                var editor = CKEDITOR.instances[toReplace];
                if (editor) {
                    //destory it if it has been loaded already
                    editor.destroy(true);
                }
                //replace the textarea with ckeditor
                var ck = CKEDITOR.replace(toReplace, {
                    toolbar: [
                        { name: "basicstyles", items: ["Bold", "Italic"] },
                        { name: "paragraph", items: ["NumberedList", "BulletedList"] },
                        { name: "colors", items: ["TextColor", "BGColor"] },
                    ],
                    resize_enabled: false,
                    width: "100%"
                    //TOOLBAR OPTIONS: http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar
                });

                if (!controller) return;

                ck.on("instanceReady", function() {
                    ck.setData(controller.$viewValue);
                });

                var updateModel = function () {
                    scope.$apply(function () {
                        controller.$setViewValue(ck.getData());
                    });
                };

                ck.on("pasteState", updateModel);
                ck.on("change", updateModel);
                ck.on("dataReady", updateModel);
                ck.on("key", updateModel);
                ck.on("paste", updateModel);
                ck.on("selectionChange", updateModel);

                ck.on("blur", function() {
                    controller.$setTouched();
                });

                controller.$render = function () {
                    ck.setData(controller.$viewValue);
                };

                element.bind("$destroy", function() {
                    ck.destroy();
                });

            }
        }
    };

    return ckEditor;
});
//SOURCE: http://stackoverflow.com/questions/11997246/bind-ckeditor-value-to-model-text-in-angularjs-and-rails
//        http://stackoverflow.com/questions/15483579/angularjs-ckeditor-directive-sometimes-fails-to-load-data-from-a-service
//        http://stackoverflow.com/questions/22957417/instance-of-ckeditor-already-exists
//        http://stackoverflow.com/questions/18917262/updating-textarea-value-with-ckeditor-content-in-angular-js