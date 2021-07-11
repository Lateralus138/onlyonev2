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

# ANDTSTDYNDIR=$(ANDTSTDIR)/dynamic
# ANDTSTSTTDIR=$(ANDTSTDIR)/static

# MACTSTDYNDIR=$(MACTSTDIR)/dynamic
# MACTSTSTTDIR=$(MACTSTDIR)/static

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

SRCPTH=$(SRCDIR)/$(SRC)

CF_STATIC=-static -static-libgcc -static-libstdc++

CF_DBG=-g -Wall -Wextra -fsanitize=leak -fsanitize=address -std=c++17
CF_DBG_STATIC=-g -Wall -Wextra $(CF_STATIC) -std=c++17
CF_REL=-O2 -std=c++17
CF_REL_STATIC=-O2 $(CF_STATIC) -std=c++17
CF_AND=$(CF_REL) -march=armv8-a
CF_AND_STATIC=$(CF_AND) $(CF_STATIC)

TSTARG=--help

$(SRCNAM): $(SRCPTH)
	rm -rf $(LINRELDYNDIR)
	mkdir -p $(LINRELDYNDIR)
	$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINRELDYNDIR)/$(BIN)

static: $(SRCPTH)
	rm -rf $(LINRELSTTDIR)
	mkdir -p $(LINRELSTTDIR)
	$(CC) $(CF_REL_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINRELSTTDIR)/$(BIN)

android: $(SRCPTH)
	rm -rf $(ANDRELDYNDIR)
	mkdir -p $(ANDRELDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDRELDYNDIR)/$(BIN)

androidstatic: $(SRCPTH)
	rm -rf $(ANDRELSTTDIR)
	mkdir -p $(ANDRELSTTDIR)
	$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDRELSTTDIR)/$(BIN)

macos:
	rm -rf $(MACRELDYNDIR)
	mkdir -p $(MACRELDYNDIR)
	$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACRELDYNDIR)/$(BIN)

# macosstatic:
# 	rm -rf $(MACRELSTTDIR)
# 	mkdir -p $(MACRELSTTDIR)
# 	$(CC) $(CF_REL_STATIC) -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACRELSTTDIR)/$(BIN)

debug:
	rm -rf $(LINDBGDYNDIR)
	mkdir -p $(LINDBGDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINDBGDYNDIR)/$(BIN)

debugstatic:
	rm -rf $(LINDBGSTTDIR)
	mkdir -p $(LINDBGSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINDBGSTTDIR)/$(BIN)

debugandroid:
	rm -rf $(ANDDBGDYNDIR)
	mkdir -p $(ANDDBGDYNDIR)
	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDDBGDYNDIR)/$(BIN)

debugandroidstatic:
	rm -rf $(ANDDBGSTTDIR)
	mkdir -p $(ANDDBGSTTDIR)
	$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDDBGSTTDIR)/$(BIN)

debugmacos:
	rm -rf $(MACDBGDYNDIR)
	mkdir -p $(MACDBGDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACDBGDYNDIR)/$(BIN)

debugmacosstatic:
	rm -rf $(MACDBGSTTDIR)
	mkdir -p $(MACDBGSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACDBGSTTDIR)/$(BIN)

test:
	rm -rf $(LINTSTDYNDIR)
	mkdir -p $(LINTSTDYNDIR)
	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINTSTDYNDIR)/$(BIN)
	./$(LINTSTDYNDIR)/$(BIN) $(TSTARG)

teststatic:
	rm -rf $(LINTSTSTTDIR)
	mkdir -p $(LINTSTSTTDIR)
	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(LINTSTSTTDIR)/$(BIN)
	./$(LINTSTSTTDIR)/$(BIN) $(TSTARG)

# testandroid:
# 	rm -rf $(ANDTSTDYNDIR)
# 	mkdir -p $(ANDTSTDYNDIR)
# 	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDTSTDYNDIR)/$(BIN)
# 	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

# testandroidstatic:
# 	rm -rf $(ANDTSTDYNDIR)
# 	mkdir -p $(ANDTSTDYNDIR)
# 	$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(ANDTSTDYNDIR)/$(BIN)
# 	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

# testmacos:
# 	rm -rf $(MACTSTDYNDIR)
# 	mkdir -p $(MACTSTDYNDIR)
# 	$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACTSTDYNDIR)/$(BIN)
# 	./$(MACTSTDYNDIR)/$(BIN) $(TSTARG)

# testmacosstatic:
# 	rm -rf $(MACTSTSTTDIR)
# 	mkdir -p $(MACTSTSTTDIR)
# 	$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) -o $(MACTSTSTTDIR)/$(BIN)
# 	./$(MACTSTSTTDIR)/$(BIN) $(TSTARG)

install: $(SRCNAM)
	cp -f "$(LINRELDYNDIR)/$(BIN)" "/usr/bin/$(BIN)"

installstatic: static
	cp -f "$(LINRELSTTDIR)/$(BIN)" "/usr/bin/$(BIN)"

clean:
	rm -rf $(RELDIR)
	rm -rf $(TSTDIR)
	rm -rf $(DBGDIR)

