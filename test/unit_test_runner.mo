
import ModuleSpec "./utils/ModuleSpec";

type Group = ModuleSpec.Group;

let assertTrue = ModuleSpec.assertTrue;
let describe   = ModuleSpec.describe;
let it         = ModuleSpec.it;
let skip       = ModuleSpec.skip;
let pending    = ModuleSpec.pending;
let run        = ModuleSpec.run;

// Import all unit tests
import SimpleTest "/unit_tests/simple_test";

// Register all unit tests
run([
    SimpleTest.getTests(),
]);