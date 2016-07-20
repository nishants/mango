window.app.service("filterService", [function () {
    var matches =function (text, key) {
            return new RegExp(key, "i").test(text);
        },
        filter = function (key, items, config) {
            var result = [];
            items.forEach(function (item) {
                var include = false;
                config.fields.forEach(function (field) {
                    include = include || matches(item[field], key);
                });
                include && result.push(item);
            });
            return result;
        };
    var profilesConfig = {
        fields: ["name", "description"]
    };
    var filesConfig = {
        fields: ["name", "path"]
    };
    return {
        filterProfiles : function (key, profiles) {
            return filter(key, profiles, profilesConfig)
        },
        filterFiles   : function (key, files) {
            return filter(key, files, filesConfig)
        }
    };
}]);
