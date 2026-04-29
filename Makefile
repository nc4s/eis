all: print_string.o
	gcc main.c print_string.o -o eis

print_string.o:
	nasm -felf64 print_string.s

clean:
	rm eis print_string.o