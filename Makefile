# Directories
SRCDIR  = ./src
BINDIR  = ./bin
OUTDIR  = ./build
DATADIR = ./data

# Datalog and misc tools
LOGICRT     = bloxbatch
LOGICC      = bloxcompiler
LOGICCFLAGS = -compileProject
INSTALL     = install
SCRIPTGEN   = $(BINDIR)/generate-import-script
LOGICGEN    = $(BINDIR)/generate-import-logic

# Database
DB = $(OUTDIR)/db

###########
# Datalog #
###########

LOGIC_SRCDIR = $(SRCDIR)/datalog
LOGIC_OUTDIR = $(OUTDIR)/datalog
LOGIC_LBSPEC = $(LOGIC_SRCDIR)/llvm.project
LOGIC_TARGET = $(LOGIC_OUTDIR)/.comp.lock

LOGIC := $(wildcard $(LOGIC_SRCDIR)/schema/*.logic)
LOGIC += $(wildcard $(LOGIC_SRCDIR)/import/*.logic)

###############################
# CSV data and import scripts #
###############################

IMPORTDIR  = $(OUTDIR)/import

# For import scripts
ENTCSV     = $(notdir $(wildcard $(DATADIR)/entities/*.dlm))
PRDCSV     = $(notdir $(wildcard $(DATADIR)/predicates/*.dlm))
ENTITIES   = $(IMPORTDIR)/entities.import
PREDICATES = $(IMPORTDIR)/predicates.import

# For file predicates
AUTOPRED   = $(LOGIC_SRCDIR)/import/.autopred
AUTOIMPORT = $(LOGIC_SRCDIR)/import/operand-specific.logic
AUTOBLOCK  = $(AUTOIMPORT:$(LOGIC_SRCDIR)/import/%.logic=import:%)


all: compile
compile: $(LOGIC_TARGET)

##############
# Deployment #
##############

deploy: $(LOGIC_TARGET) $(ENTITIES) $(PREDICATES)
	$(LOGICRT) -db $(DB) -create -overwrite
	$(LOGICRT) -db $(DB) -installProject -dir $(LOGIC_OUTDIR)
	@rm -f $(OUTDIR)/$(DATADIR)
	@ln -rs $(DATADIR) $(OUTDIR)
	$(LOGICRT) -db $(DB) -import $(ENTITIES)
	$(LOGICRT) -db $(DB) -import $(PREDICATES)
	$(LOGICRT) -db $(DB) -execute -name $(AUTOBLOCK)

clean-db:
	rm -rf $(DB)/

############################
# Import scripts and logic #
############################

# Generate import logic (file predicates)

$(AUTOIMPORT): %.logic: $(AUTOPRED) $(LOGICGEN)
	cat $< | $(LOGICGEN) "$(DATADIR)" > $@

# Generate .import scripts

$(IMPORTDIR)/%.import: $(DATADIR)/entities/%.dlm 
	$(SCRIPTGEN) $< > $@

$(IMPORTDIR)/%.import: $(DATADIR)/predicates/%.dlm
	$(SCRIPTGEN) $< > $@

$(ENTCSV:%.dlm=$(IMPORTDIR)/%.import): $(SCRIPTGEN) | $(IMPORTDIR)
$(PRDCSV:%.dlm=$(IMPORTDIR)/%.import): $(SCRIPTGEN) | $(IMPORTDIR)

# Collect all generated .import files into one

$(ENTITIES): $(ENTCSV:%.dlm=$(IMPORTDIR)/%.import)
	@echo "option,delimiter,\"	\"" > $@
	@echo "option,hasColumnNames,false" >> $@
	@cat $^ >> $@

$(PREDICATES): $(PRDCSV:%.dlm=$(IMPORTDIR)/%.import)
	@echo "option,delimiter,\"	\"" > $@
	@echo "option,hasColumnNames,false" >> $@
	@cat $^ >> $@

# Phony targets
import: $(ENTITIES) $(PREDICATES) $(AUTOIMPORT)

clean-import:
	rm -f $(AUTOIMPORT)
	rm -rf $(IMPORTDIR)

#######################
# Datalog Compilation #
#######################

$(LOGIC_TARGET): $(LOGIC_LBSPEC) | $(LOGIC_OUTDIR)
	$(LOGICC) $(LOGICCFLAGS) $< -outDir $(@D)
	@touch $@

$(LOGIC_TARGET): $(LOGIC) $(AUTOIMPORT)

######################
# Create directories #
######################

$(OUTDIR) $(LOGIC_OUTDIR) $(IMPORTDIR):
	mkdir $@

$(IMPORTDIR) $(LOGIC_OUTDIR): | $(OUTDIR)

#################
# Phony Targets #
#################

.PHONY: all compile clean
.PHONY: deploy clean-db 
.PHONY: import clean-import

clean: clean-import clean-db
	rm -rf $(OUTDIR)
