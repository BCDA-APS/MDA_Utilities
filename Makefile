

prefix     = /usr/local
bindir     = $(prefix)/bin
mandir     = $(prefix)/man/man1
includedir = $(prefix)/include
libdir     = $(prefix)/lib



export CC = gcc
export AR = ar
export CFLAGS = -Wall -O2

# for debugging
#CFLAGS += -g

OSTYPE := $(shell uname -s)
ifeq ($(OSTYPE),Darwin)
  CFLAGS += -D DARWIN
endif

####  Windows  ################################################
# For Windows cross-compiling, you need to uncomment XDR LE support
# (below), as well as the following line (for allowing backslashes).
# CFLAGS += -D WINDOWS
###############################################################

####  XDR  ##############################################################
# To use routines included for XDR decoding, uncomment next two lines,
# and one (and only one) of the last two lines.
# Only use this if your OS doesn't provide XDR functions!
#export MORE_OBJS = xdr_hack.o 
#CFLAGS += -D XDR_HACK
# Sets endianess: BE = big-endian, LE = little-endian
#CFLAGS += -D XDR_BE
#CFLAGS += -D XDR_LE
#########################################################################


all:
	make -C src all
	make -C doc all

clean:
	make -C src clean
	make -C doc clean


INSTALL_MKDIR = mkdir -p
INSTALL_EXE   = install -c -m 0755
INSTALL_OTHER = install -c -m 0644
UNINSTALL_RM = -rm

install : all
	$(INSTALL_MKDIR) $(DESTDIR)$(bindir)
	$(INSTALL_MKDIR) $(DESTDIR)$(libdir)
	$(INSTALL_MKDIR) $(DESTDIR)$(includedir)
	$(INSTALL_MKDIR) $(DESTDIR)$(mandir)
	$(INSTALL_EXE) src/mda-ls $(DESTDIR)$(bindir)/
	$(INSTALL_EXE) src/mda-info $(DESTDIR)$(bindir)/
	$(INSTALL_EXE) src/mda-dump $(DESTDIR)$(bindir)/
	$(INSTALL_EXE) src/mda2ascii $(DESTDIR)$(bindir)/
	$(INSTALL_EXE) src/mdatree2ascii $(DESTDIR)$(bindir)/
	$(INSTALL_OTHER) src/libmda-load.a $(DESTDIR)$(libdir)/
	$(INSTALL_OTHER) src/mda-load.h $(DESTDIR)$(includedir)/
	$(INSTALL_OTHER) doc/mda-ls.1 $(DESTDIR)$(mandir)/
	$(INSTALL_OTHER) doc/mda-info.1 $(DESTDIR)$(mandir)/
	$(INSTALL_OTHER) doc/mda-dump.1 $(DESTDIR)$(mandir)/
	$(INSTALL_OTHER) doc/mda2ascii.1 $(DESTDIR)$(mandir)/
	$(INSTALL_OTHER) doc/mdatree2ascii.1 $(DESTDIR)$(mandir)/

uninstall :
	$(UNINSTALL_RM) $(DESTDIR)$(bindir)/mda-ls
	$(UNINSTALL_RM) $(DESTDIR)$(bindir)/mda-info
	$(UNINSTALL_RM) $(DESTDIR)$(bindir)/mda-dump
	$(UNINSTALL_RM) $(DESTDIR)$(bindir)/mda2ascii
	$(UNINSTALL_RM) $(DESTDIR)$(bindir)/mdatree2ascii
	$(UNINSTALL_RM) $(DESTDIR)$(libdir)/libmda-load.a
	$(UNINSTALL_RM) $(DESTDIR)$(includedir)/mda-load.h
	$(UNINSTALL_RM) $(DESTDIR)$(mandir)/mda-ls.1
	$(UNINSTALL_RM) $(DESTDIR)$(mandir)/mda-info.1
	$(UNINSTALL_RM) $(DESTDIR)$(mandir)/mda-dump.1
	$(UNINSTALL_RM) $(DESTDIR)$(mandir)/mda2ascii.1
	$(UNINSTALL_RM) $(DESTDIR)$(mandir)/mdatree2ascii.1

