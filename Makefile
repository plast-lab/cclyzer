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

# Look for .template files in this directory
vpath %.template $(INSTALL_BIN)/

# Generate build directory for tests
$(eval $(call create-destdir,tests,tests))

# Phony testing targets that apply to all benchmarks
.PHONY: tests.setup tests.export tests.load tests.clean

# Modify PATH so that it includes the fact-generator executable
export PATH := $(INSTALL_BIN):$(PATH)


#----------------------------
# Prompt routines
#----------------------------

define prompt
  @echo -n "BENCH [ $(strip $1) ]:   "
endef

define prompt-echo
  @echo "BENCH [ $(strip $1) ]: $(strip $2)"
endef


#----------------------------
# Benchmark Template
#----------------------------

define benchmark_template

$1.dir    := tests/$1
$1.outdir := $(tests.outdir)/$1
$1.csv    := $$($1.outdir)/facts
$1.db     := $$($1.outdir)/db
$1.lb     := test-$1.run.lb


# Create subdirectories

$$($1.csv)   : | $$($1.outdir)
$$($1.db)    : | $$($1.outdir)
$$($1.outdir): | $(tests.outdir)
	$(MKDIR) $$@


# Fact-generation step

test-$1.export: tests.setup | $$($1.csv)
	$(call prompt-echo, $1, "Cleaning up older facts ...")
	$(call prompt, $1)
	$(RM) -r $$($1.csv)
	$(call prompt-echo, $1, "Exporting facts ...")
	$(call prompt, $1)
	$(factgen.exe) -i $$($1.dir)/ -o $$($1.csv)
	$(call prompt-echo, $1, "Stored facts in $$($1.csv)/")


# Database-generation step

test-$1.load: $$($1.lb) test-$1.export
	$(call prompt-echo, $1, "Importing to database ...")
	$(QUIET) $(RM) $(data.link)
	$(QUIET) ln -s $$(abspath $$($1.csv)) $(data.link)
	$(call prompt, $1)
	$(call deploy-datalog-project,$$<)


# Create datalog script

.INTERMEDIATE: $$($1.lb)
$$($1.lb): $(template.lb)
	$(call prompt-echo, $1, "Generating script ...")
	$(call prompt, $1)
	$(M4) --define=WORKSPACE=$$($1.db) --define=DIR=$$($1.outdir)/ $$< > $$@


# Cleaning target

.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.db)/
	$(RM) -r $$($1.csv)/
	$(RM) -r $$($1.outdir)/


# Phony targets dependencies

tests.setup  : $(targets.install)
tests.export : test-$1.export
tests.load   : test-$1.load
tests.clean  : test-$1.clean

endef


# !! Generate rules per benchmark !!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:tests/%/=%))))
