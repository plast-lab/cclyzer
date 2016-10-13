template<typename First, typename Second>
class Pair {
  private:
    First first;
    Second second;

  public:

    virtual ~Pair() {}

    template<typename Third>
    class Inner {
        Third third;
    };
};

int main(int argc, char *argv[])
{
    Pair<int,double> pp1;
    Pair<int,int> pp2;
    Pair<int,double>::Inner<char> p;
    Pair<int,double>::Inner<long> p2;
    Pair<int,int>::Inner<char> p3;
    Pair<int,int>::Inner<double> p4;
    Pair<double,double>::Inner<char> p5;
    return 0;
}
