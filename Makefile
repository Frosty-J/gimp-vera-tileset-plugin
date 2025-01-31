GIMPTOOL = gimptool-2.0
PROGRAM = vera_tileset
GCC = gcc
GIMPCFLAGS = $(shell gimptool-2.0 --cflags)
GIMPLIBS = $(shell gimptool-2.0 --libs)
WARNING_POLICY = -Wno-deprecated-declarations -Wall
XML2CFLAGS = $(shell xml2-config --cflags)
XML2LIBS = $(shell xml2-config --libs)
TILE_UI_FILE = plug-in-file-vera-tiles.ui
SELECTOR_UI_FILE = plug-in-file-vera-selector.ui
BITMAP_UI_FILE = plug-in-file-vera-bitmap.ui

$(PROGRAM): vera_tileset.c
	$(GCC) $(GIMPCFLAGS) $(XML2CFLAGS) $(WARNING_POLICY) -o $(PROGRAM) vera_tileset.c $(GIMPLIBS) $(XML2LIBS)

install: $(PROGRAM)
	$(GIMPTOOL) --install-bin $(PROGRAM)

install-ui:
	cp $(TILE_UI_FILE) `$(GIMPTOOL) --gimpdatadir`/ui/plug-ins/$(TILE_UI_FILE)
	cp $(SELECTOR_UI_FILE) `$(GIMPTOOL) --gimpdatadir`/ui/plug-ins/$(SELECTOR_UI_FILE)
	cp $(BITMAP_UI_FILE) `$(GIMPTOOL) --gimpdatadir`/ui/plug-ins/$(BITMAP_UI_FILE)

uninstall: $(PROGRAM)
	$(GIMPTOOL) --uninstall-bin $(PROGRAM)
	rm `$(GIMPTOOL) --gimpdatadir`/ui/plug-ins/$(TILE_UI_FILE)
	rm `$(GIMPTOOL) --gimpdatadir`/ui/plug-ins/$(SELECTOR_UI_FILE)

all: $(PROGRAM)

run: install
	gimp

tags:
	ctags * --recurse

clean:
	rm -f *.o $(PROGRAM)

