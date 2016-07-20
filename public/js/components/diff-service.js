window.app.service("diffService", [function(){
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
                removed = missingNow.filter(function (fieldName) {
                    var isObject    = !typeof(object[fieldName]) == "object";

                    return isObject;
                }).map(function (fieldName) {
                    return {remove : prefix+fieldName}
                }),
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
