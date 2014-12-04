CC = clang
CCFLAGS = -S -emit-llvm

####################
# Clang Unit Tests #
####################

SRCDIR   = .
OUTDIR   = ./build
EXAMPLES = $(wildcard $(SRCDIR)/*.c)

###################
# Unit tests in C #
###################

all: examples
examples: $(EXAMPLES:$(SRCDIR)/%.c=$(OUTDIR)/%.s)

$(OUTDIR)/%.s : $(SRCDIR)/%.c | $(OUTDIR)
	$(CC) $(CCFLAGS) $< -o $@

$(OUTDIR):
	mkdir $@

.PHONY: all examples
