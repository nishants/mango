app.filter("fullFilePath", ["profilesService","schemaService",function(profilesService, schemaService){
    var pathTemplate = "<profiles-root>/<profile-name>/<relative-path>"
    return function(file){
        var relative = file ? file.path : null,
            rootDir  = schemaService.root;
        
        return !relative ? "" : pathTemplate.replace("<profiles-root>", schemaService.root)
                                            .replace("<profile-name>", profilesService.current.dir)
                                            .replace("<relative-path>", file.path);
    }
}]);
