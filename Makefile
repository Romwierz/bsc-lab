CC = iverilog 
FLAGS = -Wall -Winfloop

all: build/hello

build/hello: src/hello.v
	$(CC) $(FLAGS) $^ -o $@

run: build/hello
	vvp $^

clean:
	rm -f build/*
