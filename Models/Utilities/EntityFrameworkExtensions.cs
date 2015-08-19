using System;
using System.ComponentModel;
using System.Linq;
using System.Collections.Generic;

namespace Models.Utilities
{
    public static class EntityFrameworkExtensions
    {
        /// <summary>
        /// Copies the values of the properties of src to dest.  Some logic is used to ignore certain fields.
        /// </summary>
        /// <param name="dest"></param>
        /// <param name="src"></param>
        /// <param name="foreignKeys"></param>
        /// <param name="ignoreEfModels"></param>
        public static void CopyProperties(this object dest, object src, List<string> foreignKeys = null, List<string> ignoreEfModels = null)
        {
            var srcProperties = TypeDescriptor.GetProperties(src);
            foreach (PropertyDescriptor item in TypeDescriptor.GetProperties(dest))
            {
                //Skip if property if Entity Framework Models
                if (ignoreEfModels != null &&
                    ignoreEfModels.Contains(item.Name))
                {
                    continue;
                }

                //Skip if source does not have value of destination
                if (!srcProperties.Contains(item))
                {
                    continue;
                }

                //Get source and destination values
                var destValue = item.GetValue(dest);
                var srcValue = item.GetValue(src);

                //Skip if foreign keys are the same since EF will think we're trying to change the FK,
                // even when the values are equal
                var bothValuesAreNull = (destValue == null && srcValue == null);
                var valuesAreEqual = (bothValuesAreNull || 
                    (destValue != null && destValue.Equals(srcValue)));
                if (foreignKeys != null && foreignKeys.Contains(item.Name) && valuesAreEqual)
                {
                    continue;
                }

                //If item exists for src, copy value over
                item.SetValue(dest, srcValue);
            }
        }

        /// <summary>
        /// Return true if left and right have the same properties and same values for those properties. 
        /// (Ignoring any properties named in ignoreProperties)
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <param name="ignoreProperties">Variable names of the parameters to ignore in the check</param>
        public static bool ArePropertiesEqual(this object left, object right, List<string> ignoreProperties = null)
        {
            var leftProperties = TypeDescriptor.GetProperties(left);
            foreach (PropertyDescriptor item in TypeDescriptor.GetProperties(right))
            {
                //Skip if property if it is in the ignore list
                if (ignoreProperties != null &&
                    ignoreProperties.Contains(item.Name))
                {
                    continue;
                }

                //If left does not have the property right has, return false
                if (!leftProperties.Contains(item))
                {
                    return false;
                }

                //Get the left and right values
                var leftValue = item.GetValue(left);
                var rightValue = item.GetValue(right);

                //Skip if foreign keys are the same since EF will think we're trying to change the FK,
                // even when the values are equal
                var bothValuesAreNull = (leftValue == null && rightValue == null);
                var valuesAreEqual = (bothValuesAreNull ||
                    (leftValue != null && leftValue.Equals(rightValue)));

                if (!valuesAreEqual) return false;
            }
            return true;
        }
    }
}