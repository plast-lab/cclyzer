LEVEL := .

all:

module.logic    := logic
module.facts    := fact-generator
module.imports  := import-generator
modules         := $(module.logic) $(module.facts) $(module.imports)
targets.clean   := $(addsuffix .clean,$(modules))
targets.install := $(addsuffix .install,$(modules))

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
$(eval $(call create-destdir,tests))

# Phony testing targets that apply to all benchmarks
.PHONY: tests.import tests.clean


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

$1.dir := tests/$1/
$1.csv := $(tests.outdir)-$1/facts
$1.db  := $(tests.outdir)-$1/db
$1.lb  := test-$1.run.lb

$$($1.csv): | $(OUTDIR)
	$(MKDIR) $$@

$$($1.db): | $(OUTDIR)
	$(MKDIR) $$@

export PATH := $(INSTALL_BIN):$(PATH)
test-$1.import: | $$($1.csv)
	$(call prompt-echo, $1, "Cleaning up older facts ...")
	$(call prompt, $1)
	$(RM) -r $$($1.csv)
	$(call prompt-echo, $1, "Importing facts ...")
	$(call prompt, $1)
	$(factgen.exe) -i $$($1.dir) -o $$($1.csv)
	$(call prompt-echo, $1, "Stored facts in $$($1.csv)/")


.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.db)/
	$(RM) -r $$($1.csv)/


tests.import : test-$1.import
tests.clean  : test-$1.clean

endef


# !!!Generate rules per benchmark!!!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:tests/%/=%))))
