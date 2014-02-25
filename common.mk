# For debugging
QUIET   := @


# Unix tools
INSTALL := install
MKDIR   := mkdir -p
SED     := sed
RM      := rm -f
MV      := mv
M4      := m4
CXX     := g++

# Directory Tree
OUTDIR   = $(LEVEL)/build
DATADIR  = $(LEVEL)/data


# Template to create destination directory
#
# Usage:
#   $(eval $(call create-destdir, module-name))
define create-destdir
$1.outdir = $(OUTDIR)/$1

$$($1.outdir): | $(OUTDIR)
	$(MKDIR) $$@

endef

$(OUTDIR):
	$(MKDIR) $@
