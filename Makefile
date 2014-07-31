FLAGS=-Wall -Wextra -Wmost -Weverything -framework Foundation -lobjc

LINUX_FLAGS=

ifneq ($(OS),Windows_NT)
	UNAME_S := $(shell uname -s)

	ifeq ($(UNAME_S),Linux)
		FLAGS=-Wall -lobjc -o Version
		LINUX_FLAGS=-I `gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS` -L `gnustep-config --variable=GNUSTEP_SYSTEM_LIBRARIES` -lgnustep-base -fconstant-string-class=NSConstantString -D_NATIVE_OBJC_EXCEPTIONS
	endif
endif

all: test

test: example
	./example

example: example.m ObjCheck.m ObjCheck.h
	clang $(FLAGS) $(LINUX_FLAGS) -o $(BIN) example.m ObjCheck.m

lint:
	oclint -rc=SHORT_VARIABLE_NAME=1 ObjCheck.m -- $(FLAGS)

clean:
	-rm *.exe
	-rm example
