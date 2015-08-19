define([], function() {

    var baseRepository = function(url) {
        var self = this;
        self.controllerUrl = url;
    };

    baseRepository.prototype.Get = function(methodName, urlParams) {
        urlParams = urlParams || 0;
        var self = this;
        return $.ajax({
            type: "GET",
            url: self.controllerUrl +
                "/" + methodName +
                "?" + $.param(urlParams),
            contentType: "application/json"
        });
    };

    baseRepository.prototype.GetByPK = function(methodName, primaryKey, urlParams) {
        urlParams = urlParams || 0;
        var self = this;
        return $.ajax({
            type: "GET",
            url: self.controllerUrl +
                "/" + methodName +
                "/" + primaryKey +
                "?" + $.param(urlParams),
            contentType: "application/json"
        });
    };

    baseRepository.prototype.Put = function(methodName, body, urlParams) {
        urlParams = urlParams || 0;
        var self = this;
        return $.ajax({
            type: "PUT",
            url: self.controllerUrl +
                "/" + methodName +
                "/" + $.param(urlParams),
            data: JSON.stringify(body),
            contentType: "application/json"
        });
    };

    baseRepository.prototype.Post = function(methodName, body, urlParams) {
        urlParams = urlParams || 0;
        var self = this;
        return $.ajax({
            type: "POST",
            url: self.controllerUrl +
                "/" + methodName +
                "?" + $.param(urlParams),
            data: JSON.stringify(body),
            contentType: "application/json"
        });
    };

    baseRepository.prototype.Delete = function (methodName, primaryKey, urlParams) {
        urlParams = urlParams || 0;
        var self = this;
        return $.ajax({
            type: "DELETE",
            url: self.controllerUrl +
                "/" + methodName +
                "/" + primaryKey +
                "?" + $.param(urlParams),
            contentType: "application/json"
        });
    };

    return baseRepository;
});