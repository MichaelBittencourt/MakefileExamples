# You can add commends using this character #

#####################Variables########################

#compiler defifition
GCC=gcc

OTIMIZATION=-O2
DEBUG:=
LD_FLAGS=-std=c99 \
		-W \
		-Werror \
		-Wall \
		-ansi \
		-pedantic

CC_FLAGS= $(OTIMIZATION) $(DEBUG) $(LD_FLAGS)
ASSEMBLER_FLAGS= -S -fno-asynchronous-unwind-tables

C_SRC=$(wildcard *.c)
HEADERS=$(wildcard *.h)

OBJ=$(C_SRC:.c=.o)
ASSEMBLY_FILES=$(C_SRC:.c=.s)

BIN=hello

all: $(BIN)

$(BIN): $(OBJ)
	$(GCC) $^ -o $@

%.o: %.c %.h
	$(GCC) -c $< -o $@ $(CC_FLAGS)

main.o: main.c $(HEADERS)
	$(GCC) -c $< -o $@ $(CC_FLAGS)

%.s: %.c %.h
	$(GCC) -c $< -o $@ $(CC_FLAGS)

main.s: main.c $(HEADERS)
	$(GCC) -c $< -o $@ $(CC_FLAGS)

assembly: assembly_setup $(ASSEMBLY_FILES)

.PHONY: clean debug debug_setup assembly_setup assembly

no_otimization: no_otimization_setup all

no_otimization_setup:
	$(eval OTIMIZATION=-O0)

debug: debug_setup all

debug_setup:
	$(eval DEBUG=-g3)

assembly_setup:
	$(eval CC_FLAGS=${CC_FLAGS} ${ASSEMBLER_FLAGS})

clean:
	rm -rf *.o *.s *~ $(BIN)


