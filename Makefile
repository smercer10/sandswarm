.PHONY: all clean run test

all:
	@dune build

clean:
	@dune clean

run:
	@dune exec sandswarm

test:
	@dune test
