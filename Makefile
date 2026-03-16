CC = iverilog 
FLAGS = -Wall -Winfloop

all: build/hello

build/hello: src/hello.v
	$(CC) $(FLAGS) $^ -o $@

run: build/hello
	vvp $^

build/lab1-max5: lab1/max5/src/max5*.v lab1/max5/TB/*.v
	$(CC) $(FLAGS) $^ -o $@

lab1-run: build/lab1-max5
	vvp $^
	gtkwave build/max5_wave.vcd

clean:
	rm -f build/*
