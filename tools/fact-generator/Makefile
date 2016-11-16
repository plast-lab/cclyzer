# Directory depth
LEVEL := ../..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/src/common.mk

# Set warnings and other compilation options
CXXFLAGS += -fvisibility-inlines-hidden -Wall -W -Wno-unused-parameter    \
            -Wwrite-strings -Wcast-qual -Wmissing-field-initializers      \
            -pedantic -Wno-long-long -ffunction-sections -fdata-sections  \
            -O3

LLVM_CONFIG ?= llvm-config

#-----------------------------------
# Configure paths
#-----------------------------------

srcdir       := src
outdir       := $(OUTDIR)
sources      := $(wildcard $(srcdir)/*.cpp)
objects      := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.d,$(sources))
program      := $(BINDIR)/fact-generator
library      := $(LIBDIR)/factgen.so
include_dirs := include


#-----------------------------------
# Search in directories
#-----------------------------------

vpath %.cpp $(srcdir)
vpath %.h $(include_dirs)


#-----------------------------------
# LLVM specific flags
#-----------------------------------

CPPFLAGS += $(shell $(LLVM_CONFIG) --cppflags)
LDFLAGS  += $(shell $(LLVM_CONFIG) --ldflags)
LDLIBS   += $(shell $(LLVM_CONFIG) --libs core irreader)
LDLIBS   += $(filter-out -lz,$(shell $(LLVM_CONFIG) --system-libs))
LDLIBS   += -lboost_system -lboost_filesystem -lboost_program_options


#-----------------------------------
# Basic Rules
#-----------------------------------

CPPFLAGS += $(addprefix -I ,$(include_dirs))
CXXFLAGS += -fPIC -g -std=c++11

$(outdir)/%.o: %.cpp | $(outdir)
	$(COMPILE.cpp) -o $@ $<

$(program): $(filter-out $(outdir)/PyFactGen.o, $(objects))  | $(BINDIR)
	$(LINK.cpp) -o $@ $^ $(LDLIBS)

$(library): $(objects) | $(LIBDIR)
	$(LINK.cpp) -shared -o $@ $^ $(LDLIBS)


#-----------------------------------
# Python specific flags
#-----------------------------------

py_objects := $(addprefix $(outdir)/,PyFactGen.o PyFactGen.d) $(library)

$(py_objects): CXXFLAGS += $(shell python-config --includes)
$(py_objects): LDFLAGS  += $(shell python-config --ldflags)
$(py_objects): LDLIBS   += -lboost_python

#-----------------------------------
# Phony targets
#-----------------------------------

.PHONY: all
all: $(program) $(library)

.PHONY: clean
clean:
	$(RM) -r $(outdir)

.PHONY: check-syntax
check-syntax: CXXFLAGS += -Wall -Wextra -pedantic
check-syntax: COMPILE.cpp := $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) # -fsyntax-only
check-syntax:
	$(COMPILE.cpp) -o /dev/null -S $(CHK_SOURCES)


#-----------------------------------
# Automatic Dependency Generation
#-----------------------------------

ifneq "$(MAKECMDGOALS)" "clean"
  ifneq "$(MAKECMDGOALS)" "check-syntax"
    -include $(dependencies)
  endif
endif

$(outdir)/%.d: %.cpp | $(outdir)
	$(QUIET) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |  \
	$(SED) 's,\($*.o\) *:,$(@D)/\1 $@: ,' > $@.tmp
	$(QUIET) $(MV) $@.tmp $@
	$(info Created dependency file: $@)
