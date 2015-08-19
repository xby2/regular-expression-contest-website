using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Contract
{
    public interface IRepository<T>
    {
        /// <summary>
        /// Returns a single entry (ie. sql row) from the dataset
        /// </summary>
        /// <param name="primaryKey">The primary key of the entry</param>
        T FindByPrimaryKey(object primaryKey);

        /// <summary>
        /// Returns a list of entries (ie. sql rows) frome the dataset that return true for the predicate
        /// </summary>
        /// <param name="predicate">Expression to evaluate each entry, return true to return the entry</param>
        /// <param name="checkInCache">(Optional) If true, the find will check the cache before querying the dataset</param>
        IQueryable<T> Find(Expression<Func<T, bool>> predicate, bool checkInCache = false);

        /// <summary>
        /// Adds the entry to the dataset
        /// </summary>
        /// <param name="newEntry">Entry to insert</param>
        /// <returns>The inserted row.  Including identity changes.</returns>
        T Insert(T newEntry);

        /// <summary>
        /// Updates the entry in the dataset
        /// </summary>
        /// <param name="updateEntry">Entry to update</param>
        /// <returns>The updated row</returns>
        T Update(T updateEntry);

        /// <summary>
        /// Deletes the entry from the dataset
        /// </summary>
        /// <param name="primaryKey">Primary key of the entry to delete</param>
        void Delete(object primaryKey);

        /// <summary>
        /// Inserts a list of entries into the dataset
        /// </summary>
        /// <param name="newEntries">A list of entries to be inserted</param>
        /// <returns>A list of the inserted entries including the identity values changed</returns>
        IList<T> InsertBatch(IList<T> newEntries);

        /// <summary>
        /// Updates all the entries that match findPredicate with updateTransformation
        /// Note: updateTransformation only updates the set fields, unset fields will not change the value in the dataset
        /// </summary>
        /// <param name="findPredicate">Return true to apply the transformation to the entry</param>
        /// <param name="updateTransformation">Return an object, only the set fields will be modified, unset fields will remain unchanged in the dataset</param>
        /// <returns>Number of records updated</returns>
        int UpdateBatch(Expression<Func<T, bool>> findPredicate, Expression<Func<T, T>> updateTransformation);

        /// <summary>
        /// Removes all entries that match findPredicate
        /// </summary>
        /// <param name="findPredicate">Return true to delete the entry</param>
        /// <returns>Number of records deleted</returns>
        int DeleteBatch(Expression<Func<T, bool>> findPredicate);

        /// <summary>
        /// Inserts, updates, or deletes an entry (ie. sql row) in the dataset depanding on the changes made to it.
        /// </summary>
        /// <param name="saveEntry">
        ///  Object to insert/update/delete from the dataset
        ///  Leave the primary key default if inserting a new row.
        ///  Set the item to null if deleting.
        /// </param>
        /// <param name="existingItemPrimaryKey">
        ///   (Use when updating/deleting) The primary key for the saveEntry
        ///   Do not include when inserting
        /// </param>
        /// <returns></returns>
        T Save(T saveEntry, object existingItemPrimaryKey = null);

        /// <summary>
        /// Inserts, updates, or deletes a subset in the dataset depanding on the changes made to it.
        /// </summary>
        /// <param name="saveList">
        ///   The modified list of data that originated from the result retired by pred.
        ///   Leave the primary key 0 if inserting a new row.
        /// </param>
        /// <param name="findPredicate">Select the previous list to be replacing.  Return true for an entry to include it in the selected list.</param>
        /// <returns></returns>
        List<T> SaveList(List<T> saveList, Expression<Func<T, bool>> findPredicate);
    }
}
