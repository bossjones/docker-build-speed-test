build:
	./bin/build-base

ci: build
	./bin/run-test
