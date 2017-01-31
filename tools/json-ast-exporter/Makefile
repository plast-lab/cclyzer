# Directory depth
LEVEL := ../..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/src/common.mk

#-----------------------------------
# Configure paths
#-----------------------------------

srcdir       := src
outdir       := $(OUTDIR)
sources      := $(wildcard $(srcdir)/*.cpp)
objects       = $(patsubst $(srcdir)/%.cpp,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.d,$(sources))
program      := $(BINDIR)/json-ast-exporter
include_dirs := ../jsoncons/src


#-----------------------------------
# Search in directories
#-----------------------------------

CXXFLAGS += -fPIC -g -std=c++11
CPPFLAGS += $(addprefix -I ,$(include_dirs))
LDLIBS   += -lboost_program_options
LDLIBS   += -lboost_system -lboost_filesystem

vpath %.cpp $(srcdir)
vpath %.h   $(include_dirs)


#-----------------------------------
# Basic Rules
#-----------------------------------

$(outdir)/%.o: %.cpp | $(outdir)
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

$(outdir)/%.d: %.cpp | $(outdir)
	$(QUIET) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |  \
	$(SED) 's,\($*.o\) *:,$(@D)/\1 $@: ,' > $@.tmp
	$(QUIET) $(MV) $@.tmp $@
	$(info Created dependency file: $@)
