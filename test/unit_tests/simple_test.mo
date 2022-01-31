import ModuleSpec "../utils/ModuleSpec";
import Object "../../src/Objects";
import Objects "../../src/Objects";

// Test scafolding
// After cloning
// 1. Import file into /test/actor_tests/runner for language plugin support
// 2. Register file with /test/unit_test_runner in order to run during `$ make test`

module {
    type Group      = ModuleSpec.Group;
    
    let assertTrue    = ModuleSpec.assertTrue;
    let assertAllTrue = ModuleSpec.assertAllTrue;
    let describe      = ModuleSpec.describe;
    let it            = ModuleSpec.it;
    let skip          = ModuleSpec.skip;
    let pending       = ModuleSpec.pending;
    let run           = ModuleSpec.run;

    public func getTests() : Group {
        type SimpleObject = {
            foo : Nat;
            bar : Text;
        };

        let schema : Objects.ObjectSchema = [
            ("foo", #Nat),
            ("bar", #Text),
        ];

        let s : Objects.SerializerFunc<SimpleObject> = func (n, b) {
            b.putNat("foo", n.foo)
             .putText("bar", n.bar)
             .build();
        };

        let d : Objects.DeserializerFunc<SimpleObject> = func (obj, inspector) {
            switch(inspector.getNat("foo"), inspector.getText("bar")) {
                case (#ok(v), #ok(v1)) {return #ok({foo = v; bar = v1})};
                case (_, _)   {return #err};
            };
        };

        let builder = Objects.objectBuilderFactory(schema);

        return describe("Motoko Objects", [
            describe("Simple", [
                it("builds an object", do {
                    let objResult = builder.Builder()
                                     .putNat("foo", 123)
                                     .putText("bar", "hello")
                                     .build();
                    switch(objResult) {
                        case (#ok(obj)) {
                            let inspector = Objects.objectInspectorFactory(obj);
                            switch(inspector.getNat("foo"), inspector.getText("bar")) {
                                case (#ok(v1), #ok(v2)) {
                                    assertAllTrue([
                                        v1 == 123,
                                        v2 == "hello"
                                    ])
                                };
                                case (_, _) {assertTrue(false)};
                            };
                        };
                        case (#err(_)) {assertTrue(false)};
                    };
                }),
                it("builds serializes and deseralizes and object", do {
                    let mapper = Objects.mapperFactory(schema, s, d);
                    switch(mapper.serialize({foo = 123; bar = "test"})) {
                        case (#ok(v))  {
                            switch(mapper.deserialize(v)) {
                                case (#ok(result)) {
                                    assertAllTrue([
                                        result.foo == 123,
                                        result.bar == "test",
                                    ]);
                                };
                                case (#err) {assertTrue(false)};
                            };
                        };
                        case (#err(_)) {assertTrue(false)};
                    };
                })
            ]),
        ])
    };
};