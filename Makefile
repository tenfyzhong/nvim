.PHONY: test

test:
	cd ./lua && lua tests/* -v
