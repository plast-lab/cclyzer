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

# Other tools
factgen.exe := csv-generation


#--------------------
# Directory Tree
#--------------------

DATADIR      = $(LEVEL)/data
OUTDIR       = $(LEVEL)/build
INSTALLDIR  ?= $(LEVEL)
SAMPLEDIR   ?= $(LEVEL)/etc/sample-data

INSTALLDIR_BIN = $(INSTALLDIR)/bin
INSTALLDIR_LIB = $(INSTALLDIR)/lib


#---------------------------------------------------
# Template to create destination directory
#
# Usage:
#   $(eval $(call create-destdir, module-name))
#---------------------------------------------------

define create-destdir
$1.outdir = $(OUTDIR)/$1

$$($1.outdir): | $(OUTDIR)
	$(MKDIR) $$@

endef


# Create build root-directory

$(OUTDIR):
	$(MKDIR) $@
