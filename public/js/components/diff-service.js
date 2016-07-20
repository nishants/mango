window.app.service("diffService", ["diffUtil",function(diffUtil){
    var copyOf = function (object) {
            return JSON.parse(JSON.stringify(object));
        },
        addChanges = function (parentField, changes) {

        },
        diff = function (object, currentObject, prefix) {
            var originalFields = [],
                currentFields = [];
            for (var fieldName in object) {
                originalFields.push(fieldName);
            }
            for (var fieldName in currentObject) {
                currentFields.push(fieldName);
            }

            var added = currentFields.filter(function (value) {
                    return -1 == originalFields.indexOf(value);
                }),
                missingNow = originalFields.filter(function (fieldName) {
                    return -1 == currentFields.indexOf(fieldName);
                }),
                wasRenamed   = function (fieldName) {
                    return added.filter(function (newFieldName) {
                        return currentObject[newFieldName] == object[fieldName];
                    }).length > 0;
                },
                renamedTo   = function (fieldName) {
                    return added.filter(function (newFieldName) {
                        return currentObject[newFieldName] == object[fieldName];
                    })[0];
                },
                newRenames = [],
                existWithDiffName = [],
                renamed = missingNow.filter(wasRenamed).map(function (fieldName) {
                    newRenames.push(renamedTo(fieldName));
                    existWithDiffName.push(fieldName);
                    return {field : prefix+fieldName, renameTo: renamedTo(fieldName)}
                });

            return added.filter(function (fieldName) {
                return newRenames.indexOf(fieldName) != -1;
            }).map(function (fieldName) {
                return {insert : prefix+fieldName, value: currentObject[fieldName]}
            }).concat(renamed).concat(missingNow.filter(function (fieldName) {
                return existWithDiffName.indexOf(fieldName) == -1;
            }).map(function (fieldName) {
                return {remove : prefix+fieldName}
            }));
        };

    var calculateDiff = function (objectOne, newObject) {
        var oldFields  = diffUtil.fieldsIn(objectOne),
            newFields  = diffUtil.fieldsIn(newObject),
            missing    = _.difference(oldFields, newFields),
            newFound   = _.difference(newFields, oldFields),
            missingValues = {},
            newValues     = {},
            renamed       = [];

        missing.forEach(function (missingField) {
            missingValues[missingField] = diffUtil.valueFor(missingField, objectOne);
        });

        newFound.forEach(function (newField) {
            newValues[newField] = diffUtil.valueFor(newField, newObject);
        });

        for(var missingField in missingValues){
            for(var newField in newValues){
                var isRenamed = missingValues[missingField] == newValues[newField];
                if(isRenamed){
                    renamed.push({field: missingField, renameTo: newField});
                    missing = _.filter(missing, function(field) { return field != missingField; });
                    newFound = _.filter(newFound, function(field) { return field != newField; });
                }
            }
        }

        for(var field in renamed){
            missing.splice(array.indexOf(5), 1);
        }
        return {};

    }

    return {
        create :function (original) {
            var base = copyOf(original);
            return {
                schemaDiff : function (modifiedTo) {
                    return {
                        modified: true,
                        changes:diff(base.data.item, modifiedTo.data.item, "data.item.")
                    }
                }
            }
        }
    };
}]);
