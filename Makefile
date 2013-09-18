DB = test
DATA   = ./facts
IMPORT = ./import
LOGIC  = ./logic
SCHEMA = $(LOGIC)/schema.logic
IMPORT_BLOCK = $(LOGIC)/parse.logic
GEN = ./generate-import.sh

# Entities
ENTITIES = $(DATA)/entities
ENTITY_FILES = $(wildcard $(ENTITIES)/*.dlm)
ENTITY_IMPORTS = $(ENTITY_FILES:$(ENTITIES)/%.dlm=$(IMPORT)/%.import)
ENTITY_SCRIPT = $(IMPORT)/entities.import

# Predicates
PREDICATES=$(DATA)/predicates
PREDICATE_FILES = $(wildcard $(PREDICATES)/*.dlm)
PREDICATE_IMPORTS = $(PREDICATE_FILES:$(PREDICATES)/%.dlm=$(IMPORT)/%.import)
PREDICATE_SCRIPT = $(IMPORT)/predicates.import

all: import-predicates

create:
	bloxbatch -db $(DB) -create -overwrite
	bloxbatch -db $(DB) -addBlock -file $(SCHEMA)

delete:
	rm -rf $(DB)/

import-entities: $(ENTITY_SCRIPT)
	bloxbatch -db $(DB) -import $<

import-predicates: $(PREDICATE_SCRIPT)
	bloxbatch -db $(DB) -import $<
	bloxbatch -db $(DB) -execute -file $(IMPORT_BLOCK)

# Generate .import files

$(ENTITY_IMPORTS): $(IMPORT)/%.import: $(ENTITIES)/%.dlm
	$(GEN) $< > $@

$(PREDICATE_IMPORTS): $(IMPORT)/%.import: $(PREDICATES)/%.dlm
	$(GEN) $< > $@

# Collect all generated .import files into one

$(ENTITY_SCRIPT): $(ENTITY_IMPORTS)
	@echo "option,delimiter,\"	\"" > $@
	@echo "option,hasColumnNames,false" >> $@
	@cat $^ >> $@

$(PREDICATE_SCRIPT): $(PREDICATE_IMPORTS)
	@echo "option,delimiter,\"	\"" > $@
	@echo "option,hasColumnNames,false" >> $@
	@cat $^ >> $@


# Additional dependencies
import-predicates: import-entities
import-entities: create

$(ENTITY_IMPORTS): $(GEN)
$(PREDICATE_IMPORTS): $(GEN)


.PHONY: all create delete import-entities import-predicates
