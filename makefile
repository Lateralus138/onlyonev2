# This is a general template and not all of the sections
# may apply to the project.

CC=g++-9
ACC=arm-linux-gnueabi-g++-9

SRCDIR=src
TSTDIR=test
DBGDIR=debug
RELDIR=release
LINRELDIR=$(RELDIR)/linux
ANDRELDIR=$(RELDIR)/android
MACRELDIR=$(RELDIR)/macos
LINDBGDIR=$(DBGDIR)/linux
ANDDBGDIR=$(DBGDIR)/android
MACDBGDIR=$(DBGDIR)/macos
LINTSTDIR=$(TSTDIR)/linux
ANDTSTDIR=$(TSTDIR)/android
MACTSTDIR=$(TSTDIR)/macos
LINTSTDYNDIR=$(LINTSTDIR)/dynamic
LINTSTSTTDIR=$(LINTSTDIR)/static
ANDTSTDYNDIR=$(ANDTSTDIR)/dynamic
ANDTSTSTTDIR=$(ANDTSTDIR)/static
MACTSTDYNDIR=$(MACTSTDIR)/dynamic
MACTSTSTTDIR=$(MACTSTDIR)/static
LINDBGDYNDIR=$(LINDBGDIR)/dynamic
LINDBGSTTDIR=$(LINDBGDIR)/static
ANDDBGDYNDIR=$(ANDDBGDIR)/dynamic
ANDDBGSTTDIR=$(ANDDBGDIR)/static
MACDBGDYNDIR=$(MACDBGDIR)/dynamic
MACDBGSTTDIR=$(MACDBGDIR)/static
LINRELDYNDIR=$(LINRELDIR)/dynamic
LINRELSTTDIR=$(LINRELDIR)/static
ANDRELDYNDIR=$(ANDRELDIR)/dynamic
ANDRELSTTDIR=$(ANDRELDIR)/static
MACRELDYNDIR=$(MACRELDIR)/dynamic
MACRELSTTDIR=$(MACRELDIR)/static
LIBDIR=$(SRCDIR)/lib
INCDIR=$(SRCDIR)/include

BIN=onlyone

SRCNAM=main
SRCEXT=cpp
SRC=$(SRCNAM).$(SRCEXT)

EXTRA_CPP=src/functions.cpp src/colorize.cpp
SRCPTH=$(SRCDIR)/$(SRC)

CF_STATIC=-static -static-libgcc -static-libstdc++
# CF_GTK=`pkg-config --cflags --libs gtk+-3.0`
CF_GTK=
CF_DBG=-g -Wall -Wextra -fsanitize=address -fsanitize=undefined -fno-sanitize-recover=all -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-sanitize=null -fno-sanitize=alignment -std=c++17
CF_DBG_STATIC=$(CF_STATIC) $(CF_DBG)
CF_REL=-O2 -std=c++17
CF_REL_STATIC=$(CF_STATIC) $(CF_REL)
CF_AND=$(CF_REL) -march=armv8-a
CF_AND_STATIC=$(CF_STATIC) $(CF_AND)

TSTARG=-help

$(SRCNAM): $(SRCPTH) $(EXTRA_CPP)
	rm -rf $(LINRELDYNDIR)
	mkdir -p $(LINRELDYNDIR)
	$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINRELDYNDIR)/$(BIN) $(CF_GTK)

static: $(SRCPTH) $(EXTRA_CPP)
	rm -rf $(LINRELSTTDIR)
	mkdir -p $(LINRELSTTDIR)
	$(CC) $(CF_REL_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINRELSTTDIR)/$(BIN) $(CF_GTK)

android: $(SRCPTH) $(EXTRA_CPP)
	rm -rf $(ANDRELDYNDIR)
	mkdir -p $(ANDRELDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDRELDYNDIR)/$(BIN) $(CF_GTK)

androidstatic: $(SRCPTH) $(EXTRA_CPP)
	rm -rf $(ANDRELSTTDIR)
	mkdir -p $(ANDRELSTTDIR)
	$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDRELSTTDIR)/$(BIN) $(CF_GTK)

macos:
	rm -rf $(MACRELDYNDIR)
	mkdir -p $(MACRELDYNDIR)
	$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACRELDYNDIR)/$(BIN) $(CF_GTK)

macosstatic:
	rm -rf $(MACRELSTTDIR)
	mkdir -p $(MACRELSTTDIR)
	$(CC) $(CF_REL_STATIC) -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACRELSTTDIR)/$(BIN)

debug:
	rm -rf $(LINDBGDYNDIR)
	mkdir -p $(LINDBGDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINDBGDYNDIR)/$(BIN) $(CF_GTK)

debugstatic:
	rm -rf $(LINDBGSTTDIR)
	mkdir -p $(LINDBGSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINDBGSTTDIR)/$(BIN) $(CF_GTK)

debugandroid:
	rm -rf $(ANDDBGDYNDIR)
	mkdir -p $(ANDDBGDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDDBGDYNDIR)/$(BIN) $(CF_GTK)

debugandroidstatic:
	rm -rf $(ANDDBGSTTDIR)
	mkdir -p $(ANDDBGSTTDIR)
	$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDDBGSTTDIR)/$(BIN) $(CF_GTK)

debugmacos:
	rm -rf $(MACDBGDYNDIR)
	mkdir -p $(MACDBGDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACDBGDYNDIR)/$(BIN) $(CF_GTK)

debugmacosstatic:
	rm -rf $(MACDBGSTTDIR)
	mkdir -p $(MACDBGSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACDBGSTTDIR)/$(BIN) $(CF_GTK)

test:
	rm -rf $(LINTSTDYNDIR)
	mkdir -p $(LINTSTDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINTSTDYNDIR)/$(BIN) $(CF_GTK)
	./$(LINTSTDYNDIR)/$(BIN) $(TSTARG)

teststatic:
	rm -rf $(LINTSTSTTDIR)
	mkdir -p $(LINTSTSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(LINTSTSTTDIR)/$(BIN) $(CF_GTK)
	./$(LINTSTSTTDIR)/$(BIN) $(TSTARG)

testandroid:
	rm -rf $(ANDTSTDYNDIR)
	mkdir -p $(ANDTSTDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDTSTDYNDIR)/$(BIN)
	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

testandroidstatic:
	rm -rf $(ANDTSTDYNDIR)
	mkdir -p $(ANDTSTDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(ANDTSTDYNDIR)/$(BIN)
	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

testmacos:
	rm -rf $(MACTSTDYNDIR)
	mkdir -p $(MACTSTDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACTSTDYNDIR)/$(BIN)
	./$(MACTSTDYNDIR)/$(BIN) $(TSTARG)

testmacosstatic:
	rm -rf $(MACTSTSTTDIR)
	mkdir -p $(MACTSTSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_CPP) -o $(MACTSTSTTDIR)/$(BIN)
	./$(MACTSTSTTDIR)/$(BIN) $(TSTARG)

install: $(SRCNAM)
	cp -f "$(LINRELDYNDIR)/$(BIN)" "/usr/bin/$(BIN)"

installstatic: static
	cp -f "$(LINRELSTTDIR)/$(BIN)" "/usr/bin/$(BIN)"

clean:
	rm -rf $(RELDIR)
	rm -rf $(TSTDIR)
	rm -rf $(DBGDIR)
