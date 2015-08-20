using DataAccess.Contract;
using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Xml.Serialization;

namespace DataAccess
{
    public class RegexPuzzleRepository : IRegexPuzzleRepository
    {

        private string puzzleFile { get; set; }
        private string puzzleResultFolder { get; set; }
        public RegexPuzzleRepository()
        {
            // Get the folder/file configuration from web.config
            this.puzzleFile = ConfigurationManager.AppSettings["PuzzleFile"];
            this.puzzleResultFolder = ConfigurationManager.AppSettings["ResultFolder"];

        }
        /// <summary>
        ///  Read Deseralized file from file
        /// </summary>
        /// <returns></returns>
        public List<Puzzle> GetRegexPuzzle()
        {
            var puzzleGroups = new List<Puzzle>();
            // Write the byte array to the other FileStream. 
            using (FileStream puzzleFileStream = new FileStream(puzzleFile, FileMode.Open, FileAccess.Read))
            {
                var serializer = new XmlSerializer(puzzleGroups.GetType());
                var deseralizedPuzzle = serializer.Deserialize(puzzleFileStream);
                return (List<Puzzle>)deseralizedPuzzle;
            }
        }

        /// <summary>
        ///  Save Sealized result in a file
        /// </summary>
        /// <param name="result"></param>
        /// <returns></returns>
        public string SubmitPuzzleResult(PuzzleResult result)
        {

            if (string.IsNullOrEmpty(result.Email)) throw new Exception("unable to submit result, email not provided");
            var submitfile = Path.Combine(puzzleResultFolder, result.ResultFile);
            if (File.Exists(submitfile)) throw new Exception("Email " + result.Email + " is already submitted, can not submit again");

            // Write the byte array to the other FileStream. 
            using (FileStream puzzleResultFileStream = new FileStream(submitfile, FileMode.OpenOrCreate, FileAccess.ReadWrite))
            {
                var serializer = new XmlSerializer(result.GetType());
                serializer.Serialize(puzzleResultFileStream, result);
            }
            return submitfile;
        }
    }
}
 