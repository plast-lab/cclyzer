LEVEL := .

all:

module.logic  := logic
module.csv    := csvgen
modules       := $(module.logic)
targets.clean := $(addsuffix .clean,$(modules))

include common.mk

# Accumulating Rules

$(modules):
	$(MAKE) --directory=$@

$(targets.clean): %.clean:
	$(MAKE) --directory=$* clean


# Phony Targets

.PHONY: all $(modules)
all: $(modules)

.PHONY: clean $(targets.clean)
clean: $(targets.clean)
	$(RM) -r $(OUTDIR)/

.PHONY: deploy
deploy:
	$(MAKE) --directory=logic deploy
