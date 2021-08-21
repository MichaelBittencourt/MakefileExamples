# MakefileExamples

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


This repository was created to explain the GNU make and Makefile


## Clone Project

```bash
$ git clone https://github.com/MichaelBittencourt/MakefileExamples.git
$ cd MakefileExamples
```

## Switching branchs

```bash
$ git checkout simpleMakefile # version 1
$ git checkout variablesMakefile # version 2
$ git checkout advancedMakefile # version 3
```

## Running

```bash
$ make
$ ./hello
```

## Cleaning

```bash
$ make clean
```

## Create debug binary

This option is available to version 2 and 3

```bash
$ make debug
```

## Create assembly files

This option is available to version 2 and 3

```bash
$ make assembly
```

## Makefile main concepts

The GNU Make is a binary builder of targets that optimize the building proccess. 
- GNU make basics
```make
target: dependencies
    instructions_to_buid_target
```

| Item | Definition |
| ------ | ------ |
| target | Can be a binary, another source code, or any type of file. |
| dependencies | Can be others targets or others files. |
| instructions\_to\_build\_target | It is a set of instructions that are used to build the target. Each instruction need a \<TAB\> before instruction and can be separeted by line. |

The target also can be used as a task that can be use to change the behaviour in the building process.

- Variables

```make
# Comments are added with # character
# To create a variable with value
VARIABLE=value
# To create a variable with no value
VOID_VARIABLE:=
# To use a variable 
$(VARIABLE)
```

- Makefile functions

```make
# To get all files with .c extension
VARIABLE=$(wildcard *.c)
# To get object files (.o) with the same names of .c files
OBJ_VARIABLE=$(VARIABLE:.c=.o)
# To replace .c occurences to .o
OBJ_VARIABLE2=$(subst .c, .o, $(VARIABLE))
# You can call each command in other.
# The example below you will replace the .c with .o and replace "main" with "other"
OBJ_VARIABLE3=$(subst .c, .s, $(subst main, other, $(VARIABLE)))
```

- Special variables

```make
# Commands that start with @ aren't shown
%.o: %.c
    @ echo 'The dependenci $< generate the target $@'
    g++ $< -o $@

target: main.o lib.o
    @ echo 'All dependencies are $^'
    @ echo 'The target are $@'
    gcc $^ -o $@
```

- Change a variable in before run a target

```make
CC=gcc
target: main.c
    $(CC) $< -o $@

.PHONY: cpp_setup

cpp_setup:
    $(eval CC=g++)
```
```bash
$ make cpp_setup target
```

The .PHONY target lists all targets that does not generate files.

## References

- [Makefile Tutorial in Portuguese](https://www.embarcados.com.br/introducao-ao-makefile/)
- [GNU Make manual](https://www.gnu.org/software/make/manual/)
- [GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html#Autotools-Introduction)
- [The Magic behind configure, make and make install](https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install)
- [To Create Markdown](https://dillinger.io/)
