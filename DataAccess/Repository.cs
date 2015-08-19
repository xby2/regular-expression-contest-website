using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using EntityFramework.Caching;
using EntityFramework.Extensions;
using DataAccess.Contract;
using Models.Utilities;

namespace DataAccess
{
    public abstract class Repository<T> : IRepository<T> where T : class
    {
        ApplicationContext context { get; set; }

        public Repository(ApplicationContext applicationContext) {

            context = applicationContext;
        }

        public T FindByPrimaryKey(object primaryKey)
        {
            throw new NotImplementedException();
        }

        public IQueryable<T> Find(Expression<Func<T, bool>> predicate, bool checkInCache = false)
        {
            throw new NotImplementedException();
        }

        public T Insert(T newEntry)
        {
            throw new NotImplementedException();
        }

        public T Update(T updateEntry)
        {
            throw new NotImplementedException();
        }

        public void Delete(object primaryKey)
        {
            throw new NotImplementedException();
        }

        public IList<T> InsertBatch(IList<T> newEntries)
        {
            throw new NotImplementedException();
        }

        public int UpdateBatch(Expression<Func<T, bool>> findPredicate, Expression<Func<T, T>> updateTransformation)
        {
            throw new NotImplementedException();
        }

        public int DeleteBatch(Expression<Func<T, bool>> findPredicate)
        {
            throw new NotImplementedException();
        }

        public T Save(T saveEntry, object existingItemPrimaryKey = null)
        {
            throw new NotImplementedException();
        }

        public List<T> SaveList(List<T> saveList, Expression<Func<T, bool>> findPredicate)
        {
            throw new NotImplementedException();
        }
    }
}
