window.app.service("diffUtil", [function(){

    var fieldsOf = function (parentId, object) {
        var result = [],
            fields = Object.keys(object);

        for(var i = 0 ; i < fields.length; i++){
            var fieldName = fields[i],
                value = object[fieldName],
                isArray  = value instanceof Array,
                isObject = !isArray && (typeof(value) == "object"),
                fieldId = parentId + fieldName + ".";
            result.push(fieldId.slice(0,-1));
            if(isObject && value){
                result = result.concat(fieldsOf(fieldId, value));
            }
        }
        return result;
    }, readValue = function (suffix, object) {
        var fields          = suffix.split("."),
            currentField    = fields[0],
            nextFieldId     = suffix.replace(currentField + ".", ""),
            isTerminal = fields.length == 1;
        return isTerminal ? object[currentField] : readValue(nextFieldId, object[currentField]);
    };
    return {
        fieldsIn: function (object) {
            return fieldsOf("", object);
        },
        valueFor: function (fieldId, object) {
            return readValue(fieldId, object);
            return {
                "user": {"id": "user-one"},
                "result": "some-message"
            };
        }
    };
}]);
