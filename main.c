extern void print_string(const char* msg); // print a string and add a newline

int main(int argc, char** argv) {
    for (int i = 0; i < argc; i++) {
        print_string(argv[i]);
    }
    return 0;
}