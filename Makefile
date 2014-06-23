LEVEL := .

all:

module.logic    := logic
module.facts    := fact-generator
module.imports  := import-generator
modules         := $(module.logic) $(module.facts) $(module.imports)
targets.clean   := $(addsuffix .clean,$(modules))
targets.install := $(addsuffix .install,$(modules))

include common.mk


#--------------------------
# Accumulating Rules
#--------------------------

$(modules):
	$(MAKE) --directory=$@

$(targets.clean): %.clean:
	$(MAKE) --directory=$* clean

$(targets.install): %.install:
	$(MAKE) --directory=$* install


#--------------------------
# Phony Targets
#--------------------------

.PHONY: all $(modules)
all: $(modules)

.PHONY: clean $(targets.clean)
clean: $(targets.clean)
	$(RM) -r $(OUTDIR)/

.PHONY: install $(targets.install)
install: $(targets.install)


.PHONY: deploy
deploy:
	$(MAKE) --directory=logic deploy
