LEVEL := .
COPPER_OPTS ?=
PYTHON = python
COPPER = copper

all:

module.logic   := logic
module.facts   := fact-generator
module.imports := import-generator
modules        := $(module.logic) $(module.facts) $(module.imports)
modules.clean  := $(addsuffix .clean,$(modules))

include $(LEVEL)/src/common.mk


# Paths to modules

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

.PHONY: all clean $(modules) $(modules.clean)
all: $(modules)

clean: $(modules.clean)
	$(RM) -r $(OUTDIR)/

.PHONY: install
install:
	$(PYTHON) setup.py install


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

# Overwrite build directory for tests
OUTDIR = $(BUILDDIR)/tests

# Phony testing targets that apply to all benchmarks
.PHONY: tests.setup tests.run tests.clean


#----------------------------
# Benchmark Template
#----------------------------

define benchmark_template

$1.files  := $(wildcard tests/$1/*)
$1.outdir := $(OUTDIR)/$1


# Create subdirectories

$$($1.outdir): | $(OUTDIR)
	$(MKDIR) $$@


# Run target

test-$1: tests.setup
	@echo Analyzing $1 ...
	$(COPPER) -o $$($1.outdir) $(COPPER_OPTS) $$($1.files)


# Cleaning target

.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.outdir)/


# Phony targets dependencies

tests.setup  : $(targets)
tests.run    : test-$1
tests.clean  : test-$1-clean

endef


# !! Generate rules per benchmark !!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:tests/%/=%))))
