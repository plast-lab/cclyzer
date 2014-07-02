# LogicBlox Tools

define compile-datalog-project
  bloxcompiler compileProject -outDir $2 $1
endef

define deploy-datalog-project
  bloxbatch -script $1
endef

define generate-protobuf-message
  bloxdisassembler -p $1 > $2
  cut-protobuf-message.sh $2 > tmp.pb
  mv tmp.pb $2
endef
