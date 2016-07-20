app.filter("fullFilePath", ["profilesService","fileService",function(profilesService, fileService){
    var pathTemplate = "<profile-name><relative-path>"
    return function(file){
        var relative = file ? file.path : null;

        return !relative ? "" : pathTemplate.replace("<profile-name>", profilesService.current.dir)
                                            .replace("<relative-path>", file.path);
    }
}]);
