# Directory depth
LEVEL := ../..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/src/common.mk
include blox.mk

# Projects
project.files := $(shell find -type f -name '*.project')
projects      := $(patsubst ./%/,%,$(dir $(project.files)))


#-----------------------------------
# Phony targets
#-----------------------------------

all:

force:

clean:
	$(RM) -r $(OUTDIR)

.PHONY: all clean force


#------------------------------
#  Project Creation Template
#------------------------------

define project_template

$1.proj   := $(wildcard $1/*.project)
$1.src    := $(shell find $1/ -type f -name '*.logic')
$1.outdir := $(OUTDIR)/$1
$1.ph     := $$($1.outdir)/checksum
$1.deps   := $1/deps.mk


# Create output directory
$$($1.outdir): | $(OUTDIR)
	$(MKDIR) $$@

# Auto-generate project dependencies
export PATH := $(LEVEL)/bin:$(LEVEL)/scripts:$(PATH)
$$($1.deps): $$($1.proj) | $$($1.outdir)
	project-dependencies . $$< $$($1.ph) > $$@


# When a single `.project' file changes, *all* project-dependency
# Makefile modules must be renewed, since their generation involves
# reading all `.project' files to acquire their /project IDs/.

$$($1.deps): $(project.files)


# Include deps.mk Makefile segment
-include $$($1.deps)


# Compile project
$$($1.ph): $$($1.proj) $$($1.src) | $$($1.outdir)
	$(call compile-datalog-project, $$<,$$(@D))
	$(QUIET) $(INSTALL) -m 0644 $$< $$(@D)
	$(QUIET) od -vAn -N4 -tu4 < /dev/urandom > $$@


# Project build target
.PHONY: $1
$1: $$($1.ph)

# Project clean targets
.PHONY: $1.clean
$1.clean:
	$(RM) -r $$($1.outdir)

.PHONY: $1.clean-deps
$1.clean-deps:
	$(RM) $$($1.deps)

.PHONY: $1.cleanall
$1.cleanall: $1.clean $1.clean-deps

# Phony target dependencies
all:        $1
clean:      $1.clean
clean-deps: $1.clean-deps
cleanall:   $1.cleanall

endef

# !! Generate rules per project !!
$(foreach project,$(projects),$(eval $(call project_template,$(project))))


#-----------------------------------
# Transform to python package
#-----------------------------------

all: $(OUTDIR)/__init__.py

$(OUTDIR)/__init__.py:
	touch $@


#------------------------------------------------------------------------------
#  [Generate Import Sources]
#
#   When the schema changes, it is often necessary to regenerate the
#   import logic. The steps are the following:
#
#     i. make sure that PATH contains the import-generator binary
#    ii. run the `import.src' target of this Makefile
#
#   TODO add the above instructions on the project's README
#------------------------------------------------------------------------------

schema.pb   := $(schema.src:schema/%.logic=$(import.outdir)/%.pb)
export PATH := $(LEVEL)/bin:$(PATH)

# Generate protobuf messages from schema
.INTERMEDIATE: $(schema.pb)
$(schema.pb): $(import.outdir)/%.pb: $(schema.ph) | $(import.outdir)
	$(QUIET) $(MKDIR) $(@D)
	gen-protobuf-message $(schema.outdir)/$*.lbb $@

# Generate import sources; this will recreate $(import.src) files
.PHONY: import.src
import.src: $(schema.pb)
	import-generator --ignore import/.ignored-predicates --dir facts --delim '\t' -o import $^
