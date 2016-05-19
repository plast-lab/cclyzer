#include <iostream>
#include <string>
#include <exception>

using std::string;
using std::exception;

class MyException : public exception
{
  public:
    MyException(string m="exception!") : msg(m) {}
    ~MyException() throw() {}
    const char* what() const throw() { return msg.c_str(); }

  private:
    string msg;
};

int foo(int x) {
    try {
        std::cout << "Say something" << "\n";
        if (x > 153)
            throw MyException("whatevs");
    }
    catch (const MyException& exc) {
        std::cout << exc.what() << "\n";
        return -1;
    }

    return x;
}

int bar(int x) {
    std::cout << "Say something else" << "\n";

    if (x < 153)
        throw MyException("ok");

    return x;
}

int foobar(int x) {
    try {
        bar(x);
    }
    catch (const MyException& exc) {
        std::cout << exc.what() << "\n";
        return -1;
    }
    catch (const exception& exc) {
        std::cout << exc.what() << "\n";
        return -2;
    }
    return 0;
}

int main(int argc, char *argv[])
{
    foo(argc);
    foobar(argc - 4);
    return 0;
}
