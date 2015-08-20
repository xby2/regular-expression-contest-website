define(["app/Repository/BaseRepository"], function (base) {

    var baseRepository = new base("api/RegexValidation");

    var regexValidationRepository = function () {

    };

    //Returns true if all answers to the puzzles are correct
    //@puzzlesAnswers expected to be similar form to PuzzlesAnwers
    regexValidationRepository.prototype.validateRegex = function(puzzlesAnswers) {
        return baseRepository.Put("ValidateRegex", puzzlesAnswers)
    }

});