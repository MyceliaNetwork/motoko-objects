import ModuleSpec "../utils/ModuleSpec";
import Object "../../src/Objects";
import Objects "../../src/Objects";

// Test scafolding
// After cloning
// 1. Import file into /test/actor_tests/runner for language plugin support
// 2. Register file with /test/unit_test_runner in order to run during `$ make test`

module {
    type Group      = ModuleSpec.Group;
    
    let assertTrue  = ModuleSpec.assertTrue;
    let describe    = ModuleSpec.describe;
    let it          = ModuleSpec.it;
    let skip        = ModuleSpec.skip;
    let pending     = ModuleSpec.pending;
    let run         = ModuleSpec.run;

    public func getTests() : Group {
        return describe("Motoko Objects", [
            describe("Simple", [
                it("builds an object", do {
                    // let builder = Objects.objectControllerFactory([
                    //     ("foo", #Nat),
                    // ]);

                    // switch(builder.Builder().putNat("foo", 123).build()) {
                    //     case (#err(_)) { assertTrue(false) };
                    //     case (#ok(v))  {
                    //         assertTrue(true)
                    //     };  
                    // };
                    assertTrue(true);
                }),
                skip("should skip a test", do {
                    // Useful for defining a test that is not yet implemented
                    true
                }),
            ]),
        ])
    };
};