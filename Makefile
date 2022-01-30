.PHONY: test

test:
	moc $(shell vessel sources) -wasi-system-api -o Test.wasm test/*unit_test_runner.mo && wasmtime test.wasm
	rm -f test.wasm