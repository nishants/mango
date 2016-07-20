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
    }
    return {
        fieldsIn: function (object) {
            var fields = Object.keys(object);

            return fieldsOf("", object);
            return ["data", "data.item", "data.item.user", "data.item.result","data.name"];
        }
    };
}]);