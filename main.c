#include <string.h> // github won't catch this dependency; it doesn't matter since glibc is assumed (because the assembly only runs on Linux)

extern void print_string(const char* msg); // print a string and add a newline
extern void error_string(const char* msg); // do the same as print_string() but print to stderr

int main(int argc, char** argv) {
    for (int i = 0; i < argc; i++) {
        if (argv[i] != NULL && argv[i][0] != '\0') print_string(argv[i]);
        else error_string("Somehow, an argument with a length of ZERO (that's right, 0)\
was created. I suggest you replace your operating system.");
    }

    if (strcmp(argv[0], "eis") != 0 && strcmp(argv[0], "./eis") != 0) error_string("I don't like your attitude.");

    return 0;
}