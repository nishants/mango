describe('projectService', function () {
    beforeEach(module('mango'));

    var service,
        projects = [{"name":"sample","path":"samples/profiles"}],
        backend;
    
    beforeEach(inject(function (_projectService_, $httpBackend) {
        backend = $httpBackend;
        backend.whenGET("/projects").respond(projects);
        service = _projectService_;
    }));

    it('should load projects', function (done) {
        service.all().then(function (actual) {
            expect(actual).toEqual(projects);
            expect(service.list).toEqual(projects);
            done();
        });
        backend.flush();
    });
    it('should select a project by name', function (done) {
        service.all().then(function (actual) {
            service.select(service.list[0].name).then(function () {
                expect(service.current).toEqual(service.list[0]);
                done();
            });
        });
        backend.flush();
    });
    it('create new project', function (done) {
        var path = "my-project-path",
            name = "my-project",
            expectedUrl = "/projects/:name/import".replace(":name", name);

        backend.expect('PUT', expectedUrl, {path: path}).respond(200, {name: name, path: path});

        service.create(name, "my-project-path").then(function (created) {
            expect(service.current.name).toEqual(created.name);
            done();
        });
        backend.flush();
    });
});