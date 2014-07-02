#ifndef __PARSE_PROTOBUF_HPP__
#define __PARSE_PROTOBUF_HPP__

#include <string>
#include <map>
#include <vector>

#include "Predicate.h"
#include "blox/common/Common.pb.h"
#include "blox/compiler/BloxCompiler.pb.h"

#define SUCCESS 0
#define FAILURE 1

typedef std::map<const std::string, const blox::common::protocol::PredicateInfo*> predicateInfMap;

int parse(const char *inputFile, std::vector<const Constructor*> &constructors,
          std::map<const std::string, Predicate*> &allPredicates);

#endif
