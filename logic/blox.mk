# LogicBlox Tools

define compile-datalog-project
  bloxcompiler compileProject -outDir $2 $1
endef

define deploy-datalog-project
  bloxbatch -script $1
endef

define generate-protobuf-message
  bloxdisassembler -p $1 > $(1:%.lbb=%.pb)
  cut-protobuf-message.sh $(1:%.lbb=%.pb) > tmp.pb
  mv tmp.pb $(1:%.lbb=%.pb)
endef
