LD = /usr/bin/ld.gold
CC = clang
CCFLAGS = -flto

all:

#--------------------
# Clang Unit Tests
#--------------------

srcdir      := .
outdir      := ./build
examples.c  := $(wildcard $(srcdir)/*.c)
examples.o  := $(examples.c:$(srcdir)/%.c=$(outdir)/%.o)
examples.s  := $(examples.c:$(srcdir)/%.c=$(outdir)/%.s)
examples.bc := $(examples.c:$(srcdir)/%.c=$(outdir)/%.bc)

targets     := $(examples.o) $(examples.s) # $(examples.bc)

vpath %.c $(srcdir)
vpath %.o $(outdir)


#-------------------
# Unit tests in C
#-------------------

all: $(targets)

$(targets): | $(outdir)

$(outdir):
	mkdir $@

# Target specific options
$(outdir)/%.s  : CCFLAGS += -S -emit-llvm
$(outdir)/%.bc : CCFLAGS += -Wl,-plugin-opt=also-emit-llvm


# Recipes
$(outdir)/%.o  : %.c
	$(CC) -c $(CCFLAGS) $< -o $@

$(outdir)/%.s  : %.c
	$(CC) -c $(CCFLAGS) $< -o $@

$(outdir)/%.bc : %.o
	$(CC) $(CCFLAGS) $^ -o $*

.PHONY: all clean

clean:
	rm -rf $(outdir)
