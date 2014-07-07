# LogicBlox Tools

define compile-datalog-project
  bloxcompiler compileProject -outDir $2 $1
endef

define deploy-datalog-project
  bloxbatch -script $1
endef

define generate-protobuf-message
  $(info Generating protobuf message file for $1 ...)
  bloxdisassembler -p $1 > $2
  $(QUIET) cut-protobuf-message.sh $2 > tmp.pb
  $(QUIET) mv tmp.pb $2
endef
