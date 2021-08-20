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

SRC_FOLDER=src
C_SRC=$(wildcard $(SRC_FOLDER)/*.c)
HEADERS=$(wildcard $(SRC_FOLDER)/*.h)

#OBJ=$(C_SRC:.c=.o)
OBJ_FOLDER=obj
OBJ=$(subst .c,.o,$(subst $(SRC_FOLDER), $(OBJ_FOLDER),$(C_SRC)))
#ASSEMBLY_FILES=$(C_SRC:.c=.s)
ASSEMBLY_FOLDER=assembly
ASSEMBLY_FILES=$(subst .c,.s,$(subst $(SRC_FOLDER), $(ASSEMBLY_FOLDER), $(C_SRC)))

BIN=hello

all: objFolder $(BIN)
	@ echo ' '
	@ echo 'Build finish: $(BIN)'

$(BIN): $(OBJ)
	$(GCC) $^ -o $@

$(OBJ_FOLDER)/%.o: $(SRC_FOLDER)/%.c $(SRC_FOLDER)/%.h
	$(GCC) -c $< -o $@ $(CC_FLAGS)

$(OBJ_FOLDER)/main.o: $(SRC_FOLDER)/main.c $(HEADERS)
	$(GCC) -c $< -o $@ $(CC_FLAGS)

$(ASSEMBLY_FOLDER)/%.s: $(SRC_FOLDER)/%.c $(SRC_FOLDER)/%.h
	$(GCC) -c $< -o $@ $(CC_FLAGS)

$(ASSEMBLY_FOLDER)/main.s: $(SRC_FOLDER)/main.c $(HEADERS)
	$(GCC) -c $< -o $@ $(CC_FLAGS)

assembly: assemblyFolder assembly_setup $(ASSEMBLY_FILES)

assemblyFolder:
	@ mkdir -p $(ASSEMBLY_FOLDER)

objFolder:
	@ mkdir -p $(OBJ_FOLDER)

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
	rm -f *~ $(BIN)
	test -e $(OBJ_FOLDER) && rm -f $(OBJ_FOLDER)/*.o && rmdir $(OBJ_FOLDER) || true
	test -e $(ASSEMBLY_FOLDER) && rm -f $(ASSEMBLY_FOLDER)/*.s && rmdir $(ASSEMBLY_FOLDER) || true


