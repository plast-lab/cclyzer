#ifndef SINGLETON_HPP__
#define SINGLETON_HPP__

template<typename T>
class Singleton {
  protected:

    Singleton(){}

    static T* INSTANCE;

    virtual ~Singleton(){}

  public:

    static T* getInstance(){
        if(!INSTANCE)
            INSTANCE = new T();
        return INSTANCE;
    }

    static void destroy() {
        delete INSTANCE;
        INSTANCE = 0;
    }

    bool isInitialized(){
        return INSTANCE != 0;
    }
};

#endif
