# You can add commends using this character #

all: hello

hello: main.o helloWorld.o
	gcc main.o helloWorld.o -o hello -W -Wall -ansi -pedantic

helloWorld.o: helloWorld.c helloWorld.h
	gcc -c helloWorld.c -o helloWorld.o -W -Wall -ansi -pedantic

main.o: main.c helloWorld.h
	gcc -c main.c -o main.o -W -Wall -ansi -pedantic

.PHONY: clean

clean:
	rm -rf *.o *~ hello


