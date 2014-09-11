LEVEL := ..

# Placeholder
all:

.PHONY: all clean

# Import common Makefile routines
include $(LEVEL)/common.mk


# Generate build directories for this module

$(eval $(call create-destdir,python,python))

sources := $(filter-out Makefile,$(wildcard *))
archive := $(python.outdir)/llvm-datalog.zip


# Build python archive

$(archive): $(sources) | $(python.outdir)
	zip -r $@ $(sources)


# Phony targets

all: $(archive)

clean:
	$(RM) -r $(python.outdir)
