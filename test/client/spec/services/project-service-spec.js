describe('projectService', function () {
    beforeEach(module('mango'));

    var service,
        projects = [{"name":"sample","path":"samples/profiles"}],
        backend;
    
    beforeEach(inject(function (_projectService_, $httpBackend) {
        service = _projectService_;
        backend = $httpBackend;
    }));

    it('should load projects', function (done) {
        backend.whenGET("/projects").respond(projects);
        service.all().then(function (actual) {
            expect(actual).toEqual(projects);
            expect(service.list).toEqual(projects);
            done();
        });
        backend.flush();
    });
});