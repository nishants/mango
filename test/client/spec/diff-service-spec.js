describe('diffService', function () {
    beforeEach(module('mango'));

    var service,
        controller,
        getRenames = function (updates) {
            return updates.filter(function (update) {
                return !!update.renameTo
            });
        },
        getInserts = function (updates) {
            return updates.filter(function (update) {
                return !!update.insert
            });
        },
        getRemoved = function (updates) {
            return updates.filter(function (update) {
                return !!update.remove
            });
        },
        service;

    beforeEach(inject(function (_diffService_) {
        service = _diffService_;
    }));

    it('should find insertions', function () {

        var original = {
                "data": {
                    "item": {
                        "status": {"name": "one"},
                        "message": "some-message"
                    }
                }
            },
            modifiedTo = {
                "data": {
                    "flag" : false,
                    "item": {
                        "new-field": {"name": "one"},
                        "status": {"name": "one"},
                        "message": "some-message"
                    }
                }
            },
            diff = service.create(original),
            update = diff.schemaDiff(modifiedTo);

        expect(update.modified).toBe(true);

        var inserted = getInserts(update.changes);

        expect(inserted.length).toBe(2);
        expect(inserted).toEqual([{insert: "data.flag", value: false},{insert: "data.item.new-field", value: {"name": "one"}}]);
    });
    it('should find deletions', function () {

        var original = {
                "flag" : false,
                "data": {
                    "item": {
                        "status": {"name": "one"},
                        "message": "some-message"
                    }
                }
            },
            modifiedTo = {
                "data": {
                    "item": {
                        "message": "some-message"
                    }
                }
            }            ,
            diff = service.create(original),
            update = diff.schemaDiff(modifiedTo);

        expect(update.modified).toBe(true);

        var deleted = getRemoved(update.changes);

        expect(deleted.length).toBe(2);
        expect(deleted).toEqual([{remove: "data.item.status"},{remove: "flag"}]);
    });

    it('should find deleted field', function () {

        var original = {
                "data": {
                    "item": {
                        "status": {"name": "one"},
                        "message": "some-message"
                    }
                }
            },
            modifiedTo = {
                "data": {
                    "item": {
                        "user": {"id": "user-one"},
                        "result": "some-message"
                    }
                }
            },
            diff = service.create(original),
            update = diff.schemaDiff(modifiedTo);

        expect(update.modified).toBe(true);

        var renamed  = getRenames(update.changes)[0],
            inserted = getInserts(update.changes)[0],
            removed  = getRemoved(update.changes)[0];
        expect(renamed.field).toBe("data.item.message");
        expect(renamed.renameTo).toBe("result");

        expect(removed.remove).toBe("data.item.status");

        expect(inserted.insert).toBe("data.item.user");
        expect(inserted.value).toEqual({"id" : "user-one"});

        expect(update.changes.length).toEqual(3);
    });
});