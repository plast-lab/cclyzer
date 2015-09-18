#include <iostream>

class A {
public:
    A(int x):x(x), y(x*x) {
    }

    virtual int bar() {
        return x / y;
    }


    virtual int foo() {
        return x;
    }

protected:
    int x;
    int y;
};

class B: public A {
public:
    B(int x): A(x) {
        z = x -y;
    }

    virtual int foo() {
        return y + z;
    }

    virtual int foobar() {
        return x * y;
    }
private:
    int z;
};


namespace Blah {
    class DDD {
      private:
        int g;

      public:
        DDD(int g): g(g) {}

        virtual int get() { return g; }
        virtual void set(int x) { g = x; }
    };
}

class C: public B, public Blah::DDD {
public:
    C(int x): B(x), Blah::DDD(x) {
    }

    virtual int foo() {
        return 0;
    }

    virtual void set(int x) {
        std::cout << "Field x is now set to" << x << std::endl;
        Blah::DDD::set(x);
    }
};


void print(B *b) {
    std::cout << "Field x is " << b->foo() << std::endl;
    std::cout << "Field x is " << b->foobar() << std::endl;
}

int main(int argc, char *argv[])
{
    A a(3);
    B b(5);
    C c(4);
    C *d = new C(111);

    std::cout << "Field x is " << a.foo() << std::endl;
    std::cout << "Field x is " << b.foo() << std::endl;
    std::cout << "Field x is " << c.foo() << std::endl;
    print(&b);
    print(&c);
    print(d);
    return 0;
}
