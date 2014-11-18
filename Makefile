LEVEL := .

all:

module.logic      := logic
module.facts      := fact-generator
module.imports    := import-generator
module.driver     := llvm-datalog
modules           := $(module.logic) $(module.facts) $(module.imports) $(module.driver)
targets.clean     := $(addsuffix .clean,$(modules))
targets.install   := $(addsuffix .install,$(modules))
targets.uninstall := $(addsuffix .uninstall,$(modules))

include $(LEVEL)/common.mk


#--------------------------
#  Accumulating Rules
#--------------------------

$(modules):
	$(MAKE) --directory=$@

$(targets.clean): %.clean:
	$(MAKE) --directory=$* clean

$(targets.install): %.install:
	$(MAKE) --directory=$* install

$(targets.uninstall): %.uninstall:
	$(MAKE) --directory=$* uninstall


#--------------------------
#  Common Phony Targets
#--------------------------

.PHONY: all $(modules)
all: $(modules)

.PHONY: clean $(targets.clean)
clean: $(targets.clean)
	$(RM) -r $(OUTDIR)/

.PHONY: install $(targets.install)
install: $(targets.install)

.PHONY: uninstall $(targets.uninstall)
uninstall: $(targets.uninstall)



#--------------------------
#  Gather Resources
#--------------------------

# Generate build directory for resources
$(eval $(call create-destdir,resources,resources))

# Add binary and logic resources
resources := $(resources.outdir)/logic
resources += $(resources.outdir)/bin/fact-generator
resources += $(resources.outdir)/bin/import-generator

# Create nested directories
$(resources.outdir)/bin: | $(resources.outdir)
	$(MKDIR) $@

# Binaries
$(resources.outdir)/bin/fact-generator: $(module.facts)
$(resources.outdir)/bin/fact-generator: resource := $(OUTDIR)/$(module.facts)/fact-generator
$(resources.outdir)/bin/import-generator: $(module.imports)
$(resources.outdir)/bin/import-generator: resource := $(OUTDIR)/$(module.imports)/import-generator
$(resources.outdir)/bin/%: | $(resources.outdir)/bin
	$(info Adding resource $(resource))
	$(QUIET) ln $(resource) $@

# Compiled Datalog projects
$(resources.outdir)/logic: resource := $(OUTDIR)/logic
$(resources.outdir)/logic: $(module.logic) | $(resources.outdir)
	$(info Adding resource $(resource))
	$(QUIET) ln -s $(abspath $(resource)) $@


# All resources are intermediate files
.INTERMEDIATE: $(resources)

# Phony targets
.PHONY: resources
resources: $(resources)

.PHONY: resources.clean
resources.clean:
	$(RM) -r $(resources.outdir)


#--------------------------
#  Create Artifacts
#--------------------------

$(eval $(call create-destdir,dist,dist))

# Zip artifact
artifact.zip  := $(dist.outdir)/llvm-datalog.zip

.INTERMEDIATE: $(artifact.zip)
$(artifact.zip): $(modules) resources | $(dist.outdir)
	$(info Creating zip artifact $@)
	$(info Adding python sources)
	$(QUIET) cp $(OUTDIR)/python/$(@F) $@
	$(info Adding resources)
	$(QUIET) ln -s $(OUTDIR)/resources resources
	zip -r $@ $(resources:$(OUTDIR)/%=%) >/dev/null
	$(QUIET) $(RM) resources

# Executable artifact
artifact.exe := $(dist.outdir)/llvm-datalog

$(artifact.exe): $(artifact.zip) dist.force
	$(info Creating artifact $@)
	$(QUIET) echo '#!/usr/bin/env python' | cat - $< > $@
	chmod +x $@


# Phony targets

.PHONY: dist
dist: $(artifact.zip) $(artifact.exe)

.PHONY: dist.clean
dist.clean:
	$(RM) -r $(dist.outdir)

.PHONY: dist.force
dist.force:

all: dist
clean: dist.clean



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
include $(LEVEL)/logic/blox.mk

# Generate build directory for tests
$(eval $(call create-destdir,tests,tests))

# Phony testing targets that apply to all benchmarks
.PHONY: tests.setup tests.run tests.clean

# Modify PATH so that it includes the fact-generator executable
export PATH := $(INSTALL_BIN):$(PATH)


#----------------------------
# Benchmark Template
#----------------------------

define benchmark_template

$1.dir    := tests/$1
$1.outdir := $(tests.outdir)/$1


# Create subdirectories

$$($1.outdir): | $(tests.outdir)
	$(MKDIR) $$@


# Run target

test-$1.run: tests.setup
	echo Analyzing $1 ...
	$(artifact.exe) -i $$($1.dir) -o $$($1.outdir)


# Cleaning target

.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.outdir)/


# Phony targets dependencies

tests.setup  : $(targets.install)
tests.run    : test-$1.run
tests.clean  : test-$1.clean

endef


# !! Generate rules per benchmark !!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:tests/%/=%))))
