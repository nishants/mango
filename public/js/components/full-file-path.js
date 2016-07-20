app.filter("fullFilePath", ["profilesService","schemaService",function(profilesService, schemaService){
    var pathTemplate = "<profile-name><relative-path>"
    return function(file){
        var relative = file ? file.path : null;

        return !relative ? "" : pathTemplate.replace("<profile-name>", profilesService.current.dir)
                                            .replace("<relative-path>", file.path);
    }
}]);
