#ifndef DEMANGLER_HPP__
#define DEMANGLER_HPP__

#include <cxxabi.h>
#include <memory>
#include <string>

class Demangler
{
  public:
    inline std::string demangle(const char* name) {
        int status = -1;

        std::unique_ptr<char, void(*)(void*)> res { abi::__cxa_demangle(name, NULL, NULL, &status), std::free };
        return (status == 0) ? res.get() : std::string(name);
    }

    inline std::string demangle(const std::string name) {
        return demangle(name.c_str());
    }
};


#endif /* DEMANGLER_HPP__ */
