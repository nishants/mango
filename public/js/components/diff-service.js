window.app.service("diffService", ["diffUtil",function(diffUtil){
    var copyOf = function (object) {
            return JSON.parse(JSON.stringify(object));
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
                    var tokens = newField.split(".");
                    renamed.push({field: missingField, renameTo: tokens[tokens.length -1]});
                    missing = _.filter(missing, function(field) { return field != missingField; });
                    newFound = _.filter(newFound, function(field) { return field != newField; });
                }
            }
        }

        var difference = newFound.map(function (newField) {
            return {insert: newField, value: diffUtil.valueFor(newField, newObject)};
        }).concat(missing.map(function (missingField) {
            return {remove: missingField};
        })).concat(renamed);
        return difference;

    }

    return {
        create :function (original) {
            var base = copyOf(original);
            return {
                schemaDiff : function (modifiedTo) {
                    return {
                        modified: true,
                        changes:calculateDiff(base, modifiedTo)
                    }
                }
            }
        }
    };
}]);
