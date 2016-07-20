describe('diffUtil', function () {
    beforeEach(module('mango'));

    var util;

    beforeEach(inject(function (_diffUtil_) {
        util = _diffUtil_;
    }));

    it('should find deleted field', function () {
        var object = {
                "data": {
                    "name" : "some-item",
                    "item": {
                        "user": {"id": "user-one"},
                        "result": "some-message"
                    }
                }
            },
            expected = ["data", "data.item", "data.item.user", "data.item.result","data.name"],
            actual   = util.fieldsIn(object);
        
        expect(_.difference(expected, actual)).toEqual([]);
    });
});