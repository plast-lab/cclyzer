LEVEL := ..

# Placeholder
all:

install:

.PHONY: all clean install

# Import common Makefile routines
include $(LEVEL)/common.mk


# Generate build directories for this module

$(eval $(call create-destdir,python,python))

sources := $(filter-out ./Makefile,$(shell find -type f))
archive := $(python.outdir)/llvm-datalog.zip


# Build python archive

$(archive): $(sources) | $(python.outdir)
	zip -r $@ $(sources)


# Phony targets

all: $(archive)

clean:
	$(RM) -r $(python.outdir)
