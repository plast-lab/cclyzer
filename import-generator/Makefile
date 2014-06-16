# Directory depth
LEVEL := ..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/common.mk

# Generate build directory
$(eval $(call create-destdir,import-generator))


srcdir       := src
outdir       := $(import-generator.outdir)
sources      := $(wildcard $(srcdir)/*.cc)
objects       = $(patsubst $(srcdir)/%.cc,$(outdir)/%.o,$(sources))
dependencies := $(patsubst $(srcdir)/%.cc,$(outdir)/%.d,$(sources))
program      := $(outdir)/$(importgen.exe)
include_dirs := include


#-----------------------------------
# Search in directories
#-----------------------------------

CPPFLAGS += $(addprefix -I ,$(include_dirs))

vpath %.cc $(srcdir)
vpath %.h  $(include_dirs)


#-----------------------------------
# Protobuf Files
#-----------------------------------

protodir    := $(LOGICBLOX_HOME)/lib/protobuf
proto.proto := $(addprefix $(protodir)/,blox/common/Common.proto)
proto.cc    := $(proto.proto:$(protodir)/%.proto=$(srcdir)/%.pb.cc)

vpath %.proto $(protodir)

$(proto.cc): $(srcdir)/%.pb.cc: %.proto
	$(PROTOC) --proto_path=$(protodir) --cpp_out=$(srcdir) $<
	$(MKDIR) $(dir include/$*.pb.h)
	$(MKDIR) $(dir $(outdir)/$*.pb.o)
	$(MV) $(srcdir)/$*.pb.h include/$*.pb.h

.PHONY: proto
proto: $(proto.cc)

# Add auto-generated files
sources += $(proto.cc)


#-----------------------------------
# Basic Rules
#-----------------------------------

$(outdir)/%.o: %.cc | $(outdir)
	$(COMPILE.cc) -o $@ $<

$(program): $(objects)
	$(LINK.cc) -o $@ $^ $(LDFLAGS) -lprotobuf


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
	$(COMPILE.cc) -Wall -Wextra -pedantic -fsyntax-only $(sources)

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

$(outdir)/%.d: %.cc | $(outdir)
	$(QUIET) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |  \
	$(SED) 's,\($*.o\) *:,$(@D)/\1 $@: ,' > $@.tmp
	$(QUIET) $(MV) $@.tmp $@
	$(info Created dependency file: $@)
