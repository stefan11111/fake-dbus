.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -Wall -Wno-pedantic
XLDFLAGS = ${LDFLAGS} -shared -Wl

all: libdbus-glib-1.so.2

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libdbus-glib-1.so.2:
	${CC} ${XCFLAGS} libdbus-glib-1.c -o libdbus-glib-1.so.2 ${XLDFLAGS},-soname,libdbus-glib-1.so.2

install: libdbus-glib-1.so.2
	mkdir -p ${DESTDIR}/usr/lib64
	cp -f libdbus-glib-1.so.2 ${DESTDIR}/usr/lib64
#	mkdir -p ${DESTDIR}/usr/lib64/pkgconfig
#	cp -f pc/* ${DESTDIR}/usr/lib64/pkgconfig
#	mkdir -p ${DESTDIR}/usr/include/gtk-2.0/gtk
#	cp -rf headers/* ${DESTDIR}/usr/include/gtk-2.0
uninstall:
	rm -f ${DESTDIR}/usr/lib64/libdbus-glib-1.so.2

clean:
	rm -f libdbus-glib-1.so.2

.PHONY: all clean install uninstall
