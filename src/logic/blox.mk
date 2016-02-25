#------------------
# LogicBlox Tools
#------------------

BLOXCOMPILER_VERSION := $(shell bloxcompiler -version 2>/dev/null || bloxcompiler version 2>/dev/null)

# Compile project command
ifneq (,$(findstring 3.9,$(BLOXCOMPILER_VERSION)))
  define compile-datalog-project
    bloxcompiler -compileProject $1 -outDir $2
  endef
else
  define compile-datalog-project
    bloxcompiler compileProject -outDir $2 $1
  endef
endif

# Execute datalog script command
define deploy-datalog-project
  bloxbatch -script $1
endef
