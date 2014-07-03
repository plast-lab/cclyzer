LEVEL := ..

all:

include $(LEVEL)/common.mk
include $(LEVEL)/logic/blox.mk

$(eval $(call create-destdir,tests))


benchmarks := $(wildcard */)
template   := run.template


#-----------------------------------------
# Dependencies from other Makefiles
# 
# TODO: rearrange
#-----------------------------------------
data.link     := data
csv.import    := $(OUTDIR)/fact-generator/$(factgen.exe)
schema.outdir := $(OUTDIR)/logic/schema
import.outdir := $(OUTDIR)/logic/import

define process-script
  $(M4) --define=SCHEMA=$(schema.outdir)   \
		--define=IMPORT=$(import.outdir)  \
        --define=WORKSPACE=$2             \
        $(template) > $1
endef

#.INTERMEDIATE: $(data.link)

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

$1.csv    := $(tests.outdir)-$1/data
$1.db     := $(tests.outdir)-$1/db
$1.script := $1-run.lb

$$($1.csv): | $(OUTDIR)
	$(MKDIR) $$@

$$($1.db): | $(OUTDIR)
	$(MKDIR) $$@

import-$1: | $$($1.csv)
	$(call prompt-echo, $1, "Cleaning up older facts ...")
	$(call prompt, $1)
	$(RM) -r $$($1.csv)
	$(call prompt-echo, $1, "Importing facts ...")
	$(call prompt, $1)
	$(csv.import) -i $1 -o $$($1.csv)
	$(call prompt-echo, $1, "Stored facts in $$($1.csv)/")

load-$1: import-$1 $$($1.script)
	$(call prompt-echo, $1, "Loading into database ...")
	$(RM) -f $(data.link)
	$(QUIET) ln -s $$(abspath $$($1.csv)) $(data.link)
	$(call prompt, $1)
	$(call deploy-datalog-project,$$($1.script))

.INTERMEDIATE: $$($1.script)
$$($1.script):
	$(call prompt-echo, $1, "Generating script ...")
	$(call prompt, $1)
	$(call process-script,$$@,$$($1.db))

.PHONY: test-$1.clean
test-$1.clean:
	$(RM) -r $$($1.db)/
	$(RM) -r $$($1.csv)/


endef


# !!!Generate rules per benchmark!!!
$(foreach benchmark,$(benchmarks),$(eval $(call benchmark_template,$(benchmark:%/=%))))
