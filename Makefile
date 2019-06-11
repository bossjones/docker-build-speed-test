build:
	./bin/build-base

ci: build
	./bin/run-test


dc-build:
	./bin/dc-build-base

dc-ci: dc-build
	./bin/run-test
