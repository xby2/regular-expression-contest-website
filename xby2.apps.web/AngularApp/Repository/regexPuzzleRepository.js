define(["Repository/BaseRepository"], function (BaseRepository) {

    var baseRepository = new BaseRepository("api/RegexPuzzle");

    var regexPuzzleRepository = function () {

    };

    //Returns an array of puzzles
    //@returns {array of puzzle objects} - Regex puzzle
    regexPuzzleRepository.prototype.get = function () {
        return baseRepository.Get("Get");
    }


    //Returns true if all answers to the puzzles are correct
    //@puzzlesAnswers {array of answers} - expected to be similar form to PuzzlesAnwers
    //  answer object 
    //      puzzleId {int}
    //      regex {string}
    //@name {string} - name of the user
    //@email {string} - valid email of the user
    regexPuzzleRepository.prototype.validateRegex = function (puzzlesAnswers, name, email) {
        var data = {
            Answers: puzzlesAnswers,
            Name: name,
            Email: email
        };
        return baseRepository.Post("ValidateRegex", data);
    }

    return new regexPuzzleRepository;
});