FLAGS=-Wall -Wextra -Wmost -Weverything -framework Foundation -lobjc -o example

all: test

test: example
	./example

example: example.m ObjCheck.m ObjCheck.h
	clang $(FLAGS) example.m ObjCheck.m

lint:
	oclint -rc=SHORT_VARIABLE_NAME=1 ObjCheck.m -- $(FLAGS)

clean:
	-rm *.exe
	-rm example
