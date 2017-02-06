# Directory depth
LEVEL := ../..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/src/common.mk

LLVM_CONFIG ?= llvm-config


#-----------------------------------
# Configure paths
#-----------------------------------

srcdir       := src
outdir       := $(OUTDIR)
sources      := $(wildcard $(srcdir)/*.cpp)
objects       = $(patsubst $(srcdir)/%.cpp,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.d,$(sources))
program      := $(BINDIR)/json-ast-exporter
json_library := ../jsoncons/src
include_dirs := $(json_library)


#-----------------------------------
# Compilation flags
#-----------------------------------

CXXFLAGS += -fPIC -g -std=c++11
CPPFLAGS += $(addprefix -I ,$(include_dirs))
LDLIBS   += -lboost_system -lboost_filesystem -lboost_program_options


# LLVM specific flags

CPPFLAGS += $(shell $(LLVM_CONFIG) --cppflags)
LDFLAGS  += $(shell $(LLVM_CONFIG) --ldflags)
LDFLAGS  += -Wl,-rpath=$(shell $(LLVM_CONFIG) --libdir)
LDLIBS   += -lclang


#-----------------------------------
# Search in directories
#-----------------------------------

vpath %.cpp $(srcdir)
vpath %.h   $(include_dirs)


#-----------------------------------
# Basic Rules
#-----------------------------------

$(outdir)/%.o: %.cpp | $(outdir) $(json_library)
	$(QUIET) $(MKDIR) $(@D)
	$(COMPILE.cc) -o $@ $<

$(program): $(objects) | $(BINDIR)
	$(LINK.cc) -o $@ $^ $(LDLIBS)


#-----------------------------------
# Phony targets
#-----------------------------------

.PHONY: all
all: $(program)

.PHONY: clean
clean:
	$(RM) -r $(outdir)

.PHONY: check-syntax
check-syntax:
	$(COMPILE.cc) -Wall -Wextra -std=c++0x -pedantic -fsyntax-only $(sources)


#-----------------------------------
# Automatic Dependency Generation
#-----------------------------------

ifeq (,$(filter $(MAKECMDGOALS),clean))

  ifneq "$(MAKECMDGOALS)" "check-syntax"
    -include $(dependencies)	# inject dependencies
  endif

endif

$(outdir)/%.d: %.cpp | $(outdir) $(json_library)
	$(QUIET) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |  \
	$(SED) 's,\($*.o\) *:,$(@D)/\1 $@: ,' > $@.tmp
	$(QUIET) $(MV) $@.tmp $@
	$(info Created dependency file: $@)


#-----------------------------------
# JSON-construction Library
#-----------------------------------

.PHONY: jsoncons
jsonscons: $(json_library)

$(json_library):
	git submodule update --init
