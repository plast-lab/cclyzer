LEVEL := .

all:

module.logic      := logic
module.facts      := fact-generator
module.imports    := import-generator
modules           := $(module.logic) $(module.facts) $(module.imports)
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

# Add binary resources
resources.bin := $(addprefix $(resources.outdir)/bin/,\
                    $(notdir $(shell find $(OUTDIR) -executable -type f)))

$(resources.bin): | $(resources.outdir)/bin
$(resources.outdir)/bin: | $(resources.outdir)
	$(MKDIR) $@

.SECONDEXPANSION:
$(resources.outdir)/bin/%: $$(shell find $(OUTDIR) -executable -type f -name "*%")
	$(info Adding resource $<)
	$(QUIET) ln $< $@


# Add logic resources
resources.logic := $(resources.outdir)/logic

$(resources.logic): $(OUTDIR)/logic | $(resources.outdir)
	$(info Adding resource $<)
	$(QUIET) ln -s $(abspath $<) $@


# All resources are intermediate files
resources = $(resources.bin) $(resources.logic)
.INTERMEDIATE: $(resources)

# Phony targets
.PHONY: resources
resources: $(resources) | $(resources.outdir)
	$(info Resources [DONE])

.PHONY: resources.clean
resources.clean:
	$(RM) -r $(resources.outdir)


#--------------------------
#  Create Artifact
#--------------------------




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
