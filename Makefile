BIN=bin/example

FLAGS=-Wall -Wextra -Wmost -Weverything -framework Foundation -lobjc
LINUX_FLAGS=

ifneq ($(OS),Windows_NT)
	UNAME_S := $(shell uname -s)

	ifeq ($(UNAME_S),Linux)
		FLAGS=-Wall -lobjc
		LINUX_FLAGS=-I `gnustep-config --variable=GNUSTEP_SYSTEM_HEADERS` -L `gnustep-config --variable=GNUSTEP_SYSTEM_LIBRARIES` -lgnustep-base -fconstant-string-class=NSConstantString -D_NATIVE_OBJC_EXCEPTIONS -fblocks
	endif
endif

all: test

test: $(BIN)
	$(BIN)

$(BIN): example.m ObjCheck.m ObjCheck.h
	@mkdir -p bin
	@clang $(FLAGS) $(LINUX_FLAGS) -o $(BIN) example.m ObjCheck.m

oclint:
	@oclint -rc=SHORT_VARIABLE_NAME=1 ObjCheck.m -- $(FLAGS)

editorconfig:
	@git ls-files -z | grep -av patch | xargs -0 -r -n 100 $(shell npm bin)/eclint check

astyle-apply:
	-find . -type d -name android -prune -o -type f -name "*.java" -o -name "*.cpp" -o -name "*.[chm]" -exec astyle {} \; | grep -v Unchanged

astyle:
	-find . -type d -name android -prune -o -type f -name "*.java" -o -name "*.cpp" -o -name "*.[chm]" -exec astyle --dry-run {} \; | grep -v Unchanged

clean-astyle:
	-find . -type f -name "*.orig" -exec rm {} \;

infer: clean
	@infer -- make

lint: oclint editorconfig astyle #infer

clean: clean-astyle
	-rm -rf bin
