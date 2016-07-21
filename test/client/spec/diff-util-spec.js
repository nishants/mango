describe('diffUtil', function () {
    beforeEach(module('mango'));

    var util;

    beforeEach(inject(function (_diffUtil_) {
        util = _diffUtil_;
    }));

    it('should find fields in object', function () {
        var object = {
                "data": {
                    "name" : "some-item",
                    "item": {
                        "user": {"id": "user-one"},
                        "result": "some-message"
                    }
                }
            },
            expected = ["data", "data.item", "data.item.user", "data.item.result","data.name","data.item.user.id"],
            actual   = util.fieldsIn(object);
        
        expect(expected.sort()).toEqual(actual.sort());
    });

    it('should find array field', function () {
        var object = {
                "data": {
                    "name" : "some-item",
                    "item": [1, 2, 3]
                }
            },
            expected = ["data", "data.item","data.name"],
            actual   = util.fieldsIn(object);

        expect(expected.sort()).toEqual(actual.sort());
    });

    it('should find elements inside array', function () {
        var object   = {"data": [{"id" : "me"}]},
            expected = ["data", "data[].id"],
            actual   = util.fieldsIn(object);

        expect(expected.sort()).toEqual(actual.sort());
    });

    it('should find elements nested inside arrays', function () {
        var object   = {"data": [{"id" : "me", "name": "jugnu", "list": [{"inner" : "super"}]}]},
            expected = ["data", "data[].id","data[].name", "data[].list", "data[].list[].inner"],
            actual   = util.fieldsIn(object);

        expect(expected.sort()).toEqual(actual.sort());
    });

    it('should read value for objects inside arrays(from sample element)', function () {
        var object   = {"data": [{"id" : "me", "name": "jugnu", "list": [{"inner" : "super"}]}]};

        expect(util.valueFor("data[].list[].inner", object)).toEqual("super");
    });

    it('should read field-id value', function () {
        var object = {
                "data": {
                    "name" : "some-item",
                    "item": {
                        "user": {"id": "user-one"},
                        "result": "some-message"
                    }
                }
            };

        expect(util.valueFor("data.item.user", object)).toEqual({"id": "user-one"});
    });
});