LD = /usr/bin/ld.gold
CC = clang
CCFLAGS = -flto
COPPER = ../build/dist/llvm-datalog

all:

#--------------------
# Clang Unit Tests
#--------------------

srcdir       := .
outdir       := ./build
dbdir        := ./db
examples.c   := $(wildcard $(srcdir)/*.c)
examples.cpp := $(wildcard $(srcdir)/*.cpp)
examples.bc  := $(examples.c:$(srcdir)/%.c=$(outdir)/%.bc)
examples.bc  += $(examples.cpp:$(srcdir)/%.cpp=$(outdir)/%.bc)

targets      := $(examples.bc)

vpath %.cpp $(srcdir)
vpath %.c   $(srcdir)
vpath %.bc  $(outdir)


#-------------------
# Unit tests in C
#-------------------

all: $(targets)

$(targets): | $(outdir)

$(outdir):
	mkdir $@

# Target specific options
$(outdir)/%.bc : CCFLAGS += -emit-llvm
# $(outdir)/%.bc : CCFLAGS += -Wl,-plugin-opt=also-emit-llvm


# Recipes
$(outdir)/%.bc : %.c
	$(CC) $(CCFLAGS) -c $< -o $@

$(outdir)/%.bc : %.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

.PHONY: all clean run

clean:
	rm -rf $(outdir)


#----------------------------
# Example Template
#----------------------------

define example_template

$1.db := $(dbdir)/$1

example-$1: $1.bc
	@echo ---------------------------------------
	@echo "   >>> Running example $1 <<<   "
	@echo ---------------------------------------
	@echo
	$(COPPER) -o $$($1.db) $(COPPER_OPTS) $$<
	@echo
	@echo

.PHONY: example-$1.clean
example-$1.clean:
	$(RM) -r $$($1.db)/

run: example-$1
clean: example-$1.clean

endef


# !! Generate rules per example !!
$(foreach example,$(examples.bc),$(eval $(call example_template,$(example:$(outdir)/%.bc=%))))
