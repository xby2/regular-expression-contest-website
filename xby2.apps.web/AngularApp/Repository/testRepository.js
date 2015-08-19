define(["Repository/BaseRepository"], function(base) {

    var baseRepository = new base("api/Test");

    var testRepository = function() {

    };

    testRepository.prototype.Get = function() {
        return baseRepository.Get("Get");
    };

    testRepository.prototype.GetByPK = function(primaryKey) {
        return baseRepository.GetByPK("Get", primaryKey);
    };

    testRepository.prototype.Post = function() {
        return baseRepository.Post("PostPhone");
    };
    return new testRepository();
});