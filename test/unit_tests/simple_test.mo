import ModuleSpec "../utils/ModuleSpec";

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
        return describe("Example Test Suite", [
            describe("Subgroup", [
                it("should foo", do {
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