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
SCRIPTGEN   = $(BINDIR)/generate-import.sh
LOGICGEN    = $(BINDIR)/import-logic-gen

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
AUTOIMPORT = $(LOGIC_SRCDIR)/import/parse.logic


all: compile
compile: $(LOGIC_TARGET)

##############
# Deployment #
##############

# TODO: fix by adding script
deploy: $(AUTOIMPORT)
	$(LOGICRT) -db $(DB) -create -overwrite
	$(LOGICRT) -db $(DB) -addProject $(LOGIC_OUTDIR)
	$(LOGICRT) -db $(DB) -import $(ENTITIES)
	$(LOGICRT) -db $(DB) -import $(PREDICATES)
	$(LOGICRT) -db $(DB) -execute -file $(AUTOIMPORT)

cleandb:
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

cleanimport:
	rm -rf $(IMPORTDIR)
	rm -f $(AUTOIMPORT)

#######################
# Datalog Compilation #
#######################

$(LOGIC_TARGET): $(LOGIC_LBSPEC) $(LOGIC) | $(LOGIC_OUTDIR)
	$(LOGICC) $(LOGICCFLAGS) $< -outDir $(@D)
	@touch $@

######################
# Create directories #
######################

$(OUTDIR) $(LOGIC_OUTDIR) $(IMPORTDIR):
	mkdir $@

$(IMPORTDIR) $(LOGIC_OUTDIR): | $(OUTDIR)

#################
# Phony Targets #
#################

.PHONY: all compile clean cleanall 
.PHONY: deploy cleandb 
.PHONY: import cleanimport

cleanall:
	rm -rf $(OUTDIR)

clean: cleanimport cleandb
