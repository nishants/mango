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
        original = {
            "data": {
                "item" : {
                    "status" : "some-status",
                    "message": "some-message"
                }
            }
        },diff;

    beforeEach(inject(function (_diffService_) {
        diff = _diffService_.create(original);
    }));

    it('should find deleted field', function () {
        var modifiedTo = {
            "data": {
                "item" : {
                    "user"  : {"id" : "user-one"},
                    "result": "some-message"
                }
            }
        }, update = diff.schemaDiff(modifiedTo);

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