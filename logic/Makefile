# Directory depth
LEVEL := ..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/common.mk
include blox.mk

# Generate build directory for logic
$(eval $(call create-destdir,logic))


#------------------------------
#  Schema Project Creation
#------------------------------

schema.proj   := schema/schema.project
schema.src    := $(wildcard schema/*.logic)
schema.outdir := $(logic.outdir)/schema
schema.ph     := $(schema.outdir)/.placeholder

$(schema.outdir): | $(logic.outdir)
	$(MKDIR) $@

$(schema.ph): $(schema.proj) $(schema.src) | $(schema.outdir)
	$(call compile-datalog-project, $<,$(@D))
	$(QUIET) touch $@

.PHONY: schema
schema: $(schema.ph)

.PHONY: schema.clean
schema.clean:
	$(RM) -r $(schema.outdir)


#-------------------------------------
#  Method-Lookup Project Creation
#-------------------------------------

lookup.proj   := method-lookup/lookup.project
lookup.src    := $(wildcard method-lookup/*.logic)
lookup.outdir := $(logic.outdir)/method-lookup
lookup.ph     := $(lookup.outdir)/.placeholder

$(lookup.outdir): | $(logic.outdir)
	$(MKDIR) $@

export LB_LIBRARY_PATH := $(schema.outdir)
$(lookup.ph): $(lookup.proj) $(lookup.src) | $(lookup.outdir)
	$(info $(LB_LIBRARY_PATH))
	$(call compile-datalog-project, $<,$(@D))
	$(QUIET) touch $@

$(lookup.ph): $(schema.ph)

.PHONY: lookup
lookup: $(lookup.ph)

.PHONY: lookup.clean
lookup.clean:
	$(RM) -r $(lookup.outdir)


#------------------------------
#  Import Project Creation
#------------------------------

import.proj   := import/import.project
import.src    := $(addprefix import/,import-entities.logic import-predicates.logic)
import.outdir := $(logic.outdir)/import
import.ph     := $(import.outdir)/.placeholder

$(import.outdir): | $(logic.outdir)
	$(MKDIR) $@


# Generate protobuf messages for schema

schema.pb  := $(schema.src:schema/%.logic=$(import.outdir)/%.pb)

.INTERMEDIATE: $(schema.pb)

export PATH := $(INSTALL_BIN):$(PATH)
$(schema.pb): $(import.outdir)/%.pb: schema/%.logic | $(schema.ph) $(import.outdir)
	$(call generate-protobuf-message,$(schema.outdir)/$*.lbb,$@)


# Generate import logic

export PATH := $(INSTALL_BIN):$(PATH)
$(import.src): $(schema.pb)
	$(importgen.exe) --dir . --delim '\t' -o import $^

export LB_LIBRARY_PATH := $(schema.outdir)
$(import.ph): $(import.proj) $(import.src) | $(import.outdir)
	$(info $(LB_LIBRARY_PATH))
	$(call compile-datalog-project, $<,$(@D))
	$(QUIET) touch $@

$(import.ph): $(schema.ph)

.PHONY: import
import: $(import.ph)

.PHONY: import.clean
import.clean:
	$(RM) -r $(import.outdir)
	$(RM) import/import-entities.logic
	$(RM) import/import-predicates.logic

# TODO add generated source files to clean
# TODO include non-generated logic files as source

#-----------------------------------
# Phony targets
#-----------------------------------

.PHONY: all
all: $(schema.ph) $(lookup.ph) $(import.ph)

.PHONY: clean
clean: schema.clean lookup.clean import.clean
	$(RM) -r $(logic.outdir)


# define process-script
#   $(M4) --define=ENTITIES=$(entities)     \
#         --define=PREDICATES=$(predicates) \
#         --define=SCHEMA=$(logic.outdir)   \
#         --define=WORKSPACE=$(workspace)   \
#         $(logic.tmpl) > $1
# endef
