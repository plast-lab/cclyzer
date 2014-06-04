# Directory depth
LEVEL := ..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/common.mk
include blox.mk

# Generate build directory
$(eval $(call create-destdir,logic))

logic.bin  := bin
logic.proj := llvm.project
logic.src  := $(wildcard schema/*.logic)
logic.src  += $(wildcard import/*.logic)
logic.ph   := $(logic.outdir)/.placeholder
logic.tmpl := run.template


#-----------------------------------
# Basic Rules
#-----------------------------------

$(logic.ph): $(logic.proj) $(logic.src) | $(logic.outdir)
	$(call compile-datalog-project, $<,$(@D))
	$(QUIET) touch $@


#-----------------------------------
# Phony targets
#-----------------------------------

.PHONY: all
all: $(logic.ph)

.PHONY: clean
clean:
	$(RM) -r $(logic.outdir)


#=========================================
# Generated import scripts/logic section
#=========================================

$(eval $(call create-destdir,import))

import.csv   := $(shell find $(SAMPLEDIR)/ -type f -name '*.dlm')
import.src   := import/operand-specific.logic
entities     := $(import.outdir)/entities.import
predicates   := $(import.outdir)/predicates.import

# Utility Scripts
import.mkscript := $(logic.bin)/generate-import-script.sh
import.mklogic  := $(logic.bin)/generate-import-logic.sh


$(logic.ph): $(import.src)


#-----------------------------------------
# Generate import logic (file predicates)
#-----------------------------------------

vpath .autopred import

$(import.src): .autopred $(import.mklogic)
	cat $< | $(import.mklogic) "$(abspath $(DATADIR))" > $@


#-----------------------------------------
# Generate .import scripts
#-----------------------------------------

vpath %.dlm $(SAMPLEDIR)
vpath %.dlm $(SAMPLEDIR)/entities
vpath %.dlm $(SAMPLEDIR)/predicates

$(import.outdir)/%.import.part: %.dlm $(import.mkscript) | $(import.outdir)
	$(QUIET) $(RM) $(DATADIR)
	$(QUIET) ln -s $(abspath $(SAMPLEDIR)) $(DATADIR)
	$(import.mkscript) $(abspath $(subst $(SAMPLEDIR),$(DATADIR),$<)) > $@


#-----------------------------------------------
# Collect all generated .import files into one
#-----------------------------------------------

entities_CSV     := $(filter $(SAMPLEDIR)/entities/%.dlm, $(import.csv))
predicates_CSV   := $(filter $(SAMPLEDIR)/predicates/%.dlm, $(import.csv))

## $(call csv-import-chunk, csv)
define csv-import-chunk
  $(patsubst %.dlm,$(import.outdir)/%.import.part, $(notdir $1))
endef

entities_CHUNK   := $(call csv-import-chunk,$(entities_CSV))
predicates_CHUNK := $(call csv-import-chunk,$(predicates_CSV))

.SECONDEXPANSION:
$(entities) $(predicates): $(import.outdir)/%.import: $$($$*_CHUNK)
	$(QUIET) echo "option,delimiter,\"	\"" > $@
	$(QUIET) echo "option,hasColumnNames,false" >> $@
	$(QUIET) cat $^ >> $@

# Uncomment this line to remove .import.part automatically
# .INTERMEDIATE: $(entities_CHUNK) $(predicates_CHUNK)

# Phony Targets

.PHONY: entities
entities: $(entities)

.PHONY: predicates
predicates: $(predicates)

.PHONY: import
import: entities predicates $(import.src)

.PHONY: import.clean
import.clean:
	$(RM) $(import.src)
	$(RM) -r $(import.outdir)

all: import
clean: import.clean



#==================
# Deployment Test
#==================

deploy.script := run.lb
workspace     := $(OUTDIR)/db

define process-script
  $(M4) --define=ENTITIES=$(entities)     \
        --define=PREDICATES=$(predicates) \
        --define=SCHEMA=$(logic.outdir)   \
        --define=WORKSPACE=$(workspace)   \
        $(logic.tmpl) > $1
endef

.PHONY: deploy
deploy: all $(deploy.script)
	$(QUIET) $(RM) $(OUTDIR)/$(notdir $(DATADIR))
	$(QUIET) ln -s $(abspath $(DATADIR)) $(OUTDIR)
	$(call deploy-datalog-project,$(deploy.script))


.INTERMEDIATE: $(deploy.script)
$(deploy.script):
	$(call process-script,$@)


.PHONY: deploy.clean
deploy.clean:
	$(RM) -r $(workspace)/
