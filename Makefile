FLAGS=-Wall -Wextra -Wmost -framework Foundation -lobjc -o example

all: test

test: example
	./example

example: example.m ObjCheck.m ObjCheck.h
	clang $(FLAGS) example.m ObjCheck.m

clean:
	-rm *.exe
	-rm example
