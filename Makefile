# For debugging
QUIET   := @

# Trees
SRCDIR  := ./src
BINDIR  := ./bin
OUTDIR  := ./build
DATADIR := ./data
DBDIR   := $(OUTDIR)/db

# Unix tools
INSTALL := install
RM      := rm -f
MKDIR   := mkdir -p
M4      := m4

# Utility Scripts
GEN.mkscript := $(BINDIR)/generate-import-script.sh
GEN.mklogic  := $(BINDIR)/generate-import-logic.sh


# LogicBlox Tools

define compile-datalog-project
  bloxcompiler -compileProject $1 -outDir $2
endef

define deploy-datalog-project
  bloxbatch -script $1
endef

define process-script
  $(M4) --define=ENTITIES=$(entities)     \
        --define=PREDICATES=$(predicates) \
        --define=SCHEMA=$(LOGIC.outdir)   \
        --define=WORKSPACE=$(DBDIR)       \
        $(LOGIC.script) > $1
endef


# Datalog Module

LOGIC.srcdir := $(SRCDIR)/datalog
LOGIC.outdir := $(OUTDIR)/datalog
LOGIC.proj   := $(LOGIC.srcdir)/llvm.project
LOGIC.ph     := $(LOGIC.outdir)/.placeholder
LOGIC.src    := $(wildcard $(LOGIC.srcdir)/schema/*.logic)
LOGIC.src    += $(wildcard $(LOGIC.srcdir)/import/*.logic)
LOGIC.script := $(LOGIC.srcdir)/run.template

# CSV data and import scripts

GEN.srcdir   := $(LOGIC.srcdir)/import
GEN.outdir   := $(OUTDIR)/import
GEN.csv      := $(shell find $(DATADIR)/ -type f -name '*.dlm')
GEN.src      := $(GEN.srcdir)/operand-specific.logic
LOGIC.src    += $(GEN.src)

entities     := $(GEN.outdir)/entities.import
predicates   := $(GEN.outdir)/predicates.import

# Script for deployment

GEN.mkdatabase := $(notdir $(basename $(LOGIC.script))).lb


## $(call csv-import-chunk, csv)
define csv-import-chunk
  $(patsubst %.dlm,$(GEN.outdir)/%.import.part, $(notdir $1))
endef


# Directories to be created
directories  := $(OUTDIR)
directories  += $(DBDIR) $(LOGIC.outdir) $(GEN.outdir)


all: compile import
compile: $(LOGIC.ph)


# Deployment

.PHONY: deploy
deploy: $(LOGIC.ph) $(entities) $(predicates) $(GEN.mkdatabase)
	$(QUIET) $(RM) $(OUTDIR)/$(DATADIR)
	$(QUIET) ln -s $(abspath $(DATADIR)) $(OUTDIR)
	$(call deploy-datalog-project,$(GEN.mkdatabase))


.INTERMEDIATE: $(GEN.mkdatabase)
$(GEN.mkdatabase):
	$(call process-script,$@)

# Import scripts and logic

## Generate import logic (file predicates)

vpath .autopred $(LOGIC.srcdir)/import

$(GEN.src): .autopred $(GEN.mklogic)
	cat $< | $(GEN.mklogic) "$(DATADIR)" > $@

## Generate .import scripts

vpath %.dlm $(DATADIR)
vpath %.dlm $(DATADIR)/entities
vpath %.dlm $(DATADIR)/predicates

$(GEN.outdir)/%.import.part: %.dlm | $(GEN.outdir)
	$(GEN.mkscript) $< > $@

## Collect all generated .import files into one

entities_CSV     := $(filter $(DATADIR)/entities/%.dlm, $(GEN.csv))
predicates_CSV   := $(filter $(DATADIR)/predicates/%.dlm, $(GEN.csv))

entities_CHUNK   := $(call csv-import-chunk,$(entities_CSV))
predicates_CHUNK := $(call csv-import-chunk,$(predicates_CSV))

.SECONDEXPANSION:
$(entities) $(predicates): $(GEN.outdir)/%.import: $$($$*_CHUNK)
	$(QUIET) echo "option,delimiter,\"	\"" > $@
	$(QUIET) echo "option,hasColumnNames,false" >> $@
	$(QUIET) cat $^ >> $@

# Uncomment this line to remove .import.part automatically
# .INTERMEDIATE: $(entities_CHUNK) $(predicates_CHUNK)

.PHONY: entities
entities: $(entities)

.PHONY: predicates
predicates: $(predicates)

.PHONY: import
import: entities predicates $(GEN.src)


# Compile Datalog Code

$(LOGIC.ph): $(LOGIC.proj) $(LOGIC.src) | $(LOGIC.outdir)
	$(call compile-datalog-project, $<,$(@D))
	$(QUIET) touch $@


# Create directories
$(directories):
	$(MKDIR) $@


# Cleaning Targets

clean: clean-import clean-db clean-logic
	$(RM) -r $(OUTDIR)/

clean-db:
	$(RM) -r $(DBDIR)/

clean-import:
	$(RM) $(GEN.src)
	$(RM) -r $(GEN.outdir)

clean-logic:
	$(RM) -r $(LOGIC.outdir)

.PHONY: clean clean-import clean-db clean-logic
.PHONY: all compile
