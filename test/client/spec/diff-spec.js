describe("diff.js", function () {
    var jsonData = {},
        diff = undefined;

    beforeEach(function () {
        diff = Diff.create(jsonData);
    });

    it("should find diff for primary types", function () {
        expect(diff).not.toBeNull();
    });
});
