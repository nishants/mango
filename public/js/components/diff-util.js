window.app.service("diffUtil", [function(){

    var fieldsOf = function (parentId, object) {
        var result = {},
            fields = Object.keys(object);

        for(var i = 0 ; i < fields.length; i++){
            var fieldName = fields[i],
                value = object[fieldName],
                isArray  = value instanceof Array,
                isObject = !isArray && (typeof(value) == "object"),
                fieldId = parentId + fieldName + ".";
            result[fieldId.slice(0,-1)] = value;
            if(isObject && value){
                _.assign(result, fieldsOf(fieldId, value));
            }
        }
        return result;
    }
    return {
        fieldsIn: function (object) {
            return fieldsOf("", object);
        }
    };
}]);
