# Directory depth
LEVEL := ..

# Placeholder
all:

# Import common Makefile routines
include $(LEVEL)/common.mk
include blox.mk

# Generate build directory for logic
$(eval $(call create-destdir,logic))

# Projects
projects := schema import method-lookup


#-----------------------------------
# Phony targets
#-----------------------------------

all:

install:

clean:
	$(RM) -r $(logic.outdir)

.PHONY: all clean install


#------------------------------
#  Project Creation Template
#------------------------------

define project_template

$1.proj   := $1/$1.project
$1.src    := $(wildcard $1/*.logic)
$1.outdir := $(logic.outdir)/$1
$1.ph     := $$($1.outdir)/.placeholder

# Create output directory
$$($1.outdir): | $(logic.outdir)
	$(MKDIR) $$@

# Set LB_LIBRARY_PATH
ifneq ($1,schema)
  export LB_LIBRARY_PATH := $(schema.outdir)
endif

# Compile project
$$($1.ph): $$($1.proj) $$($1.src) | $$($1.outdir)
	$(call compile-datalog-project, $$<,$$(@D))
	$(QUIET) touch $$@

# Project build target
.PHONY: $1
$1: $$($1.ph)

# Project clean target
.PHONY: $1.clean
$1.clean:
	$(RM) -r $$($1.outdir)

# Phony target dependencies
all: $1
clean: $1.clean

endef

# !! Generate rules per project !!
$(foreach project,$(projects),$(eval $(call project_template,$(project))))


#------------------------------
#  Project Inter-Dependencies
#------------------------------

$(import.ph): $(schema.ph)
$(method-lookup.ph): $(schema.ph)



#------------------------------
#  Generate Import Sources
#------------------------------

schema.pb   := $(schema.src:schema/%.logic=$(import.outdir)/%.pb)
export PATH := $(INSTALL_BIN):$(PATH)

# Generate protobuf messages from schema
.INTERMEDIATE: $(schema.pb)
$(schema.pb): $(import.outdir)/%.pb: $(schema.ph) | $(import.outdir)
	$(call generate-protobuf-message,$(schema.outdir)/$*.lbb,$@)

# Generate import sources; this will recreate $(import.src) files
.PHONY: import.src
import.src: $(schema.pb)
	$(importgen.exe) --ignore import/.ignored-predicates --dir $(data.link) --delim '\t' -o import $^



#------------------------------
#  Template Script Creation
#------------------------------

template.in  := $(template.lb)
template.out := $(INSTALL_BIN)/$(template.lb)

define process-script
  $(M4) --define=SCHEMA=$(schema.outdir:$(LEVEL)/%=./%)         \
		--define=IMPORT=$(import.outdir:$(LEVEL)/%=./%)         \
        --define=LOOKUP=$(method-lookup.outdir:$(LEVEL)/%=./%)  \
        $2 > $1
endef

$(template.out): $(template.in)
	$(call process-script,$@,$<)

install: $(template.out)
