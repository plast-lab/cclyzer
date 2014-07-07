# For debugging
QUIET       := @


# Unix tools
INSTALL     := install
MKDIR       := mkdir -p
SED         := sed
RM          := rm -f
MV          := mv
M4          := m4
CXX         := g++
PROTOC      := /usr/bin/protoc

# Other tools
factgen.exe   := fact-generator
importgen.exe := import-generator
template.lb   := run.template


#-------------------------------------------------------------------------
# [Link to Data]
#
# import-generator has to specify a path from where the file
# predicates will be imported. However, each benchmark will place its
# facts at a different site. Thus, we introduce a level of indirection
# though a top-level symbolic link, namely ``data.link'', that will
# point to the correct location each time.
#
# TODO: consider alternatives, such as a command-line option to the LB
# engine as a directive to where lies the data to be imported
#-------------------------------------------------------------------------

data.link   := data


#--------------------
# Directory Tree
#--------------------

OUTDIR       = $(LEVEL)/build
DESTDIR     ?= $(LEVEL)
SAMPLEDIR   ?= $(LEVEL)/etc/sample-data

INSTALL_BIN  = $(DESTDIR)/bin
INSTALL_LIB  = $(DESTDIR)/lib


#---------------------------------------------------
# Template to create destination directory
#
# Usage:
#   $(eval $(call create-destdir, module-name))
#---------------------------------------------------

define create-destdir
$1.outdir = $(OUTDIR)/$(or $2,$(notdir $(CURDIR)))

$$($1.outdir): | $(OUTDIR)
	$(MKDIR) $$@

endef


# Create build root-directory

$(OUTDIR):
	$(MKDIR) $@
