LEVEL := .

all:

module.logic    := logic
module.csv      := csvgen
modules         := $(module.logic) $(module.csv)
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
