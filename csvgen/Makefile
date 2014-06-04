# Directory depth
LEVEL := ..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/common.mk

# Generate build directory
$(eval $(call create-destdir,csvgen))


srcdir       := src
outdir       := $(csvgen.outdir)
sources      := $(wildcard $(srcdir)/*.cpp)
objects      := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cpp,$(outdir)/%.d,$(sources))
program      := $(outdir)/$(factgen.exe)
include_dirs := include


#-----------------------------------
# Search in directories
#-----------------------------------

CPPFLAGS += $(addprefix -I ,$(include_dirs))

vpath %.cpp $(srcdir)
vpath %.h $(include_dirs)


#-----------------------------------
# LLVM specific flags
#-----------------------------------

CPPFLAGS += $(shell llvm-config --cppflags | sed 's/-fno-rtti//') 
CXXFLAGS += $(shell llvm-config --cxxflags | sed 's/-fno-rtti//') -fexceptions -g
LDFLAGS  += $(shell llvm-config --libs) $(shell llvm-config --ldflags) -lpthread -lcurses -ldl -g
LDFLAGS  += -lboost_system -lboost_filesystem -lboost_program_options


#-----------------------------------
# Basic Rules
#-----------------------------------

$(outdir)/%.o: %.cpp | $(outdir)
	$(COMPILE.cpp) -o $@ $<

$(program): $(objects)
	$(LINK.cpp) -o $@ $^ $(LDFLAGS)


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
	$(COMPILE.cpp) -Wall -Wextra -pedantic -fsyntax-only $(sources)

.PHONY: install
install: $(program)
	$(INSTALL) -m 0755 $< $(INSTALL_BIN)

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
