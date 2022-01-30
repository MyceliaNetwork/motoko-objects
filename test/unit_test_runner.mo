
import ModuleSpec "./utils/ModuleSpec";
// Import all unit tests
import SimpleTest "/unit_tests/simple_test";

type Group = ModuleSpec.Group;

let assertTrue = ModuleSpec.assertTrue;
let describe   = ModuleSpec.describe;
let it         = ModuleSpec.it;
let skip       = ModuleSpec.skip;
let pending    = ModuleSpec.pending;
let run        = ModuleSpec.run;


// Register all unit tests
run([
    SimpleTest.getTests(),
]);