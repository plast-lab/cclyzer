# LogicBlox Tools

define compile-datalog-project
  bloxcompiler compileProject -outDir $2 $1
endef

define deploy-datalog-project
  bloxbatch -script $1
endef
