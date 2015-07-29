LEVEL := .
COPPER_OPTS ?=
PYTHON = python

all:

module.logic   := logic
module.driver  := python-egg
module.facts   := fact-generator
module.imports := import-generator
modules        := $(module.logic) $(module.facts) $(module.imports) $(module.driver)
modules.clean  := $(addsuffix .clean,$(modules))

include $(LEVEL)/src/common.mk


# Paths to modules

$(addsuffix _PATH, $(module.driver))  := src/main
$(addsuffix _PATH, $(module.logic))   := src/logic
$(addsuffix _PATH, $(module.facts))   := tools/fact-generator
$(addsuffix _PATH, $(module.imports)) := tools/import-generator


# Accumulating Rules

$(modules):
	$(MAKE) --directory=$($@_PATH)

$(modules.clean): %.clean:
	$(MAKE) --directory=$($*_PATH) clean

export PATH := $(abspath $(OUTDIR)/import-generator):$(PATH)
schema-import: $(module.logic) $(module.imports)
	$(MAKE) --directory=$($<_PATH) import.src

# Phony targets

.PHONY: all clean install uninstall $(modules) $(modules.clean)
all: $(modules)

clean: $(modules.clean)
	$(RM) -r $(OUTDIR)/


#--------------------------
#  Gather Resources
#--------------------------

# Generate build directory for resources
$(eval $(call create-destdir,resources,resources))

# Create nested directories
$(resources.outdir)/bin: | $(resources.outdir)
	$(MKDIR) $@

# Paths to binary and logic resources
resource.factgen := $(resources.outdir)/bin/fact-generator
resource.logic   := $(resources.outdir)/logic

# Add binary and logic resources
resources := $(resource.logic) $(resource.factgen)

# Resource targets
$(resource.factgen)   :  resource := $(OUTDIR)/$(module.facts)/fact-generator
$(resource.logic)     :  resource := $(OUTDIR)/logic

$(resource.factgen): | $(resources.outdir)/bin
	$(info Adding resource $(resource) ...)
	$(QUIET) ln $(resource) $@

$(resource.logic):   | $(resources.outdir)
	$(info Adding resource $(resource) ...)
	$(QUIET) ln -s $(abspath $(resource)) $@

$(resources) : $(modules)

# All resources are intermediate files
.INTERMEDIATE: $(resources)

# Phony targets
.PHONY: resources resources.clean
resources: $(resources)

resources.clean:
	$(RM) -r $(resources.outdir)


#--------------------------
#  Create Artifacts
#--------------------------

$(eval $(call create-destdir,dist,dist))

# Artifacts
artifact.zip := $(dist.outdir)/llvm-datalog.zip
artifact.egg := $(dist.outdir)/llvm-datalog.egg
artifact.exe := $(dist.outdir)/llvm-datalog

.INTERMEDIATE: $(artifact.zip)
$(artifact.zip): $(modules) resources | $(dist.outdir)
	$(info Creating zip artifact $@ ...)
	$(info Adding python sources ...)
	$(QUIET) cp $(OUTDIR)/python/$(@F) $@
	$(info Adding resources ...)
	$(QUIET) ln -s $(OUTDIR)/resources resources
	zip -r $@ $(resources:$(OUTDIR)/%=%) >/dev/null
	$(QUIET) $(RM) resources


$(artifact.egg): $(artifact.zip) dist.force
	$(info Creating artifact $@ ...)
	$(INSTALL) $< $@

$(artifact.exe): $(artifact.zip) dist.force
	$(info Creating artifact $@ ...)
	$(QUIET) echo '#!/usr/bin/env python' | cat - $< > $@
	chmod +x $@


shell: $(artifact.egg)
	PYTHONPATH=$< $(PYTHON)

# Phony targets

.PHONY: dist dist.clean dist.force shell
dist: $(artifact.zip) $(artifact.exe) $(artifact.egg)

dist.clean:
	$(RM) -r $(dist.outdir)

dist.force:

all: dist
clean: dist.clean


# System Installation

install:
	$(INSTALL) -m 0755 $(artifact.exe) $(INSTALL_BIN)

uninstall:


#-----------------------------------------
#    _            _   _
#   | |_ ___  ___| |_(_)_ __   __ _
#   | __/ _ \/ __| __| | '_ \ / _` |
#   | ||  __/\__ \ |_| | | | | (_| |
#    \__\___||___/\__|_|_| |_|\__, |
#                             |___/
#
#-----------------------------------------


# A list of our benchmarks
benchmarks := $(dir $(wildcard tests/*/*.bc))

# Load LogicBlox functions
ifneq "$(MAKECMDGOALS)" "install"
  include $(LEVEL)/src/logic/blox.mk
endif

# Generate build directory for tests
$(eval $(call create-destdir,tests,tests))

# Phony testing targets that apply to all benchmarks
.PHONY: tests.setup tests.run tests.clean


#----------------------------
# Benchmark Template
#----------------------------

define benchmark_template

$1.files  := $(wildcard tests/$1/*)
$1.outdir := $(tests.outdir)/$1


# Create subdirectories

$$($1.outdir): | $(tests.outdir)
	$(MKDIR) $$@


# Run target

test-$1.run: tests.setup
	@echo Analyzing $1 ...
	$(artifact.exe) -o $$($1.outdir) $(COPPER_OPTS) $$($1.files)


# Cleaning target

.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.outdir)/


# Phony targets dependencies

tests.setup  : $(targets)
tests.run    : test-$1.run
tests.clean  : test-$1.clean

endef


# !! Generate rules per benchmark !!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:tests/%/=%))))
