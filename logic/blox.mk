# LogicBlox Tools

define compile-datalog-project
  bloxcompiler -compileProject $1 -outDir $2
endef

define deploy-datalog-project
  bloxbatch -script $1
endef
