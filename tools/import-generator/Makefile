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
sources      := $(wildcard $(srcdir)/*.cc)
objects       = $(patsubst $(srcdir)/%.cc,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cc,$(outdir)/%.d,$(sources))
program      := $(BINDIR)/import-generator
include_dirs := include


#-----------------------------------
# Search in directories
#-----------------------------------

CXXFLAGS += -fPIC -g -std=c++11
CPPFLAGS += $(addprefix -I ,$(include_dirs))
LDLIBS   += -lboost_program_options
LDLIBS   += -lboost_system -lboost_filesystem

vpath %.cc $(srcdir)
vpath %.h  $(include_dirs)


#-----------------------------------
# Protobuf Files
#-----------------------------------

protodir    := $(LOGICBLOX_HOME)/lib/protobuf
proto.proto := $(addprefix $(protodir)/,blox/common/Common.proto blox/compiler/BloxCompiler.proto)
proto.cc    := $(proto.proto:$(protodir)/%.proto=$(srcdir)/%.pb.cc)
proto.h     := $(proto.cc:$(srcdir)/%.pb.cc=include/%.pb.h)

vpath %.proto $(protodir)

$(proto.cc): $(srcdir)/%.pb.cc: %.proto
	$(info Generating protobuf classes from $<)
	$(PROTOC) --proto_path=$(protodir) --cpp_out=$(srcdir) $<
	$(QUIET) $(MKDIR) $(dir include/$*.pb.h)
	$(QUIET) $(MV) $(srcdir)/$*.pb.h include/$*.pb.h

# Phony targets to create auto-generated files
.PHONY: proto
proto: $(proto.cc)

# Phony targets to clear auto-generated files
.PHONY: clean-proto
clean-proto:
	$(RM) $(proto.cc) $(proto.h)

# Add auto-generated files to sources
sources += $(proto.cc)

# Add dependency so that proto-related files are generated before
# including .d files
$(dependencies): | $(proto.cc)


#-----------------------------------
# Basic Rules
#-----------------------------------

$(outdir)/%.o: %.cc | $(outdir)
	$(QUIET) $(MKDIR) $(@D)
	$(COMPILE.cc) -o $@ $<

$(program): LDLIBS += -lprotobuf
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

ifeq (,$(filter $(MAKECMDGOALS),clean clean-proto))

  ifeq ($(LOGICBLOX_HOME),)		# error checking
    $(error LOGICBLOX_HOME variable is not set)
  endif

  ifneq "$(MAKECMDGOALS)" "check-syntax"
    -include $(dependencies)	# inject dependencies
  endif

endif

$(outdir)/%.d: %.cc | $(outdir)
	$(QUIET) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |  \
	$(SED) 's,\($*.o\) *:,$(@D)/\1 $@: ,' > $@.tmp
	$(QUIET) $(MV) $@.tmp $@
	$(info Created dependency file: $@)
