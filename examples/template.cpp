// #include "template.hpp"

template<typename First, typename Second>
class Pair {
  private:
    First first;
    Second second;
};

struct Empty {};

class A : public Empty,
          public Pair<int,double>
{
    
};

class B : public Empty,
          public Pair<int,Pair<int,double> >
{
    
};

int main(int argc, char *argv[])
{
    A a;
    B b;
    return 0;
}
