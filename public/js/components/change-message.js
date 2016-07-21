app.filter("message", [function(){

    var  format = function(message){
            return message.replace(/\[\]/g, "[*]");
    },
        insertMessage = function(change){
        return format("add :field with value :value, to all files".replace(":field", change.insert).replace(":value", change.value));
    },
        removeMessage = function(change){
            return format("remove :field from all files".replace(":field", change.remove));
        },
        renameMessage = function(change){
            return format("rename :field to :renameTo in all files".replace(":field", change.field).replace(":renameTo", change.renameTo));
        };

    return function(change){
        var insert = !!change.insert,
            rename = !!change.renameTo,
            remove = !!change.remove;

        return insert ? insertMessage(change) : (remove ? removeMessage(change) : renameMessage(change) ) ;

    }
}]);
