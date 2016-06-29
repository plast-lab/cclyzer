class A {
    int x;
    int y;
  public:
    A(int x) : x(x) {}

    virtual int get() const {
        return x * x;
    }
};

int foo(A a) {
    return a.get();
};

int foo2(const A& a) {
    return a.get();
};

int foo3(A& a) {
    return a.get();
};

int foo4(A *a) {
    return a->get();
};

int main(int argc, char *argv[])
{
    A a1(3);
    A a2(foo(a1));
    A a3(foo2(a2));
    A a4(foo3(a3));

    A& a5 = a4;
    return foo4(&a5);
}
